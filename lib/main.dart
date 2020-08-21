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
          primaryColor: corBarraNavegacao, // podem ser sobscritas
          accentColor: Colors.blue[800], //
          buttonColor: azulMtEscuro,
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          dividerColor: Colors.grey[300],

          textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.roboto(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3:
                GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.roboto(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.grey[850]),
            headline6: GoogleFonts.roboto(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.roboto(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.roboto(
                fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          ),
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF181818),
          buttonColor: azulMtEscuro,

          primaryColor: corBarraNavegacaoDark, // podem ser sobscritas
          accentColor: Color(0xff080626), //
          backgroundColor: Colors.red,
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          dividerColor: Colors.grey[800],

          textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.roboto(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3:
                GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.roboto(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.roboto(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.roboto(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.roboto(
                fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          ),
        ),
        themeMode: ThemeMode.system,
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
