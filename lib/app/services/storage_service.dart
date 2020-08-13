import 'dart:io';

import 'package:flutter_file_utils/utils.dart';
import 'package:statuskeep/app/utils/sorting.dart';

/// Storage service
class StorageService {
  final _root = Directory('/storage/emulated/0/Whatsapp/Media/.Statuses');

  List<FileSystemEntity> _media = [];

  /// Whatsapp status media
  List<FileSystemEntity> get media => _media;

  /// Get files
  Future<void> getFiles({
    TypeOptions type = TypeOptions.ALL,
    SortOptions sortOptions = SortOptions.DATE_ASC,
  }) async {
    _media = await listFiles(
      _root.path,
      extensions: type.extensions,
      sortedBy: sortOptions.sortBy,
      reversed: sortOptions.direction.reversed,
    );
  }
}
