import 'dart:math' as math;

import 'package:fuzzylogic/models/dirt_level.dart';
import 'package:fuzzylogic/models/dirt_type.dart';
import 'package:fuzzylogic/utils/chart.dart';

///
class Washing {
  ///
  double time = 0;

  ///
  List<double> _washingY = List<double>.filled(61, 0);

  ///
  double _veryShort = 0, _short = 0, _medium = 0, _long = 0, _veryLong = 0;

  double computeTime(DirtLevel level, DirtType type) {
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

    return time;
  }

  void buildChart() {
    for (int i = 0; i <= VS; i++) {
      _washingY[i] = _veryShort;
    }

    for (int i = VS.toInt() + 1; i <= S; i++) {
      double y1 = math.min(_veryShort, (S - i) / (S - VS));
      double y2 = math.min(_short, (i - VS) / (S - VS));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = S.toInt() + 1; i <= M; i++) {
      double y1 = math.min(_short, (M - i) / (M - S));
      double y2 = math.min(_medium, (i - S) / (M - S));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = M.toInt() + 1; i <= L; i++) {
      double y1 = math.min(_medium, (L - i) / (L - M));
      double y2 = math.min(_long, (i - M) / (L - M));
      _washingY[i] = math.max(y1, y2);
    }

    for (int i = L.toInt() + 1; i <= VL; i++) {
      double y1 = math.min(_long, (VL - i) / (VL - L));
      double y2 = math.min(_veryLong, (i - L) / (VL - L));
      _washingY[i] = math.max(y1, y2);
    }
  }

  void defuzzification() {
    double sum = 0, sumY = 0;
    for (int i = 0; i <= TIME; i++) {
      sum += i * _washingY[i];
      sumY += _washingY[i];
    }
    time = sum / sumY;
  }

  double get getTime => this.time;
  double get getVeryShort => this._veryShort;
  double get getShort => this._short;
  double get getMedium => this._medium;
  double get getLong => this._long;
  double get getVeryLong => this._veryLong;
}
