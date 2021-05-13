import 'package:equatable/equatable.dart';
import 'package:fuzzylogic/models/dirt_level.dart';

class DirtLevelState extends Equatable {
  final double value;
  final DirtLevel level;
  DirtLevelState({this.level, this.value});

  @override
  // TODO: implement props
  List<Object> get props => [level, value];
}
