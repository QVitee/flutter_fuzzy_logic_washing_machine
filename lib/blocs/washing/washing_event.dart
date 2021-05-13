import 'package:equatable/equatable.dart';
import 'package:fuzzylogic/models/dirt_level.dart';
import 'package:fuzzylogic/models/dirt_type.dart';

class WashingEvent extends Equatable {
  final DirtLevel level;
  final DirtType type;
  WashingEvent({this.level, this.type});

  @override
  // TODO: implement props
  List<Object> get props => [level, type];
}
