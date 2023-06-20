import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personajes_api_fe/common/enums.dart';
import 'package:personajes_api_fe/common/validate.dart';

///Clase que verifica los campos de los formularios y aplica
///estilos.
class TextFieldBase extends StatelessWidget {
  String texto;
  TextEditingController controller;
  ValidateText? validateText;
  bool notRequire;
  bool obscureText;

  TextFieldBase(this.texto, this.controller,
      {this.validateText, this.notRequire = false, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(FocusNode());
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              maxLength: ValidateMaxLength(),
              obscureText: validateObscureText(),
              inputFormatters: [ValidateInputFormater()],
              decoration: InputDecoration(
                  hintText: texto,
                  labelText: texto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              autofocus: false,
              validator: (String? value) {
                return ValidateStructure(value);
              },
            )
          ],
        ));
  }

  ///Método que valida el tamaño máximo que puede tener un tipo
  ///de campo seleccionado.
  ///
  ValidateMaxLength() {
    switch (validateText) {
      case ValidateText.name:
        return 20;
      case ValidateText.numValue:
        return 10;
      case ValidateText.longText:
        return 100;
      case ValidateText.password:
        return 32;

      case ValidateText.user:
        return 25;

      default:
        return null;
    }
  }

  ///Método que valida la estructura de  un tipo
  ///de campo seleccionado.
  ///
  ValidateStructure(String? value) {
    if (!notRequire && value!.isEmpty) {
      return "El campo $texto es requerido";
    } else {
      switch (validateText) {
        case ValidateText.name:
          return ValidateName(value!)
              ? null
              : "La estrucura del nombre es incorrecta";
        case ValidateText.numValue:
          return ValidateNum(value!) ? null : "Debe hacer al menos un número";

        case ValidateText.longText:
          return ValidateNoEmpty(value!)
              ? null
              : "Debe tener al menos un valor";
        case ValidateText.password:
          return ValidatePassword(value!)
              ? null
              : "Debe tener 8 carácteres, una mayúscula y un número";

        case ValidateText.user:
          return ValidateNoEmpty(value!)
              ? null
              : "Se acepta letras, números, arrobas y guiones solamente";

        default:
          return null;
      }
    }
  }

  ///Método que valida el el formato de un tipo
  ///de campo seleccionado.
  ///
  ValidateInputFormater() {
    switch (validateText) {
      case ValidateText.name:
        return FilteringTextInputFormatter.singleLineFormatter;
      case ValidateText.numValue:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.longText:
        return FilteringTextInputFormatter.digitsOnly;

      default:
        return FilteringTextInputFormatter.singleLineFormatter;
    }
  }

  ///Método que valida si debe mostrar lo que se escribe.
  ///
  validateObscureText() {
    switch (validateText) {
      case ValidateText.password:
        return true;

      default:
        return false;
    }
  }
}
