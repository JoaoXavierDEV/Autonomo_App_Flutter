import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/components/tabNavigationBar.dart';
import 'package:autonomo_app/controllers/autheticate.dart';
import 'package:autonomo_app/novosTestes.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/testes.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';

class Whapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return BarraDeNavegacao();
    }
  }
}
