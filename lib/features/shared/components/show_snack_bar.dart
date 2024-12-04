import 'package:flutter/material.dart';

Future<void> showSnackBar({
  required BuildContext context,
  required String message,
  Duration? duration,
  Color? backgroundColor, // You can set a default color
  SnackBarAction? action, // This can be optional
}) async {
  final snackBar = SnackBar(
    duration: duration ?? const Duration(seconds: 2),
    content: Text(message),
    backgroundColor: backgroundColor,
    action: action,
  );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarController =
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  await snackBarController.closed;
}
