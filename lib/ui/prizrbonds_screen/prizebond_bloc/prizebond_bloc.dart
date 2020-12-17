import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prizebond_manager/data/database/db_provider.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';
import 'prizebond_event.dart';
import 'prizebond_state.dart';

class PrizeBondManagerBloc extends Bloc<PrizeBondManagerEvent, PrizeBondManagerState> {

  PrizeBondManagerBloc() : super(InitialState());

  @override
  Stream<PrizeBondManagerState> mapEventToState(PrizeBondManagerEvent event) async* {
    if (event is InitiateDataFetchEvent) {
      try {
        yield FetchingAllDataState();
        List<PrizeBond> allPrizeBonds = await DBProvider.db.getAllPrizeBonds();
        yield AllDataFetchSuccessState(allPrizeBonds);
      } on Exception catch (e) {
        yield AllDataFetchFailureState();
      }
    } else if (event is InsertDataEvent) {
      yield InsertingDataState();
      List<int> _ids = await DBProvider.db.insertAllPrizeBonds(event.prizeBonds);
      List<PrizeBond> _allPrizeBonds = await DBProvider.db.getAllPrizeBonds();
      yield InsertDataSuccessState(_ids, _allPrizeBonds);
    }
  }

}