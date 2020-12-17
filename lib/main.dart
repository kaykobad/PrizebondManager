import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/string_constants.dart';
import 'data/data_store/data_store.dart';
import 'ui/splash_screen/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DataStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 16.0),
          )
        ),
        home: SplashScreen(),
      ),
    );
  }
}