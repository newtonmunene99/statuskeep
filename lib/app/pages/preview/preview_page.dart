import 'dart:io';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:statuskeep/app/utils/toast.dart';
import 'package:statuskeep/app/widgets/image_preview.dart';
import 'package:statuskeep/app/widgets/video_preview.dart';
import 'package:statuskeep/app/services/storage_service.dart';
import 'package:statuskeep/app/utils/media_utils.dart';

/// Preview page. Shows a preview of image or video
class PreviewPage extends StatefulWidget {
  /// Index of the media
  final int index;

  /// Preview page. Shows a preview of image or video
  const PreviewPage({
    @required this.index,
    Key key,
  }) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _storageServiceRM = RM.get<StorageService>();

    final _deviceWidth = MediaQuery.of(context).size.width;

    final _currentPage = RM.create<int>(widget.index);

    return Scaffold(
      body: WhenRebuilderOr<StorageService>(
        observe: () => _storageServiceRM,
        builder: (_, storageRM) {
          return Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (pageIndex) {
                    _currentPage.state = pageIndex;
                  },
                  controller: _pageController,
                  itemBuilder: (_, index) {
                    final mediaEntity = storageRM.state.media[index];

                    final mediaFile = File(mediaEntity.path);

                    final fileName = mediaFile.uri.pathSegments.last;

                    if (MediaUtils.isImage(fileName)) {
                      return ImagePreview(
                        key: ValueKey(mediaFile.path),
                        image: mediaFile,
                        isFullPreview: true,
                      );
                    }

                    if (MediaUtils.isVideo(fileName)) {
                      return VideoPreview(
                        key: ValueKey(mediaFile.path),
                        video: mediaFile,
                        isFullPreview: true,
                      );
                    }

                    return Container();
                  },
                  itemCount: storageRM.state.media.length,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                height: 100,
                width: _deviceWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
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
                              color: Colors.white,
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
                bottom: 0,
                left: 0,
                height: 60,
                width: _deviceWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                  ),
                  child: SizedBox.expand(
                    child: StateBuilder<int>(
                      observe: () => _currentPage,
                      builder: (_, currentPageRM) {
                        final mediaEntity =
                            _storageServiceRM.state.media[currentPageRM.state];

                        final mediaFile = File(mediaEntity.path);

                        final fileName = mediaFile.uri.pathSegments.last;

                        final isImage = MediaUtils.isImage(fileName);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.file_download,
                                ),
                                color: Colors.white,
                                onPressed: () async {
                                  final loadingIndicator =
                                      CommonToasts.loadingToast(context);

                                  try {
                                    await MediaUtils.saveToDownloads(
                                      mediaEntity.path,
                                      fileName,
                                    );

                                    await loadingIndicator.dismiss();

                                    CommonToasts.successToast(
                                      context,
                                      message:
                                          "${isImage ? 'Image' : 'Video'} has been successfully downloaded.",
                                    );
                                  } catch (e) {
                                    await loadingIndicator.dismiss();

                                    CommonToasts.errorToast(
                                      context,
                                      message:
                                          "We're unable to copy this file at the moment",
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.share,
                                ),
                                color: Colors.white,
                                onPressed: () async {
                                  try {
                                    final mediaBytes =
                                        await mediaFile.readAsBytes();

                                    await MediaUtils.share(
                                      fileName,
                                      mediaBytes,
                                    );
                                  } catch (e) {
                                    CommonToasts.errorToast(
                                      context,
                                      message:
                                          "We're unable to share this file at the moment",
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
