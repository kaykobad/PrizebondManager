import 'package:flutter/material.dart';
import 'package:prizebond_manager/ui/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prizebond Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen(),
    );
  }
}