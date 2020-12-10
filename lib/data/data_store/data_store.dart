import 'package:prizebond_manager/data/models/prizebond.dart';

class DataStore {
  List<PrizeBond> allPrizeBonds;

  DataStore({this.allPrizeBonds});

  List<PrizeBond> searchPrizeBond(String number) {
    return allPrizeBonds.where((p) => p.prizeBondNumber.contains(number)).toList();
  }
}