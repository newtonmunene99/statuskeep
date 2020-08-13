import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Holds commonly used toasts
class CommonToasts {
  /// Returns a success toast
  /// Call `show` and pass the context
  static Flushbar successToast(BuildContext context,
      {String message,
      Duration duration,
      Function(FlushbarStatus) onStatusChanged}) {
    final _theme = Theme.of(context);

    return Flushbar(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: 75,
      isDismissible: false,
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      backgroundColor: Colors.grey,
      duration: duration ?? const Duration(seconds: 4),
      reverseAnimationCurve: Curves.easeOut,
      messageText: Text(
        message ?? "Operation Successful",
        style: _theme.textTheme.button.copyWith(
          color: Colors.white,
        ),
      ),
      mainButton: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        textColor: Colors.white,
        child: const Text("Okay"),
      ),
    )..show(context);
  }

  /// Returns an info toast
  /// Call `show` and pass the context
  static Flushbar infoToast(BuildContext context,
      {String message,
      Duration duration,
      Function(FlushbarStatus) onStatusChanged}) {
    return Flushbar(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: 75,
      isDismissible: false,
      backgroundColor: Colors.grey[300],
      duration: duration ?? const Duration(seconds: 4),
      reverseAnimationCurve: Curves.easeOut,
      messageText: Text(
        message ?? "Operation Successful",
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    )..show(context);
  }

  /// Returns a failure toast
  /// Call `show` and pass the context
  static Flushbar errorToast(BuildContext context,
      {String message, Duration duration}) {
    final _theme = Theme.of(context);

    return Flushbar(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      borderRadius: 75,
      isDismissible: false,
      icon: const Icon(
        Icons.warning,
        color: Colors.red,
      ),
      backgroundColor: Colors.grey[300],
      duration: duration ?? const Duration(seconds: 4),
      reverseAnimationCurve: Curves.easeOut,
      messageText: Text(
        message ?? "We seem to have ran into an issue",
        style: _theme.textTheme.button.copyWith(
          color: Colors.black,
        ),
      ),
      mainButton: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        textColor: Colors.black,
        child: const Text("Okay"),
      ),
    )..show(context);
  }

  /// Returns a loading toast
  /// Call `show` and pass the context
  static Flushbar loadingToast(BuildContext context,
      {String message, Duration duration}) {
    final ThemeData _theme = Theme.of(context);

    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: false,
      icon: const Icon(
        Feather.info,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      backgroundColor: _theme.primaryColor,
      routeBlur: 5,
      blockBackgroundInteraction: true,
      duration: duration,
      reverseAnimationCurve: Curves.easeOut,
      titleText: const Text(
        "Please wait",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message ?? "Kindly be patient",
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}
