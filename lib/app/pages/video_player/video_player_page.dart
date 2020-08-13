import 'dart:io';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:video_player/video_player.dart';

/// Shows a preview of the video
class VideoPlayerPage extends StatefulWidget {
  /// The video file
  final File video;

  /// Shows a preview of the video
  const VideoPlayerPage({
    @required this.video,
    Key key,
  }) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPlayerPage> {
  ReactiveModel<VideoPlayerController> _videoPlayerRM;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Future<void> _initVideoPlayer() async {
    final _videoPlayerController = VideoPlayerController.file(widget.video);
    _videoPlayerRM = RM.create<VideoPlayerController>(_videoPlayerController);

    await _videoPlayerRM.setState(
      (currentState) => currentState.initialize(),
      shouldAwait: true,
      filterTags: ["root"],
    );

    _videoPlayerRM.state.addListener(() async {
      _videoPlayerRM.notify(["play_state", "position"]);

      if (_videoPlayerRM.state.value.position.inSeconds ==
          _videoPlayerRM.state.value.duration.inSeconds) {
        await _videoPlayerRM.setState(
          (currentState) => currentState.pause(),
          shouldAwait: true,
        );
        await _videoPlayerRM.setState(
          (currentState) => currentState.seekTo(Duration.zero),
          shouldAwait: true,
        );
      }
    });

    await _videoPlayerRM.setState(
      (currentState) => currentState.play(),
      shouldAwait: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      body: StateBuilder<VideoPlayerController>(
        tag: "root",
        observe: () => _videoPlayerRM,
        builder: (_, playerRM) {
          if (!playerRM.state.value.initialized) {
            return Container();
          }

          return Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: playerRM.state.value.aspectRatio,
                  child: VideoPlayer(playerRM.state),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                height: 100,
                width: _deviceWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24.withOpacity(0.9),
                  ),
                  child: SafeArea(
                    child: SizedBox.expand(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: _deviceWidth,
                bottom: 10,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      StateBuilder<VideoPlayerController>(
                        tag: "play_state",
                        observe: () => playerRM,
                        builder: (_, playingStateRM) {
                          return IconButton(
                            iconSize: 32,
                            icon: Icon(
                              playingStateRM.state.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                            ),
                            color: _theme.primaryColor,
                            onPressed: () async {
                              if (playingStateRM.state.value.isPlaying) {
                                return _videoPlayerRM.setState(
                                  (currentState) => currentState.pause(),
                                  filterTags: ["play_state"],
                                );
                              }

                              _videoPlayerRM.setState(
                                (currentState) => currentState.play(),
                                filterTags: ["play_state"],
                              );
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: StateBuilder<VideoPlayerController>(
                          tag: "position",
                          observe: () => playerRM,
                          builder: (_, playingPositionRM) {
                            final _fullDuration =
                                playingPositionRM.state.value.duration;
                            final _currentPosition =
                                playingPositionRM.state.value.position;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          "00:${_currentPosition.inSeconds.toString().padLeft(2, '0')}"),
                                      Text(
                                          "00:${_fullDuration.inSeconds.toString().padLeft(2, '0')}"),
                                    ],
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 4,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 5,
                                    child: Slider(
                                      activeColor: _theme.primaryColor,
                                      max: playingPositionRM
                                          .state.value.duration.inSeconds
                                          .toDouble(),
                                      value: playingPositionRM
                                          .state.value.position.inSeconds
                                          .toDouble(),
                                      onChanged: (value) {
                                        final duration =
                                            Duration(seconds: value.toInt());

                                        playerRM.setState(
                                          (currentState) =>
                                              currentState.seekTo(duration),
                                          filterTags: ["position"],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerRM.state.dispose();
    super.dispose();
  }
}
