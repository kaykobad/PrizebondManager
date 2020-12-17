import 'package:equatable/equatable.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class PrizeBondManagerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitiateDataFetchEvent extends PrizeBondManagerEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InitiateDataFetchEvent";
}

class InsertDataEvent extends PrizeBondManagerEvent {
  final List<PrizeBond> prizeBonds;
  final List<String> errorIds;

  InsertDataEvent(this.prizeBonds, this.errorIds);

  @override
  List<Object> get props => [prizeBonds, errorIds];

  @override
  String toString() => "InsertDataEvent";
}