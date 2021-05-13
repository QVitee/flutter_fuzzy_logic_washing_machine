import 'package:equatable/equatable.dart';

class DirtTypeEvent extends Equatable {
  final double value;
  DirtTypeEvent({this.value});
  @override
  // TODO: implement props
  List<Object> get props => [value];
}
