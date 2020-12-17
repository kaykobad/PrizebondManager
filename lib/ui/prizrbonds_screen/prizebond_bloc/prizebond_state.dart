import 'package:equatable/equatable.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class PrizeBondManagerState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends PrizeBondManagerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InitialState";
}

class FetchingAllDataState extends PrizeBondManagerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FetchingAllDataState";
}

class AllDataFetchSuccessState extends PrizeBondManagerState {
  final List<PrizeBond> allPrizeBonds;

  AllDataFetchSuccessState(this.allPrizeBonds);

  @override
  List<Object> get props => [allPrizeBonds];

  @override
  String toString() => "DataFetchSuccessState";
}

class AllDataFetchFailureState extends PrizeBondManagerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "AllDataFetchFailureState";
}

class InsertingDataState extends PrizeBondManagerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InsertingDataState";
}

class InsertDataSuccessState extends PrizeBondManagerState {
  final List<int> ids;
  final List<PrizeBond> allPrizeBonds;
  final List<String> errorIds;

  InsertDataSuccessState(this.ids, this.allPrizeBonds, this.errorIds);

  @override
  List<Object> get props => [ids, allPrizeBonds, errorIds];

  @override
  String toString() => "InsertDataSuccessState";
}

class InsertDataFailureState extends PrizeBondManagerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InsertDataFailureState";
}