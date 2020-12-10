import 'package:equatable/equatable.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SplashScreenState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InitialState";
}

class FetchingDataState extends SplashScreenState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "FetchingDataState";
}

class DataFetchSuccessState extends SplashScreenState {
  final List<PrizeBond> allPrizeBonds;

  DataFetchSuccessState(this.allPrizeBonds);

  @override
  List<Object> get props => [allPrizeBonds];

  @override
  String toString() => "DataFetchSuccessState";
}

class DataFetchFailureState extends SplashScreenState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "DataFetchFailureState";
}