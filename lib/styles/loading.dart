import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xff0066cb),
          size: 100.0,
        ),
      ),
    );
  }
}