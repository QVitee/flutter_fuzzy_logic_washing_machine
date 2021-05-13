import 'package:equatable/equatable.dart';
import 'package:fuzzylogic/models/dirt_type.dart';

class DirtTypeState extends Equatable {
  final double value;
  final DirtType type;
  DirtTypeState({this.type, this.value});

  @override
  // TODO: implement props
  List<Object> get props => [type, value];
}
