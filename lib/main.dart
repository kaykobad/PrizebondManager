import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prizebond_manager/data/data_store/data_store.dart';
import 'package:prizebond_manager/ui/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DataStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prizebond Manager',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: SplashScreen(),
      ),
    );
  }
}