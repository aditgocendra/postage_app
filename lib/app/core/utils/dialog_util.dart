import 'package:check_postage_app/app/core/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtility {
  static void dialogWarning(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: 'Ok',
    );
  }

  static void snackbarDialog(String title, String message) {
    Get.snackbar(
      'Snackbar',
      'message',
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.redAccent),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: blackColor),
      ),
      backgroundColor: whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 84),
      borderRadius: 12,
    );
  }
}
