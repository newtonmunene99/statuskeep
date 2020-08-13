import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:statuskeep/app/routes/router.gr.dart';

/// Shows a preview of the video
class VideoPreview extends StatelessWidget {
  /// The video file
  final File video;

  /// Determines if the video preview has been opened
  final bool isFullPreview;

  /// Shows a preview of the video
  const VideoPreview(
      {@required this.video, Key key, this.isFullPreview = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Stack(
      children: [
        Center(
          child: FutureBuilder<Uint8List>(
            future: VideoThumbnail.thumbnailData(
              video: video.path,
              quality: 25,
            ),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Image(
                  image: MemoryImage(snapshot.data),
                  fit: BoxFit.contain,
                  frameBuilder: (_, Widget child, int frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: frame != null ? child : Container(),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return const Text('😢');
                  },
                );
              }

              return Container();
            },
          ),
        ),
        if (isFullPreview)
          Positioned(
            bottom: 60,
            left: 10,
            child: OutlineButton.icon(
              icon: const Icon(Icons.play_circle_filled),
              label: const Text("Play Video"),
              textColor: _theme.primaryColor,
              borderSide: BorderSide(
                color: _theme.primaryColor,
                width: 2.0,
              ),
              onPressed: () {
                ExtendedNavigator.root.pushVideoPlayerPageRoute(video: video);
              },
            ),
          )
        else
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
