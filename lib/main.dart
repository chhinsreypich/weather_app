// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:weather_app_tutorial/pages/introPage.dart";
import "package:weather_app_tutorial/pages/searchScreen.dart";
import "home_page.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Weather App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        "/": (context) => IntroPage(), 
        '/home': (context) => HomePage(),
        '/searchScreen': (context) => SearchScreen(cityOnTap: 'Sihanoukville'),
      },
    );
  }
}
