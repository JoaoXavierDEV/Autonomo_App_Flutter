import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/components/tabNavigationBar.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/profile_view.dart';
import 'package:autonomo_app/pages/login/signup/signup_page.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/testes.dart';
import 'package:autonomo_app/whapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /*    StreamProvider<DatabaseService>(
            create: (context) => DatabaseService().intStream(),
            initialData: null),*/
        ChangeNotifierProvider<DatabaseService>(
            create: (context) => DatabaseService())
      ],
      child: MyApp(),
    ),
  );
}

Temas temas;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Autônomo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          primaryColor: Colors.blue[50], // podem ser sobscritas
          accentColor: Colors.white, //
          buttonColor: azulMtEscuro,
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          //scaffoldBackgroundColor: azulMtEscuro,
          buttonColor: Colors.blueGrey[800],

          primaryColor: Color(0xff080626), // podem ser sobscritas
          accentColor: Color(0xff080626), //
          backgroundColor: Colors.red,
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.light,
        // home:  Whapper(),
        initialRoute: '/whapper',
        routes: <String, WidgetBuilder>{
          '/whapper': (BuildContext context) => Whapper(),
          '/home': (BuildContext context) => HomePage(),
          '/signup': (BuildContext context) => SignupPage(),
          '/': (BuildContext context) => LoginPage(),
          '/profile': (BuildContext context) => ProfileView(),
          '/tabNavBar': (BuildContext context) => TabNavBar(),
          '/NavBar': (BuildContext context) => BarraDeNavegacao(),
          '/testes': (BuildContext context) => TestesLayout()
        },
      ),
    );
  }
}
