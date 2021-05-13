import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzylogic/models/dirt_level.dart';
import 'bloc.dart';

class DirtLevelBloc extends Bloc<DirtLevelEvent, DirtLevelState> {
  DirtLevelBloc() : super(DirtLevelState(value: 0, level: DirtLevel(x: 0)));

  @override
  Stream<DirtLevelState> mapEventToState(DirtLevelEvent event) async* {
    // TODO: implement mapEventToState
    yield DirtLevelState(
      value: event.value,
      level: DirtLevel(x: event.value),
    );
  }
}
