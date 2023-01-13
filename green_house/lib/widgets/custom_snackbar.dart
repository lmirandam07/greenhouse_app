import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(String successMsg) {
  return Get.snackbar(
    "Error",
    successMsg,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.white,
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {}
    },
  );
}

successSnackBar(String successMsg) {
  return Get.snackbar(
    "Notificación",
    successMsg,
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Get.theme.primaryColor,
    colorText: Colors.white,
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {}
    },
  );
}
