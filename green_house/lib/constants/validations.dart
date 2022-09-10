

class AppValidations {

  static String? validateEmail(String? value) {
    RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");
    if (value!.isEmpty) return "requerido";
    if (!regex.hasMatch(value)) {
      return 'Favor inserte un correo valido';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "requerido";
    }
    if (value.length < 6) {
      return "Password length should be atleast 6";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "requerido";
    } else {
      return null;
    }
  }

  static String? validateRequired(String? value) {
    if (value!.isEmpty) {
      return "requerido";
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
