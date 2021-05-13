import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/blocs/dirt_level/bloc.dart';
import 'package:fuzzylogic/screens/widgets/dirt_level_chart.dart';
import 'package:fuzzylogic/screens/widgets/dirt_type_chart.dart';
import 'package:fuzzylogic/screens/widgets/washing_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var dirtLevel, dirtType;
  AnimationController controller;

  Widget icon = Icon(Icons.play_arrow);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );
    controller.addListener(() {
      BlocProvider.of<DirtLevelBloc>(context)
          .add(DirtLevelEvent(value: controller.value * 100));
      BlocProvider.of<DirtTypeBloc>(context)
          .add(DirtTypeEvent(value: controller.value * 100));
      BlocProvider.of<WashingBloc>(context).add(WashingEvent(
        level: dirtLevel,
        type: dirtType,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuzzy Logic: Washing machine'),
        actions: [
          IconButton(
            icon: icon,
            onPressed: () {
              if (controller.status == AnimationStatus.dismissed) {
                controller.forward();
              } else if (controller.status == AnimationStatus.completed) {
                controller.reverse();
                // controller
                //   ..reset()
                //   ..forward();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      BlocBuilder<DirtLevelBloc, DirtLevelState>(
                        builder: (context, state) {
                          return Expanded(
                            child: DirtLevelChart(
                              state: state,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<DirtTypeBloc, DirtTypeState>(
                        builder: (context, state) {
                          return Expanded(
                            child: DirtTypeChart(
                              state: state,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<WashingBloc, WashingState>(
                    builder: (context, state) {
                      return WashingChart(
                        state: state,
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.white24,
              child: Column(
                children: [
                  BlocBuilder<DirtLevelBloc, DirtLevelState>(
                    builder: (context, state) {
                      dirtLevel = state.level;
                      return Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Level of dirt:'),
                          ),
                          Expanded(
                            child: Slider(
                              min: 0.0,
                              max: 100.0,
                              divisions: 10000,
                              value: state.value,
                              label: '${state.value.truncate()}',
                              activeColor: Colors.white60,
                              onChanged: (value) {
                                BlocProvider.of<DirtLevelBloc>(context)
                                    .add(DirtLevelEvent(value: value));
                                BlocProvider.of<WashingBloc>(context)
                                    .add(WashingEvent(
                                  level: dirtLevel,
                                  type: dirtType,
                                ));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: Text('${state.value.truncate()}'),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<DirtTypeBloc, DirtTypeState>(
                    builder: (context, state) {
                      dirtType = state.type;
                      return Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Type of dirt:'),
                          ),
                          Expanded(
                            child: Slider(
                              min: 0.0,
                              max: 100.0,
                              divisions: 10000,
                              value: state.value,
                              label: '${state.value.truncate()}',
                              activeColor: Colors.white60,
                              onChanged: (value) {
                                BlocProvider.of<DirtTypeBloc>(context)
                                    .add(DirtTypeEvent(value: value));
                                BlocProvider.of<WashingBloc>(context)
                                    .add(WashingEvent(
                                  level: dirtLevel,
                                  type: dirtType,
                                ));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: Text('${state.value.truncate()}'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
