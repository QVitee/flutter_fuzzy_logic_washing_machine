import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzylogic/models/dirt_type.dart';
import 'bloc.dart';

class DirtTypeBloc extends Bloc<DirtTypeEvent, DirtTypeState> {
  DirtTypeBloc() : super(DirtTypeState(value: 0, type: DirtType(y: 0)));

  @override
  Stream<DirtTypeState> mapEventToState(DirtTypeEvent event) async* {
    // TODO: implement mapEventToState
    yield DirtTypeState(
      value: event.value,
      type: DirtType(y: event.value),
    );
  }
}
