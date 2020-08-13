import 'dart:io';

import 'package:flutter/material.dart';

/// Shows a preview of the image
class ImagePreview extends StatefulWidget {
  /// The image file
  final File image;

  /// Determines if the image preview has been opened
  final bool isFullPreview;

  /// Shows a preview of the image
  const ImagePreview({
    @required this.image,
    this.isFullPreview = false,
    Key key,
  }) : super(key: key);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final TransformationController _transformationController =
        TransformationController();

    return Stack(
      children: [
        Positioned.fill(
          child: InteractiveViewer(
            panEnabled: widget.isFullPreview,
            scaleEnabled: widget.isFullPreview,
            transformationController: _transformationController,
            onInteractionEnd: (_) {
              setState(() {
                _transformationController.toScene(Offset.zero);
              });
            },
            minScale: 0.1,
            maxScale: 4.0,
            child: Image(
              image: FileImage(widget.image),
              fit: BoxFit.contain,
              frameBuilder:
                  (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
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
            ),
          ),
        ),
        if (widget.isFullPreview)
          Positioned(
            bottom: 60,
            right: 0,
            child: Text(
              widget.image.uri.pathSegments.last,
              style: _theme.textTheme.button,
            ),
          )
      ],
    );
  }
}
