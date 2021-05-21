import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/models/powder.dart';
import 'package:fuzzylogic/models/washing.dart';
import 'package:fuzzylogic/models/water.dart';
import 'bloc.dart';

class WashingBloc extends Bloc<WashingEvent, WashingState> {
  final DirtLevelBloc levelBloc;
  final DirtTypeBloc typeBloc;

  WashingBloc({
    this.levelBloc,
    this.typeBloc,
  }) : super(WashingState(wash: Washing())) {
    this.add(WashingEvent(
      level: levelBloc.state.level,
      type: typeBloc.state.type,
    ));
  }

  @override
  Stream<WashingState> mapEventToState(WashingEvent event) async* {
    // TODO: implement mapEventToState
    final wash = Washing()
      ..computeTime(levelBloc.state.level, typeBloc.state.type);
    final water = Water()
      ..computeWater(levelBloc.state.level, typeBloc.state.type);
    final powder = Powder()
      ..computePowder(levelBloc.state.level, typeBloc.state.type);
    yield WashingState(wash: wash, water: water, powder: powder);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
