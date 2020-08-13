import 'package:auto_route/auto_route_annotations.dart';
import 'package:statuskeep/app/pages/media/media.dart';
import 'package:statuskeep/app/pages/preview/preview_page.dart';
import 'package:statuskeep/app/pages/settings/settings_page.dart';
import 'package:statuskeep/app/pages/splash_screen/splash_screen_page.dart';
import 'package:statuskeep/app/pages/video_player/video_player_page.dart';

/// Holds all of the app's routes
@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(
      page: SplashScreenPage,
      initial: true,
      name: "SplashPageRoute",
    ),
    MaterialRoute(
      maintainState: true,
      page: MediaPage,
      path: "/media",
      name: "MediaPageRoute",
    ),
    MaterialRoute(
      page: PreviewPage,
      path: "/media/preview",
      name: "PreviewPageRoute",
    ),
    MaterialRoute(
      page: VideoPlayerPage,
      path: "/media/preview/play-video",
      name: "VideoPlayerPageRoute",
    ),
    MaterialRoute(
      page: SettingsPage,
      path: "/settings",
      name: "SettingsPageRoute",
    ),
  ],
)
class $Router {}
