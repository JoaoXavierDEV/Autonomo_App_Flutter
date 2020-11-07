import 'package:autonomo_app/components/temas/temas.dart';
import 'package:flutter/Material.dart';

class BotaoWidget {
  botaoPadrao({icone: Icon, nome: String, function: Function}) {
    return RaisedButton(
      visualDensity: VisualDensity.standard,
      elevation: 6,
      color: azulMtEscuro,
      splashColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(900.0),
        side: BorderSide(
          color: Colors.blue[900],
          width: 4,
        ),
      ),
      child: Container(
        width: 150,
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nome,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(icone),
            )
          ],
        ),
      ),
      onPressed: function,
    );
  }
}
