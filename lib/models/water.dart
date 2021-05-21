import 'dart:math' as math;
import 'package:fuzzylogic/models/dirt_level.dart';
import 'package:fuzzylogic/models/dirt_type.dart';
import 'package:fuzzylogic/utils/chart.dart';

class Water {
  ///
  double water = 0;

  ///
  List<double> _washingY = List<double>.filled(101, 0);

  ///
  double _veryShort = 0, _short = 0, _medium = 0, _long = 0, _veryLong = 0;

  double computeWater(DirtLevel level, DirtType type) {
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

    return water;
  }

  void buildChart() {
    for (int i = WATER_MIN; i <= WATER_VERY_SHORT; i++) {
      _washingY[i] = _veryShort;
    }

    for (int i = WATER_VERY_SHORT.toInt() + 1; i <= WATER_SHORT; i++) {
      double y1 = math.min(
          _veryShort, (WATER_SHORT - i) / (WATER_SHORT - WATER_VERY_SHORT));
      double y2 = math.min(
          _short, (i - WATER_VERY_SHORT) / (WATER_SHORT - WATER_VERY_SHORT));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = WATER_SHORT.toInt() + 1; i <= WATER_MEDIUM; i++) {
      double y1 =
          math.min(_short, (WATER_MEDIUM - i) / (WATER_MEDIUM - WATER_SHORT));
      double y2 =
          math.min(_medium, (i - WATER_SHORT) / (WATER_MEDIUM - WATER_SHORT));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = WATER_MEDIUM.toInt() + 1; i <= WATER_LONG; i++) {
      double y1 =
          math.min(_medium, (WATER_LONG - i) / (WATER_LONG - WATER_MEDIUM));
      double y2 =
          math.min(_long, (i - WATER_MEDIUM) / (WATER_LONG - WATER_MEDIUM));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = WATER_LONG.toInt() + 1; i <= WATER_VERY_LONG; i++) {
      double y1 = math.min(
          _long, (WATER_VERY_LONG - i) / (WATER_VERY_LONG - WATER_LONG));
      double y2 = math.min(
          _veryLong, (i - WATER_LONG) / (WATER_VERY_LONG - WATER_LONG));
      _washingY[i] = math.max(y1, y2);
    }
  }

  void defuzzification() {
    double sum = 0, sumY = 0;
    for (int i = WATER_MIN; i <= WATER_MAX; i++) {
      sum += i * _washingY[i];
      sumY += _washingY[i];
    }
    print("(*): $sum\n(**): $sumY");
    water = sum / sumY;
  }

  double get getWater => this.water;
  double get getVeryShort => this._veryShort;
  double get getShort => this._short;
  double get getMedium => this._medium;
  double get getLong => this._long;
  double get getVeryLong => this._veryLong;

  @override
  String toString() {
    return '$water';
  }
}
