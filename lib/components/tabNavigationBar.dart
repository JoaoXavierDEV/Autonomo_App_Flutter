import 'package:autonomo_app/components/pesquisar.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_view.dart';
import 'package:autonomo_app/pages/login/profile/profile_view.dart';
import 'package:autonomo_app/pages/search/search.dart';
import 'package:autonomo_app/testes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabNavBar extends StatefulWidget {
  @override
  _TabNavBarState createState() => _TabNavBarState();
}

class _TabNavBarState extends State<TabNavBar>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Temas temas;
  @override
  void initState() {
    super.initState();
    trocaCor();
    tabController =
        TabController(initialIndex: 0, length: _tabList.length, vsync: this);
  }

  void trocaCor() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.blue[800],
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      // 0statusBarColor: Colors.transparent, 
      statusBarColor: Colors.blue[700],
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
/**/ */
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: azulMtEscuro,
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      //
      statusBarColor: Colors.transparent,
      // statusBarColor: azulMtEscuro,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      // statusBarBrightness: Brightness.dark, only iphone
    ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<Widget> _tabList = [
    HomePage(),

    //TestesLayout(),
    Search(),
    ProfileView(),
    //LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: DefaultTabController(
        //initialIndex: 2,
        length: _tabList.length,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: _tabList,
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: Material(
          color: Theme.of(context).buttonColor,
          child: TabBar(
            indicatorWeight: 2,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white30,
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Home',
                icon: Icon(
                  Icons.home,
                  //size: 20,
                ),
                iconMargin: null,
              ),
              Tab(
                text: 'Buscar',
                icon: Icon(Icons.search),
                iconMargin: null,
              ),
              Tab(
                text: 'Perfil',
                icon: Icon(
                  Icons.person,
                  //color: Colors.red,
                ),
                iconMargin: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
