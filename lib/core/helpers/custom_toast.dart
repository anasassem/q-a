import 'package:testqa/core/helpers/auth_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, info }

class CustomToast {
  static Map<ToastType, Color> toastBgColors = {
    ToastType.success: Colors.blueGrey,
    ToastType.error: Colors.red,
    ToastType.info: Colors.yellow,
  };

  static void showSnakeBar(msg,
      {Color? color,
      Color? textColor,
      ToastGravity? toastGravity,
      ToastType type = ToastType.error}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity ?? ToastGravity.CENTER,
      backgroundColor: color ?? toastBgColors[type],
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }

  static void showSimpleToast(
      {required String msg,
      Color? color,
      Color? textColor,
      ToastType type = ToastType.error}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: color ?? toastBgColors[type],
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }

  static void showPaymentDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return const BuildPaymentDialog();
      },
    );
  }
}
