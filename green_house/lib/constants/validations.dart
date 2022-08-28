

class AppValidations{
  static String? validateEmail(String? value) {
    RegExp regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$");
    if (value!.isEmpty) return "Required";
    if (!regex.hasMatch(value)) {
      return 'Please enter valid email';
    } else {
      return null;
    }
  }
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (value.length<6) {
      return "Password length should be atleast 6";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "required";
    }
    else {
      return null;
    }
  }

  static String? validateRequired(String? value) {
    if (value!.isEmpty) {
      return "required";
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