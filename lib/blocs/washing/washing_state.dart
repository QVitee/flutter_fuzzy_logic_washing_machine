import 'package:equatable/equatable.dart';
import 'package:fuzzylogic/models/powder.dart';
import 'package:fuzzylogic/models/washing.dart';
import 'package:fuzzylogic/models/water.dart';

class WashingState extends Equatable {
  final Washing wash;
  final Water water;
  final Powder powder;
  WashingState({this.wash, this.water, this.powder});
  @override
  // TODO: implement props
  List<Object> get props => [wash, water, powder];
}
