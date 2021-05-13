import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/screens/home.dart';
import 'package:fuzzylogic/utils/color.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<DirtLevelBloc>(
      create: (context) => DirtLevelBloc(),
    ),
    BlocProvider<DirtTypeBloc>(
      create: (context) => DirtTypeBloc(),
    ),
    BlocProvider<WashingBloc>(
      create: (context) => WashingBloc(
        levelBloc: BlocProvider.of<DirtLevelBloc>(context),
        typeBloc: BlocProvider.of<DirtTypeBloc>(context),
      ),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColor.darkBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColor.darkBlue,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
