// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/media/media.dart';
import '../pages/preview/preview_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/splash_screen/splash_screen_page.dart';
import '../pages/video_player/video_player_page.dart';

class Routes {
  static const String SplashPageRoute = '/';
  static const String MediaPageRoute = '/media';
  static const String PreviewPageRoute = '/media/preview';
  static const String VideoPlayerPageRoute = '/media/preview/play-video';
  static const String SettingsPageRoute = '/settings';
  static const all = <String>{
    SplashPageRoute,
    MediaPageRoute,
    PreviewPageRoute,
    VideoPlayerPageRoute,
    SettingsPageRoute,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.SplashPageRoute, page: SplashScreenPage),
    RouteDef(Routes.MediaPageRoute, page: MediaPage),
    RouteDef(Routes.PreviewPageRoute, page: PreviewPage),
    RouteDef(Routes.VideoPlayerPageRoute, page: VideoPlayerPage),
    RouteDef(Routes.SettingsPageRoute, page: SettingsPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreenPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreenPage(),
        settings: data,
      );
    },
    MediaPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MediaPage(),
        settings: data,
        maintainState: true,
      );
    },
    PreviewPage: (data) {
      final args = data.getArgs<PreviewPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PreviewPage(
          index: args.index,
          key: args.key,
        ),
        settings: data,
      );
    },
    VideoPlayerPage: (data) {
      final args = data.getArgs<VideoPlayerPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VideoPlayerPage(
          video: args.video,
          key: args.key,
        ),
        settings: data,
      );
    },
    SettingsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSplashPageRoute() =>
      push<dynamic>(Routes.SplashPageRoute);

  Future<dynamic> pushMediaPageRoute() => push<dynamic>(Routes.MediaPageRoute);

  Future<dynamic> pushPreviewPageRoute({
    @required int index,
    Key key,
  }) =>
      push<dynamic>(
        Routes.PreviewPageRoute,
        arguments: PreviewPageArguments(index: index, key: key),
      );

  Future<dynamic> pushVideoPlayerPageRoute({
    @required File video,
    Key key,
  }) =>
      push<dynamic>(
        Routes.VideoPlayerPageRoute,
        arguments: VideoPlayerPageArguments(video: video, key: key),
      );

  Future<dynamic> pushSettingsPageRoute() =>
      push<dynamic>(Routes.SettingsPageRoute);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PreviewPage arguments holder class
class PreviewPageArguments {
  final int index;
  final Key key;
  PreviewPageArguments({@required this.index, this.key});
}

/// VideoPlayerPage arguments holder class
class VideoPlayerPageArguments {
  final File video;
  final Key key;
  VideoPlayerPageArguments({@required this.video, this.key});
}
