import 'package:autonomo_app/novosTestes.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/profile_view.dart';
import 'package:autonomo_app/testes.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';

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
    NovosTestes(),
    //TestesLayout(),
    //LoginPage(),
    ProfileView(),
  ];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // print(_tabController);
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
          backgroundColor: azulMtEscuro,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blueGrey[400],
        ),
      ),
    );
  }
}
