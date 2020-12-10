import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prizebond_manager/constants/number_constants.dart';
import 'package:prizebond_manager/constants/string_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              APP_NAME,
              style: TextStyle(
                color: Colors.white,
                fontSize: SPLASH_APP_NAME_FONT_SIZE,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.0),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
