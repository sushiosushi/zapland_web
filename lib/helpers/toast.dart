import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

Future<bool?> showToast(String message) async {
  return Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      backgroundColor: Colors.black87,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.TOP);
}

Future<void> showToastification(BuildContext context, String message,
    {String? description}) async {
  toastification.show(
    context: context,
    alignment: Alignment.topCenter,
    title: Text(message),
    description: description != null ? Text(description) : null,
    autoCloseDuration: const Duration(seconds: 5),
    style: ToastificationStyle.flatColored,
    type: ToastificationType.success,
  );
}
