import 'package:equatable/equatable.dart';
import 'package:fuzzylogic/models/washing.dart';

class WashingState extends Equatable {
  final Washing wash;
  WashingState({this.wash});
  @override
  // TODO: implement props
  List<Object> get props => [wash];
}
