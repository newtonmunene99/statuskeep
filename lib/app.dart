import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statuskeep/app/routes/router.gr.dart';
import 'package:statuskeep/app/services/storage_service.dart';
import 'package:statuskeep/app/services/theme_service.dart';
import 'package:statuskeep/app/utils/sorting.dart';

import 'package:statuskeep/config/flavors.dart';
import 'package:statuskeep/utils/flavor_banner.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

/// Custom [MaterialColor]
const MaterialColor waGreen = MaterialColor(
  0xFF075E54,
  {
    50: Color.fromRGBO(7, 94, 84, .1),
    100: Color.fromRGBO(7, 94, 84, .2),
    200: Color.fromRGBO(7, 94, 84, .3),
    300: Color.fromRGBO(7, 94, 84, .4),
    400: Color.fromRGBO(7, 94, 84, .5),
    500: Color.fromRGBO(7, 94, 84, .6),
    600: Color.fromRGBO(7, 94, 84, .7),
    700: Color.fromRGBO(7, 94, 84, .8),
    800: Color.fromRGBO(7, 94, 84, .9),
    900: Color.fromRGBO(7, 94, 84, 1),
  },
);

/// Custom [MaterialColor]
const MaterialColor waLightGreen = MaterialColor(
  0xFF25D366,
  {
    50: Color.fromRGBO(37, 211, 102, .1),
    100: Color.fromRGBO(37, 211, 102, .2),
    200: Color.fromRGBO(37, 211, 102, .3),
    300: Color.fromRGBO(37, 211, 102, .4),
    400: Color.fromRGBO(37, 211, 102, .5),
    500: Color.fromRGBO(37, 211, 102, .6),
    600: Color.fromRGBO(37, 211, 102, .7),
    700: Color.fromRGBO(37, 211, 102, .8),
    800: Color.fromRGBO(37, 211, 102, .9),
    900: Color.fromRGBO(37, 211, 102, 1),
  },
);

/// The root app widget. Builds a [MaterialApp] as the root widget.
class StatusKeepApp extends StatefulWidget {
  @override
  _StatusKeepAppState createState() => _StatusKeepAppState();
}

class _StatusKeepAppState extends State<StatusKeepApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Injector(
      inject: [
        Inject<SharedPreferences>.future(
          () => SharedPreferences.getInstance(),
          isLazy: false,
        ),
        Inject<AppThemeService>.future(
          () async => AppThemeService(
            await RM.get<SharedPreferences>().stateAsync,
            themeMode: RM
                .get<SharedPreferences>()
                .state
                .getInt('themeMode')
                .toThemeMode(),
          ),
          isLazy: false,
        ),
        Inject<SortOptions>(() => SortOptions.DATE_ASC),
        Inject<TypeOptions>(() => TypeOptions.ALL),
        Inject<StorageService>(() => StorageService()),
      ],
      builder: (context) {
        return FlavorBanner(
          bannerConfig: BannerConfig(
            bannerName: FlavorConfig.instance.name,
            bannerColor: FlavorConfig.instance.color,
          ),
          child: StateBuilder<AppThemeService>(
              observe: () => RM.get<AppThemeService>(),
              builder: (context, appThemeServiceRM) {
                ThemeMode appThemeMode;

                if (appThemeServiceRM.hasData) {
                  appThemeMode = appThemeServiceRM.state.themeMode;
                }

                return MaterialApp(
                  title: "Statuskeep",
                  theme: _theme.copyWith(
                    brightness: Brightness.light,
                    primaryColor: waLightGreen,
                    accentColor: waGreen,
                    appBarTheme: _theme.appBarTheme.copyWith(
                      brightness: Brightness.light,
                      color: Colors.white,
                      elevation: defaultTargetPlatform == TargetPlatform.android
                          ? 4.0
                          : 0.0,
                      textTheme: TextTheme(
                        headline6: GoogleFonts.titilliumWeb(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.black,
                      ),
                    ),
                    bottomSheetTheme: _theme.bottomSheetTheme.copyWith(
                      backgroundColor: Colors.white,
                    ),
                    textTheme: _theme.textTheme.copyWith(
                      bodyText1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.bodyText1.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      bodyText2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.bodyText2.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline1.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline2.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline3: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline3.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline4: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline4.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline5: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline5.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      headline6: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline6.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.subtitle1.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      subtitle2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.subtitle2.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      button: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.button.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    buttonTheme: _theme.buttonTheme.copyWith(
                      buttonColor: Colors.orange,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(75),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    popupMenuTheme: _theme.popupMenuTheme.copyWith(
                      color: Colors.white,
                      textStyle: _theme.textTheme.button.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: _theme.inputDecorationTheme.copyWith(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                    ),
                  ),
                  darkTheme: _theme.copyWith(
                    brightness: Brightness.dark,
                    primaryColor: waLightGreen,
                    accentColor: waGreen,
                    backgroundColor: Colors.black,
                    bottomAppBarColor: Colors.black,
                    dialogBackgroundColor: Colors.black,
                    scaffoldBackgroundColor: Colors.black,
                    appBarTheme: _theme.appBarTheme.copyWith(
                      brightness: Brightness.dark,
                      color: Colors.black,
                      elevation: Platform.isIOS ? 0 : 2,
                    ),
                    bottomSheetTheme: _theme.bottomSheetTheme.copyWith(
                      backgroundColor: Colors.black,
                    ),
                    textTheme: _theme.textTheme.copyWith(
                      bodyText1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.bodyText1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      bodyText2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.bodyText2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline3: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline4: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline4.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline5: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline5.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      headline6: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle1: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.subtitle1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      subtitle2: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.subtitle2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      button: GoogleFonts.titilliumWeb(
                        textStyle: _theme.textTheme.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    buttonTheme: _theme.buttonTheme.copyWith(
                      buttonColor: Colors.orange,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(75),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    popupMenuTheme: _theme.popupMenuTheme.copyWith(
                      color: Colors.black,
                      textStyle: _theme.textTheme.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    inputDecorationTheme: _theme.inputDecorationTheme.copyWith(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(75),
                      ),
                    ),
                  ),
                  themeMode: appThemeMode ?? ThemeMode.system,
                  builder: ExtendedNavigator.builder<Router>(
                    name: "rootRouter",
                    router: Router(),
                  ),
                );
              }),
        );
      },
    );
  }
}
