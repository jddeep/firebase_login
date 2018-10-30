import 'package:flutter/material.dart';

import 'login_page.dart';
import 'home_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireLogIn',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: loginPage(),
      routes: <String,WidgetBuilder>{
        '/landingpage': (context) => MyApp(),
        '/loginpage': (context) => loginPage(),
        '/homepage': (context) => HomePage(),
      }
    );
  }
}

