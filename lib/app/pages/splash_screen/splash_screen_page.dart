import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:statuskeep/app.dart';
import 'package:statuskeep/app/pages/splash_screen/widgets/denied_permission_widget.dart';
import 'package:statuskeep/app/pages/splash_screen/widgets/permission_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statuskeep/app/routes/router.gr.dart';

/// Splash screen page
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  /// The permissions that thhe app needs
  final _permissionsNeeded = [
    {
      "message": "Statuskeep needs to access your storage to work properly.",
      "permission": Permission.storage,
    },
  ];

  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => _setUpAndInit(),
    );
    super.initState();
  }

  void _setUpAndInit() {
    _checkPermissions().then((permissions) {
      if (permissions.isNotEmpty) {
        showModalBottomSheet<String>(
          context: context,
          isDismissible: false,
          builder: (modalContext) => const DeniedPermissionWidget(
            message: "This app may not work well without some permissions",
          ),
        ).then((res) {
          switch (res) {
            case "request":
              _setUpAndInit();
              break;
            case "settings":
              break;
            default:
          }
        });
      } else {
        _navigateToMedia();
      }
    });
  }

  Future<List<Permission>> _checkPermissions() async {
    final List<Permission> _permissionsDenied = [];

    for (final permission in _permissionsNeeded) {
      final _permission = permission["permission"] as Permission;

      final _message = permission["message"] as String;

      if (!(await _permission.isGranted)) {
        final allowed = await showModalBottomSheet<bool>(
          context: context,
          isDismissible: false,
          builder: (modalContext) => PermissionWidget(
            message: _message,
            permission: _permission,
          ),
        );

        if (allowed != null) {
          if (!allowed) _permissionsDenied.add(_permission);
        } else {
          _permissionsDenied.add(_permission);
        }
      }
    }
    return _permissionsDenied;
  }

  void _navigateToMedia() {
    Timer(const Duration(seconds: 1), () {
      ExtendedNavigator.root
          .pushAndRemoveUntil(Routes.MediaPageRoute, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: waGreen,
        ),
        child: const Center(
          child: Text(
            "Statuskeep",
            style: TextStyle(
              fontSize: 40,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
