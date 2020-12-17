import 'package:prizebond_manager/data/models/prizebond.dart';

class DataStore {
  List<PrizeBond> allPrizeBonds;

  DataStore({this.allPrizeBonds});

  get numericallySortedPrizeBonds {
    allPrizeBonds.sort((a, b) => a.prizeBondNumber.compareTo(b.prizeBondNumber));
    return allPrizeBonds;
  }

  get createDateWiseSortedPrizeBonds {
    allPrizeBonds.sort((a, b) => a.insertDate.compareTo(b.insertDate));
    return allPrizeBonds;
  }

  get updateDateWiseSortedPrizeBonds {
    allPrizeBonds.sort((a, b) => a.updateDate.compareTo(b.updateDate));
    return allPrizeBonds;
  }

  List<PrizeBond> searchPrizeBond(String number) {
    return allPrizeBonds.where((p) => p.prizeBondNumber.contains(number)).toList();
  }
}