import 'package:autonomo_app/botoes.dart';
import 'package:autonomo_app/components/botao_widget.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool busy;
  final Function func;

  LoadingButton({@required this.busy, @required this.func});

  @override
  Widget build(BuildContext context) {
    return !busy
        ? BotaoWidget().botaoPadrao(
            function: func,
            nome: "Concluir",
            icone: Icons.arrow_forward,
          )
        : Loading();
  }
}
