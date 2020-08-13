import 'package:flutter/material.dart';

/// Widget to be shown when some permissions have been denied
class DeniedPermissionWidget extends StatefulWidget {
  /// The message to show the user. Should a description of why you need the permission.
  final String message;

  /// Widget to be shown when some permissions have been denied
  const DeniedPermissionWidget({
    @required this.message,
    Key key,
  }) : super(key: key);

  @override
  _DeniedPermissionWidgetState createState() => _DeniedPermissionWidgetState();
}

class _DeniedPermissionWidgetState extends State<DeniedPermissionWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      height: 250,
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
                  Navigator.pop(context, "request");
                },
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                child: Text(
                  "Request Permissions",
                  style: _theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context, "settings");
                },
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                child: Text(
                  "Open Settings",
                  style: _theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
