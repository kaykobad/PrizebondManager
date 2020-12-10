import 'package:equatable/equatable.dart';

class SplashScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitiateDataFetchEvent extends SplashScreenEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "InitiateDataFetchEvent";
}