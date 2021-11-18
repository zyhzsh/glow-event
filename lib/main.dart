import 'package:flutter/material.dart';
import 'package:glow2021v1/screens/intro_screen.dart';

void main() => runApp(App());
//This version is used at Glow 2021 for the artwork of Atelier Vrijdag
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: IntroPage());
  }
}
