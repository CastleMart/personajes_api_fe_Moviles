import 'package:personajes_api_fe/common/enums.dart';

ValidateName(String value) {
  String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ]+$';
  return RegExp(exp).hasMatch(value);
}

ValidateNum(String value) {
  String exp = r'^(?=.*[0-9])\d+$';
  return RegExp(exp).hasMatch(value);
}

ValidateNoEmpty(String value) {
  String exp = r'^.+$';
  return RegExp(exp).hasMatch(value);
}
