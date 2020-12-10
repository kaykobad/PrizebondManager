import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prizebond_manager/constants/number_constants.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/data_store/data_store.dart';
import 'package:prizebond_manager/ui/prizrbonds_screen/home_screen.dart';
import 'splash_screen_bloc.dart';
import 'splash_screen_event.dart';
import 'splash_screen_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataStore _dataStore;
  SplashScreenBloc _splashScreenBloc;
  
  @override
  void initState() {
    super.initState();
    _dataStore = RepositoryProvider.of<DataStore>(context);
    _splashScreenBloc = SplashScreenBloc();
    _splashScreenBloc.add(InitiateDataFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: BlocListener(
        cubit: _splashScreenBloc,
        listener: (context, state) {
          if (state is DataFetchSuccessState) {
            _dataStore.allPrizeBonds = state.allPrizeBonds;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          } else if (state is DataFetchFailureState) {
            _showErrorDialog();
          }
        },
        child: SafeArea(
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
      ),
    );
  }

  _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(DATABASE_READ_ERROR),
          content: Text(DATABASE_READ_ERROR_DETAILS),
          actions: [
            FlatButton(
              child: Text(
                BUTTON_CLOSE_APPLICATION,
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () => SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text(BUTTON_RETRY),
              onPressed: () {
                Navigator.of(context).pop();
                _splashScreenBloc.add(InitiateDataFetchEvent());
              },
            ),
          ],
        );
      }
    );
  }
}
