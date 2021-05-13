import 'package:equatable/equatable.dart';

class DirtLevelEvent extends Equatable {
  final double value;
  DirtLevelEvent({this.value});
  @override
  // TODO: implement props
  List<Object> get props => [value];
}
