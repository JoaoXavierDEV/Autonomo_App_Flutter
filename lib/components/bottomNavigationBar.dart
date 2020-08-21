import 'package:autonomo_app/botoes.dart';
import 'package:autonomo_app/novosTestes.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/profile_view.dart';
import 'package:autonomo_app/testes.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:flutter/services.dart';

final temas = new Temas();

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Promoção Imperdivel"),
    content: Text("Não perca a promoção."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

class BarraDeNavegacao extends StatefulWidget {
  @override
  _BarraDeNavegacaoState createState() => _BarraDeNavegacaoState();
}

class _BarraDeNavegacaoState extends State<BarraDeNavegacao>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 2;

  List<Widget> _tabList = [
    HomePage(),
    // NovosTestes(),
    BotoesView(),
    //TestesLayout(),
    //LoginPage(),
    ProfileView(),
  ];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getCurrentStatusNavigationBarColor();
    // print(_tabController);
  }

  getCurrentStatusNavigationBarColor() {
    var temaDark = WidgetsBinding.instance.window.platformBrightness;
    //var temaDark = Theme.of(context).primaryColorBrightness;
    if (temaDark.toString() == 'Brightness.dark') {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: corBarraNavegacaoDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
      // print("TemaDark? " + temaDark.toString());
      //  print('dark');
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: corBarraNavegacao,
        //systemNavigationBarColor: corBarraNavegacao,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
      // print("TemaDark? " + temaDark.toString());
      // print('ligth');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        child: BottomNavigationBar(
          onTap: (currentIndex) {
            setState(() {
              _currentIndex = currentIndex;
            });
            _tabController.animateTo(_currentIndex);
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Buscar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
            )
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}
