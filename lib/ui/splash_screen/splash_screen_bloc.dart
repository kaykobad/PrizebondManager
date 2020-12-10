import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prizebond_manager/data/database/db_provider.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';
import 'package:prizebond_manager/ui/splash_screen/splash_screen_event.dart';
import 'package:prizebond_manager/ui/splash_screen/splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {

  SplashScreenBloc() : super(InitialState());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is InitiateDataFetchEvent) {
      try {
        yield FetchingDataState();
        await Future.delayed(Duration(seconds: 2));
        List<PrizeBond> allPrizeBonds = await DBProvider.db.getAllPrizeBonds();
        yield DataFetchSuccessState(allPrizeBonds);
      } on Exception catch (e) {
        yield DataFetchFailureState();
      }
    }
  }

}