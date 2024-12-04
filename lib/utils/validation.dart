bool validatePassword(String password) {
  if (password.isEmpty) {
    return false;
  }
  final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{8,}$');
  return regex.hasMatch(password);
}

bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  }
  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(emailPattern);
  return regex.hasMatch(email);
}

String toTitleCase(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

bool validateName(String name) {
  if (name.isEmpty) {
    return false;
  }
  final nameRegExp = RegExp(r'^[a-zA-Z]+$');
  // RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  return nameRegExp.hasMatch(name);
}

bool validatePhone(String phone) {
  final phoneRegExp = RegExp(r'(^(?:[+0]1)?[0-9]{8,12}$)');
  return phoneRegExp.hasMatch(phone);
}
