import 'package:autonomo_app/components/temas/temas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // alignment: Alignment.center,
        // width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SpinKitChasingDots(
          color: azulMtEscuro,
          size: 100.0,
        ),
      ),
    );
  }
}
