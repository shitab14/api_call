import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CommonUtil {
  static final instance = CommonUtil();

  /// Internet Check
  Future<bool> internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  /// Show Toast
  void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

}