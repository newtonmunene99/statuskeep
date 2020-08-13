import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:statuskeep/app/services/theme_service.dart';

/// Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          StateBuilder<AppThemeService>(
            observe: () => RM.get<AppThemeService>(),
            builder: (context, appThemeServiceRM) {
              ThemeMode appThemeMode;

              if (appThemeServiceRM.hasData) {
                appThemeMode = appThemeServiceRM.state.themeMode;
              }

              return ListTile(
                title: const Text("Theme"),
                trailing: Text(
                  appThemeMode.name(),
                  style: _theme.textTheme.button,
                ),
                onTap: () async {
                  final ThemeMode selectedThemeMode =
                      await showDialog<ThemeMode>(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text("App Theme"),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, ThemeMode.system);
                            },
                            child: Text(
                              "System",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appThemeMode.toInt() == 0
                                    ? _theme.primaryColor
                                    : _theme.textTheme.subtitle1.color,
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, ThemeMode.light);
                            },
                            child: Text(
                              "Light",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appThemeMode.toInt() == 1
                                    ? _theme.primaryColor
                                    : _theme.textTheme.subtitle1.color,
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, ThemeMode.dark);
                            },
                            child: Text(
                              "Dark",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appThemeMode.toInt() == 2
                                    ? _theme.primaryColor
                                    : _theme.textTheme.subtitle1.color,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (selectedThemeMode != null) {
                    await appThemeServiceRM.setState(
                      (currentState) =>
                          currentState.changeTheme(selectedThemeMode),
                      shouldAwait: true,
                    );
                  }
                },
              );
            },
          ),
          FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final packageInfo = snapshot.data;

                  return AboutListTile(
                    applicationName: packageInfo.appName,
                    applicationVersion: packageInfo.version,
                  );
                }

                return const ListTile(
                  title: Text("About"),
                );
              }),
        ],
      ),
    );
  }
}
