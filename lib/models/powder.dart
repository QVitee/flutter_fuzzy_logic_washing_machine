import 'dart:math' as math;

import 'package:fuzzylogic/models/dirt_level.dart';
import 'package:fuzzylogic/models/dirt_type.dart';
import 'package:fuzzylogic/utils/chart.dart';

class Powder {
  ///
  double powder = 0;

  ///
  List<double> _washingY = List<double>.filled(231, 0);

  ///
  double _veryShort = 0, _short = 0, _medium = 0, _long = 0, _veryLong = 0;

  double computePowder(DirtLevel level, DirtType type) {
    _veryShort = math.min(level.getSmall, type.getNotGreasy);

    _short = math.min(level.getMedium, type.getNotGreasy);

    _medium = math.min(level.getLarge, type.getNotGreasy) +
        math.min(level.getSmall, type.getMedium) +
        math.min(level.getMedium, type.getMedium);

    _long = math.min(level.getLarge, type.getMedium) +
        math.min(level.getSmall, type.getGreasy) +
        math.min(level.getMedium, type.getGreasy);

    _veryLong = math.min(level.getLarge, type.getGreasy);

    buildChart();

    defuzzification();

    return powder;
  }

  void buildChart() {
    for (int i = POWDER_MIN; i <= POWDER_VERY_SHORT; i++) {
      _washingY[i] = _veryShort;
    }

    for (int i = POWDER_VERY_SHORT.toInt() + 1; i <= POWDER_SHORT; i++) {
      double y1 = math.min(
          _veryShort, (POWDER_SHORT - i) / (POWDER_SHORT - POWDER_VERY_SHORT));
      double y2 = math.min(
          _short, (i - POWDER_VERY_SHORT) / (POWDER_SHORT - POWDER_VERY_SHORT));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = POWDER_SHORT.toInt() + 1; i <= POWDER_MEDIUM; i++) {
      double y1 = math.min(
          _short, (POWDER_MEDIUM - i) / (POWDER_MEDIUM - POWDER_SHORT));
      double y2 = math.min(
          _medium, (i - POWDER_SHORT) / (POWDER_MEDIUM - POWDER_SHORT));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = POWDER_MEDIUM.toInt() + 1; i <= POWDER_LONG; i++) {
      double y1 =
          math.min(_medium, (POWDER_LONG - i) / (POWDER_LONG - POWDER_MEDIUM));
      double y2 =
          math.min(_long, (i - POWDER_MEDIUM) / (POWDER_LONG - POWDER_MEDIUM));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = POWDER_LONG.toInt() + 1; i <= POWDER_VERY_LONG; i++) {
      double y1 = math.min(
          _long, (POWDER_VERY_LONG - i) / (POWDER_VERY_LONG - POWDER_LONG));
      double y2 = math.min(
          _veryLong, (i - POWDER_LONG) / (POWDER_VERY_LONG - POWDER_LONG));
      _washingY[i] = math.max(y1, y2);
    }
  }

  void defuzzification() {
    double sum = 0, sumY = 0;
    for (int i = POWDER_MIN; i <= POWDER_MAX; i++) {
      sum += i * _washingY[i];
      sumY += _washingY[i];
    }
    print("(*): $sum\n(**): $sumY");
    powder = sum / sumY;
  }

  double get getPowder => this.powder;
  double get getVeryShort => this._veryShort;
  double get getShort => this._short;
  double get getMedium => this._medium;
  double get getLong => this._long;
  double get getVeryLong => this._veryLong;

  @override
  String toString() {
    return '$powder';
  }
}
