import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mime/mime.dart';

/// Media utilities
class MediaUtils {
  /// Determine if a file is an image
  static bool isImage(String name) {
    final _extension = name.split(".").last;

    return ["jpg", "jpeg", "png"].contains(_extension);
  }

  /// Determine if a file is a video
  static bool isVideo(String name) {
    final _extension = name.split(".").last;

    return ["mp4"].contains(_extension);
  }

  /// Save image to downloads folder
  static Future<bool> saveToDownloads(String path, String name) async {
    if (isImage(name)) {
      return GallerySaver.saveImage(path, albumName: 'Downloads');
    }

    if (isVideo(name)) {
      return GallerySaver.saveVideo(path, albumName: 'Downloads');
    }

    return null;
  }

  /// Share a file
  static Future<void> share(String name, Uint8List mediaBytes) async {
    await Share.file(
      name,
      name,
      mediaBytes,
      lookupMimeType(name),
    );
  }
}
