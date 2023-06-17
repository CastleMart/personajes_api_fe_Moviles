import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personajes_api_fe/common/enums.dart';
import 'package:personajes_api_fe/common/validate.dart';

class TextFieldBase extends StatelessWidget {
  String texto;
  TextEditingController controller;
  ValidateText? validateText;
  bool notRequire;

  TextFieldBase(this.texto, this.controller,
      {this.validateText, this.notRequire = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //Text(texto),
            TextFormField(
              enableInteractiveSelection: false,
              controller: controller,
              maxLength: ValidateMaxLength(),
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

  ValidateMaxLength() {
    switch (validateText) {
      case ValidateText.name:
        return 20;
      case ValidateText.numValue:
        return 10;
      case ValidateText.longText:
        return 100;

      default:
        return null;
    }
  }

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

        default:
          return null;
      }
    }
  }

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
}
