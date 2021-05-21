import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/utils/chart.dart';

class PowderChart extends StatefulWidget {
  final WashingState state;
  PowderChart({this.state});

  @override
  _PowderChartState createState() => _PowderChartState();
}

class _PowderChartState extends State<PowderChart> {
  bool showFill = SHOW_FILL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Lượng nước giặt: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            '${widget.state.powder?.getPowder?.toStringAsFixed(4)} (ml)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          // Container(
          //   width: 265,
          //   height: 265,
          //   padding: EdgeInsets.all(10),
          //   child: LineChart(lineChartData()),
          // ),
        ],
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      minX: WATER_MIN.toDouble(),
      maxX: WATER_MAX.toDouble(),
      maxY: 1,
      minY: 0,
      backgroundColor: Colors.black,
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: SHOW_GRID,
        drawVerticalLine: true,
        verticalInterval: 10,
        horizontalInterval: 1 / 6,
      ),
      titlesData: FlTitlesData(
        show: SHOW_WASHING_LABEL,
        leftTitles: SideTitles(
          showTitles: SHOW_WASHING_LABEL,
          getTextStyles: (value) => STYLE_LABEL,
          margin: 5,
          reservedSize: 0,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
                break;
              default:
                return '';
                break;
            }
          },
        ),
        bottomTitles: SideTitles(
          showTitles: SHOW_WASHING_LABEL,
          margin: 3,
          reservedSize: 5,
          getTextStyles: (value) => STYLE_LABEL,
          getTitles: (value) {
            switch ('${value.toStringAsFixed(1)}') {
              case '0.0':
                return '0';
                break;
              case '$WASHING_VERY_SHORT':
                return '${value.toInt()}';
                break;
              case '$WASHING_SHORT':
                return '${value.toInt()}';
                break;
              case '$WASHING_MEDIUM':
                return '${value.toInt()}';
                break;
              case '$WASHING_LONG':
                return '${value.toInt()}';
                break;
              case '$WASHING_VERY_LONG':
                return '${value.toInt()}';
                break;
              default:
                return '';
                break;
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      lineBarsData: linesBarData(),
    );
  }

  baseVeryShort() => LineChartBarData(
        spots: [
          FlSpot(0, 1),
          FlSpot(WASHING_VERY_SHORT, 1),
          FlSpot(WASHING_SHORT, 0),
          // FlSpot(0, 0),
          // FlSpot(VS , 0),
          // FlSpot(VS , 0),
          // FlSpot(S , 1),
        ],
        isCurved: false,
        curveSmoothness: 0,
        colors: const [
          Colors.red,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  baseShort() => LineChartBarData(
        spots: [
          // FlSpot(0, 0),
          FlSpot(WASHING_VERY_SHORT, 0),
          FlSpot(WASHING_SHORT, 1),
          FlSpot(WASHING_MEDIUM, 0),
          // FlSpot(VS , 1),
          // FlSpot(S , 0),
          // FlSpot(S , 0),
          // FlSpot(M , 1),
        ],
        isCurved: false,
        colors: const [
          Colors.orange,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  baseMedium() => LineChartBarData(
        spots: [
          // FlSpot(0, 0),
          FlSpot(WASHING_SHORT, 0),
          FlSpot(WASHING_MEDIUM, 1),
          FlSpot(WASHING_LONG, 0),
          // FlSpot(S , 1),
          // FlSpot(M , 0),
          // FlSpot(M , 0),
          // FlSpot(L , 1),
        ],
        isCurved: false,
        colors: const [
          Colors.yellow,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  baseLong() => LineChartBarData(
        spots: [
          FlSpot(WASHING_MEDIUM, 0),
          FlSpot(WASHING_LONG, 1),
          FlSpot(WASHING_VERY_LONG, 0),
          // FlSpot(M , 1),
          // FlSpot(L , 0),
          // FlSpot(L , 0),
          // FlSpot(VL , 1),
        ],
        isCurved: false,
        colors: const [
          Colors.green,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  baseVeryLong() => LineChartBarData(
        spots: [
          FlSpot(WASHING_LONG, 0),
          FlSpot(WASHING_VERY_LONG, 1),
          // FlSpot(L , 1),
          // FlSpot(VL , 0),
        ],
        isCurved: false,
        colors: const [
          Colors.blue,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  getVeryShort() {
    final y = widget.state.wash.getVeryShort;
    final x1 = 0.0;
    final x2 =
        (WASHING_SHORT - WASHING_VERY_SHORT) * (1 - y) + WASHING_VERY_SHORT;
    final spots = showFill
        ? [
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(WASHING_SHORT, 0),
          ]
        : [
            FlSpot(x1, y),
            FlSpot(x2, y),
          ];
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: const [
        Colors.white,
      ],
      barWidth: 0.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: SHOW_POINT,
      ),
      belowBarData: BarAreaData(show: showFill, colors: [FILL_COLOR]),
    );
  }

  getShort() {
    final y = widget.state.wash.getShort;
    final x1 = (WASHING_SHORT - WASHING_VERY_SHORT) * y + WASHING_VERY_SHORT;
    final alpha =
        (WASHING_MEDIUM - WASHING_SHORT) < (WASHING_SHORT - WASHING_VERY_SHORT)
            ? (WASHING_MEDIUM - WASHING_VERY_SHORT) /
                (WASHING_SHORT - WASHING_VERY_SHORT)
            : (WASHING_MEDIUM - WASHING_VERY_SHORT) /
                (WASHING_MEDIUM - WASHING_SHORT);
    final x2 = alpha * (WASHING_MEDIUM - WASHING_SHORT) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(WASHING_VERY_SHORT, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(WASHING_MEDIUM, 0),
          ]
        : [
            FlSpot(x1, y),
            FlSpot(x2, y),
          ];
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: const [
        Colors.white,
      ],
      barWidth: 0.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: SHOW_POINT,
      ),
      belowBarData: BarAreaData(show: showFill, colors: [FILL_COLOR]),
    );
  }

  getMedium() {
    final y = widget.state.wash.getMedium;

    final x1 = (WASHING_MEDIUM - WASHING_SHORT) * y + WASHING_SHORT;
    final alpha =
        (WASHING_LONG - WASHING_MEDIUM) < (WASHING_MEDIUM - WASHING_SHORT)
            ? (WASHING_LONG - WASHING_SHORT) / (WASHING_MEDIUM - WASHING_SHORT)
            : (WASHING_LONG - WASHING_SHORT) / (WASHING_LONG - WASHING_MEDIUM);
    final x2 = alpha * (WASHING_LONG - WASHING_MEDIUM) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(WASHING_SHORT, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(WASHING_LONG, 0),
          ]
        : [
            FlSpot(x1, y),
            FlSpot(x2, y),
          ];
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: const [
        Colors.white,
      ],
      barWidth: 0.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: SHOW_POINT,
      ),
      belowBarData: BarAreaData(show: showFill, colors: [FILL_COLOR]),
    );
  }

  getLong() {
    final y = widget.state.wash.getLong;
    final x1 = (WASHING_LONG - WASHING_MEDIUM) * y + WASHING_MEDIUM;
    final alpha = (WASHING_VERY_LONG - WASHING_LONG) <
            (WASHING_LONG - WASHING_MEDIUM)
        ? (WASHING_VERY_LONG - WASHING_MEDIUM) / (WASHING_LONG - WASHING_MEDIUM)
        : (WASHING_VERY_LONG - WASHING_MEDIUM) /
            (WASHING_VERY_LONG - WASHING_LONG);
    final x2 = alpha * (WASHING_VERY_LONG - WASHING_LONG) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(WASHING_MEDIUM, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(WASHING_VERY_LONG, 0),
          ]
        : [
            FlSpot(x1, y),
            FlSpot(x2, y),
          ];
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: const [
        Colors.white,
      ],
      barWidth: 0.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: SHOW_POINT,
      ),
      belowBarData: BarAreaData(show: showFill, colors: [FILL_COLOR]),
    );
  }

  getVeryLong() {
    final y = widget.state.wash.getVeryLong;
    final x1 = (WASHING_VERY_LONG - WASHING_LONG) * (y) + WASHING_LONG;
    final x2 = WASHING_VERY_LONG;
    final spots = showFill
        ? [
            FlSpot(WASHING_LONG, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
          ]
        : [
            FlSpot(x1, y),
            FlSpot(x2, y),
          ];
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: const [
        Colors.white,
      ],
      barWidth: 0.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: SHOW_POINT,
      ),
      belowBarData: BarAreaData(show: showFill, colors: [FILL_COLOR]),
    );
  }

  List<LineChartBarData> linesBarData() {
    List<LineChartBarData> lines = [
      baseVeryShort(),
      baseShort(),
      baseMedium(),
      baseLong(),
      baseVeryLong(),
      getVeryShort(),
      getShort(),
      getMedium(),
      getLong(),
      getVeryLong(),
    ];

    return lines;
  }
}
