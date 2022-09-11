class AppValidations {
  static String? validateEmail(String? value) {
    RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");
    if (value!.isEmpty) return "Requerido";
    if (!regex.hasMatch(value)) {
      return 'Por favor inserte un correo valido';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "requerido";
    }
    if (value.length < 6) {
      return "La contraseña debe tener almenos 6 caracteres";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Requerido";
    } else {
      return null;
    }
  }

  static String? validateRequired(String? value) {
    if (value!.isEmpty) {
      return "Requerido";
    } else {
      return null;
    }
  }

  static String? validateOptional(String? value) {
    if (value!.isEmpty) {
      return null;
    }
  }
}
