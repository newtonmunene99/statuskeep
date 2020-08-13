import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:statuskeep/app/widgets/image_preview.dart';
import 'package:statuskeep/app/widgets/video_preview.dart';
import 'package:statuskeep/app/routes/router.gr.dart';
import 'package:statuskeep/app/services/storage_service.dart';
import 'package:statuskeep/app/utils/sorting.dart';
import 'package:statuskeep/app/utils/media_utils.dart';

/// Media page
class MediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _sortOptionsRM = RM.get<SortOptions>();
    final _typesOptionsRM = RM.get<TypeOptions>();
    final _storageServiceRM = RM.get<StorageService>()
      ..setState(
        (currentState) => currentState.getFiles(
          sortOptions: _sortOptionsRM.state,
          type: _typesOptionsRM.state,
        ),
        shouldAwait: true,
      );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: _deviceHeight * 0.25,
            backgroundColor: _theme.primaryColor,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Statuskeep"),
            ),
          ),
          SliverPersistentHeader(
            delegate: SliverCustomAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: StateBuilder<TypeOptions>(
                    observe: () => _typesOptionsRM,
                    builder: (context, typeOptionsModel) {
                      return PopupMenuButton<TypeOptions>(
                        onSelected: (options) {
                          _typesOptionsRM.state = options;

                          _storageServiceRM.setState(
                            (currentState) => currentState.getFiles(
                              type: options,
                              sortOptions: _sortOptionsRM.state,
                            ),
                            shouldAwait: true,
                          );
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                        tooltip: "Show",
                        itemBuilder: (_) => <PopupMenuEntry<TypeOptions>>[
                          PopupMenuItem(
                            value: TypeOptions.ALL,
                            child: Text(
                              "All",
                              style: _theme.textTheme.button.copyWith(
                                color: typeOptionsModel.state == TypeOptions.ALL
                                    ? _theme.primaryColor
                                    : _theme.textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TypeOptions.IMAGES,
                            child: Text(
                              "Images",
                              style: _theme.textTheme.button.copyWith(
                                color:
                                    typeOptionsModel.state == TypeOptions.IMAGES
                                        ? _theme.primaryColor
                                        : _theme.textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: TypeOptions.VIDEOS,
                            child: Text(
                              "Videos",
                              style: _theme.textTheme.button.copyWith(
                                color:
                                    typeOptionsModel.state == TypeOptions.VIDEOS
                                        ? _theme.primaryColor
                                        : _theme.textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                        ],
                        child: AbsorbPointer(
                          child: FlatButton(
                            color: _theme.colorScheme.onPrimary,
                            onPressed: () {},
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(75.0),
                              borderSide: BorderSide.none,
                            ),
                            child: Text('Show ${typeOptionsModel.state.name}'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: StateBuilder<SortOptions>(
                    observe: () => _sortOptionsRM,
                    builder: (context, sortOptionsModel) {
                      return PopupMenuButton<SortOptions>(
                        onSelected: (options) {
                          _sortOptionsRM.state = options;

                          _storageServiceRM.setState(
                            (currentState) => currentState.getFiles(
                              type: _typesOptionsRM.state,
                              sortOptions: options,
                            ),
                            shouldAwait: true,
                          );
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                        tooltip: "Sort by",
                        itemBuilder: (_) => <PopupMenuEntry<SortOptions>>[
                          PopupMenuItem(
                            value: SortOptions.DATE_ASC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color:
                                  sortOptionsModel.state == SortOptions.DATE_ASC
                                      ? _theme.primaryColor
                                      : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Date Ascending"),
                          ),
                          PopupMenuItem(
                            value: SortOptions.DATE_DESC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color: sortOptionsModel.state ==
                                      SortOptions.DATE_DESC
                                  ? _theme.primaryColor
                                  : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Date Descending"),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: SortOptions.NAME_ASC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color:
                                  sortOptionsModel.state == SortOptions.NAME_ASC
                                      ? _theme.primaryColor
                                      : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Name Ascending"),
                          ),
                          PopupMenuItem(
                            value: SortOptions.NAME_DESC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color: sortOptionsModel.state ==
                                      SortOptions.NAME_DESC
                                  ? _theme.primaryColor
                                  : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Name Descending"),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: SortOptions.SIZE_ASC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color:
                                  sortOptionsModel.state == SortOptions.SIZE_ASC
                                      ? _theme.primaryColor
                                      : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Size Ascending"),
                          ),
                          PopupMenuItem(
                            value: SortOptions.SIZE_DESC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color: sortOptionsModel.state ==
                                      SortOptions.SIZE_DESC
                                  ? _theme.primaryColor
                                  : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Size Descending"),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: SortOptions.TYPE_ASC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color:
                                  sortOptionsModel.state == SortOptions.TYPE_ASC
                                      ? _theme.primaryColor
                                      : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Type Ascending"),
                          ),
                          PopupMenuItem(
                            value: SortOptions.TYPE_DESC,
                            textStyle: _theme.textTheme.button.copyWith(
                              color: sortOptionsModel.state ==
                                      SortOptions.TYPE_DESC
                                  ? _theme.primaryColor
                                  : _theme.textTheme.bodyText1.color,
                            ),
                            child: const Text("Sort by Type Descending"),
                          ),
                        ],
                        child: AbsorbPointer(
                          child: FlatButton(
                            color: _theme.colorScheme.onPrimary,
                            onPressed: () {},
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(75.0),
                              borderSide: BorderSide.none,
                            ),
                            child:
                                Text('Sort by ${sortOptionsModel.state.name}'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case "refresh":
                          {
                            _storageServiceRM.setState(
                              (currentState) => currentState.getFiles(
                                sortOptions: _sortOptionsRM.state,
                                type: _typesOptionsRM.state,
                              ),
                              shouldAwait: true,
                            );
                            break;
                          }
                        case "settings":
                          {
                            ExtendedNavigator.root.pushSettingsPageRoute();
                            break;
                          }
                        default:
                      }
                    },
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    tooltip: "Menu",
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: "refresh",
                        child: Text("Refresh"),
                      ),
                      const PopupMenuItem(
                        value: "settings",
                        child: Text("Settings"),
                      ),
                    ],
                  ),
                )
              ],
            ),
            pinned: true,
          ),
          WhenRebuilderOr<StorageService>(
            observe: () => _storageServiceRM,
            onWaiting: () => SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (_, __) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                  );
                },
                childCount: 10,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
            ),
            builder: (_, storageRM) {
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    final mediaEntity = storageRM.state.media[index];

                    final mediaFile = File(mediaEntity.path);

                    final fileName = mediaFile.uri.pathSegments.last;

                    return InkWell(
                      onTap: () {
                        ExtendedNavigator.root
                            .pushPreviewPageRoute(index: index);
                      },
                      child: Builder(
                        builder: (_) {
                          if (MediaUtils.isImage(fileName)) {
                            return ImagePreview(
                              key: ValueKey(mediaFile.path),
                              image: mediaFile,
                            );
                          }

                          if (MediaUtils.isVideo(fileName)) {
                            return VideoPreview(
                              key: ValueKey(mediaFile.path),
                              video: mediaFile,
                            );
                          }

                          return Container();
                        },
                      ),
                    );
                  },
                  childCount: storageRM.state.media.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Custom [SliverPersistentHeaderDelegate]
class SliverCustomAppBar extends SliverPersistentHeaderDelegate {
  /// Minimum height the app bar can shrink to
  final double minHeight;

  /// Maximum height the app bar can expand to
  final double maxHeight;

  /// Widgets to show on the end
  final List<Widget> actions;

  /// Background color of the appbar
  final Color color;

  /// Custom [SliverPersistentHeaderDelegate]
  SliverCustomAppBar({
    this.minHeight = 100,
    this.maxHeight = 100,
    this.actions,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ThemeData _theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      decoration: BoxDecoration(color: color ?? _theme.primaryColor),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [...actions],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.hashCode != hashCode;
}
