import 'package:flutter/material.dart';
import 'package:guessit_landing/landing.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(colorSchemeSeed: Colors.pink[600], fontFamily: 'Montserrar', scaffoldBackgroundColor: Colors.white),
      themeMode: ThemeMode.light,
      home: const SelectionArea(child: Scaffold(body: LandingPage())),
    );
  }
}
