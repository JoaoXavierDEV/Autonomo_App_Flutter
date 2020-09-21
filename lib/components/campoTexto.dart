import 'package:flutter/material.dart';

import 'package:autonomo_app/components/temas/temas.dart';

class CampoTexto {
  final String nomeCampo;
  Function gerarCamposTexto;
  CampoTexto({
    this.nomeCampo = "asdas",
    this.gerarCamposTexto,
  });
}

Widget gerarCampos(
    {String nomeCampo, TextStyle style, TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    style: style,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelText: nomeCampo,
    ),
  );
}
