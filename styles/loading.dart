import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xff080626),
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xff080626),
          size: 100.0,
        ),
      ),
    );
  }
}