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
    {String nomeCampo,
    TextStyle style,
    TextEditingController controller,
    BuildContext context}) {
  return TextFormField(
    controller: controller,
    style: Theme.of(context).textTheme.bodyText2,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelText: nomeCampo,
    ),
  );
}
