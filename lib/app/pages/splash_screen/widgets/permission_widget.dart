import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Widget to be shown when asking for permission
class PermissionWidget extends StatefulWidget {
  /// The message to show the user. Should a description of why you need the permission.
  final String message;

  /// The permission to request.
  final Permission permission;

  /// Widget to be shown when asking for permission
  const PermissionWidget({
    @required this.message,
    @required this.permission,
    Key key,
  }) : super(key: key);

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.message,
              style: _theme.textTheme.bodyText1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                color: _theme.primaryColor,
                onPressed: () async {
                  try {
                    final granted = await widget.permission.request();

                    Navigator.pop(context, granted.isGranted);
                  } catch (e) {
                    Navigator.pop(context, false);
                  }
                },
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                child: Text(
                  "Allow",
                  style: _theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
