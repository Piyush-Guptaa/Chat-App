import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_call/src/utils/components.dart';

import 'src/pages/join.dart';

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
        home: Builder(builder: (context) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: isDark ? Colors.white24 : Colors.grey[200],

            // implements the app bar
            appBar: AppBar(
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              leading: Builder(
                  builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Icon(Icons.menu,
                          color: isDark ? Colors.grey[400] : Colors.black))),
              title: Text(
                'Meet',
                style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.black,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
              elevation: 0.4,
            ),
            drawer: Container(
              height: double.infinity,
              width: 220,
              color: isDark ? Colors.grey[900] : Colors.white,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CupertinoSwitch(
                          value: isDark,
                          activeColor: Colors.black,
                          trackColor: Colors.grey[400],
                          onChanged: (state) => setState(() {
                                isDark = !isDark;
                              })),
                    ),
                    isDark
                        ? Text('Switch to light mode',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14))
                        : Text('Switch to dark mode',
                            style: TextStyle(color: Colors.black, fontSize: 14))
                  ],
                ),
              ),
            ),

            //implements the body of the hompage
            body: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NewMeetButton(isDark: isDark),
                      JoinMeetingButton(isDark: isDark),
                    ]),
              ),
              SizedBox(height: size.width * 0.2),
              Anime(size: size) //the meeting animation on the homepage
            ]),
          );
        }));
  }
}
