import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_snackbar.dart';

class ForgotPassController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      successSnackBar(
          "Se ha enviado a su correo un enlace para restaurar la contraseña");
      emailController.clear();
      // Enviar correo electrónico de restablecimiento de contraseña
    } catch (e) {
      // Manejar errores
      errorSnackBar(
          "No se pudo completar la solicitud. Intenta de nuevo en un momento");
    }
  }
}
