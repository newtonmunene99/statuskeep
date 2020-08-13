import 'package:flutter_file_utils/flutter_file_utils.dart';

/// What media type to show
enum TypeOptions {
  /// Show images only
  IMAGES,

  /// Show videos only
  VIDEOS,

  /// Show images and videos
  ALL,
}

/// Useful utility helper extension for [TypeOptions]
extension TypeOptionsUtils on TypeOptions {
  /// Name of the selected type
  String get name {
    switch (this) {
      case TypeOptions.ALL:
        return "All";
      case TypeOptions.IMAGES:
        return "Images";
      case TypeOptions.VIDEOS:
        return "Videos";
      default:
        return "";
    }
  }

  /// Media File extensions
  List<String> get extensions {
    switch (this) {
      case TypeOptions.IMAGES:
        return ["jpg"];
      case TypeOptions.VIDEOS:
        return ["mp4"];
      case TypeOptions.ALL:
        return ["jpg", "mp4"];
      default:
        return ["jpg"];
    }
  }
}

/// Media Sorting options.
enum SortOptions {
  /// Sort by date in ascending order
  DATE_ASC,

  /// Sort by date in ascending order
  DATE_DESC,

  /// Sort by date in ascending order
  SIZE_ASC,

  /// Sort by date in ascending order
  SIZE_DESC,

  /// Sort by date in ascending order
  NAME_ASC,

  /// Sort by date in ascending order
  NAME_DESC,

  /// Sort by date in ascending order
  TYPE_ASC,

  /// Sort by date in ascending order
  TYPE_DESC,
}

/// Useful utility helper extension for [SortOptions]
extension SortOptionsUtils on SortOptions {
  /// Name of the selected option
  String get name {
    switch (this) {
      case SortOptions.DATE_ASC:
        return "Date";
      case SortOptions.DATE_DESC:
        return "Date";
      case SortOptions.SIZE_ASC:
        return "Size";
      case SortOptions.SIZE_DESC:
        return "Size";
      case SortOptions.NAME_ASC:
        return "Name";
      case SortOptions.NAME_DESC:
        return "Name";
      case SortOptions.TYPE_ASC:
        return "Type";
      case SortOptions.TYPE_DESC:
        return "Type";
      default:
        return "";
    }
  }

  /// Determine what to sort by
  FlutterFileUtilsSorting get sortBy {
    switch (this) {
      case SortOptions.DATE_ASC:
        return FlutterFileUtilsSorting.Date;
      case SortOptions.DATE_DESC:
        return FlutterFileUtilsSorting.Date;
      case SortOptions.SIZE_ASC:
        return FlutterFileUtilsSorting.Size;
      case SortOptions.SIZE_DESC:
        return FlutterFileUtilsSorting.Size;
      case SortOptions.NAME_ASC:
        return FlutterFileUtilsSorting.Alpha;
      case SortOptions.NAME_DESC:
        return FlutterFileUtilsSorting.Alpha;
      case SortOptions.TYPE_ASC:
        return FlutterFileUtilsSorting.Type;
      case SortOptions.TYPE_DESC:
        return FlutterFileUtilsSorting.Type;
      default:
        return FlutterFileUtilsSorting.Date;
    }
  }

  /// Determine if the direction of results.
  SortDirection get direction {
    switch (this) {
      case SortOptions.DATE_ASC:
        return SortDirection.ASC;
      case SortOptions.DATE_DESC:
        return SortDirection.DESC;
      case SortOptions.SIZE_ASC:
        return SortDirection.ASC;
      case SortOptions.SIZE_DESC:
        return SortDirection.DESC;
      case SortOptions.NAME_ASC:
        return SortDirection.ASC;
      case SortOptions.NAME_DESC:
        return SortDirection.DESC;
      case SortOptions.TYPE_ASC:
        return SortDirection.ASC;
      case SortOptions.TYPE_DESC:
        return SortDirection.DESC;
      default:
        return SortDirection.DESC;
    }
  }
}

/// Sorting direction
enum SortDirection {
  /// Sort in ascending order
  ASC,

  /// Sort in descending order
  DESC,
}

/// Useful utility helpers for [SortDirection]
extension SortDirectionUtils on SortDirection {
  /// Determine if the search result should be reversed
  bool get reversed {
    switch (this) {
      case SortDirection.ASC:
        return true;
      case SortDirection.DESC:
        return false;
      default:
        return false;
    }
  }
}
