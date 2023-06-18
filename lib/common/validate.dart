import 'package:personajes_api_fe/common/enums.dart';

ValidateName(String value) {
  String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$';
  return RegExp(exp).hasMatch(value);
}

ValidateNum(String value) {
  String exp = r'^(?=.*[0-9])\d+$';
  return RegExp(exp).hasMatch(value);
}

ValidateNoEmpty(String value) {
  String exp = r'^[a-zA-Z0-9_@.-]+$';
  return RegExp(exp).hasMatch(value);
}

ValidatePassword(String value) {
  String exp = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$';
  return RegExp(exp).hasMatch(value);
}
