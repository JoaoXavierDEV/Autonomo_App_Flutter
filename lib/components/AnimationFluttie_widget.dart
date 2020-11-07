import 'dart:async';

import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_Controller.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:intro_views_flutter/Animation_Gesture/page_dragger.dart';
import 'package:lottie/lottie.dart';

class AnimationFluttieWidget extends StatefulWidget {
  @override
  _AnimationFluttieWidgetState createState() => _AnimationFluttieWidgetState();
}

class _AnimationFluttieWidgetState extends State<AnimationFluttieWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Future<LottieComposition> _composition;

  var busy = false;
  var done = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _composition = _loadComposition();

    //prepareAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.isDismissed;
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('lib/images/animations/done.json');
    return await LottieComposition.fromByteData(assetData);
  }

  Future<Function> submit() async {
    setState(() {
      busy = true;
    });
    print("funcao animation");

    Future.delayed(
      const Duration(seconds: 6),
      () => setState(
        () {
          done = true;
          Loading();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,

          // EscolheCategoriaView(busy: busy, func: submit),
          /*   Container(
              //alignment: Alignment.center,
              //width: 100,
              /*  child: Lottie.asset(
              "lib/images/animations/done.json",
              repeat: false,
              controller: _controller,
            ),*/
              ),*/
          !done
              ? EscolheCategoriaView(busy: busy, func: submit)
              : Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Lottie.asset(
                    "lib/images/animations/done.json",
                    repeat: false,
                    // controller: _controller,
                  ),
                ),
    );
  }
}
