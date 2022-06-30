import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  ThemeData _light = ThemeData.light().copyWith(primaryColor: Colors.grey[200], cardColor: Colors.grey[200],buttonColor: Colors.grey[700]);
  ThemeData _dark = ThemeData.dark().copyWith(primaryColor: Colors.grey[900], cardColor: Colors.grey[800], buttonColor: Colors.black26);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'video call',
        darkTheme: _dark,
        theme: _light,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        home: LoginPage());

  }
}
