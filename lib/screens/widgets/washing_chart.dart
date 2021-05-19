import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/utils/chart.dart';

class WashingChart extends StatefulWidget {
  final WashingState state;
  WashingChart({this.state});

  @override
  _WashingChartState createState() => _WashingChartState();
}

class _WashingChartState extends State<WashingChart> {
  bool showFill = SHOW_FILL;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          padding: EdgeInsets.all(10),
          child: LineChart(lineChartData()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Thời gian giặt: ${widget.state.wash.getTime.toStringAsFixed(4)} phút',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.25,
                  child: Checkbox(
                    value: showFill,
                    onChanged: (value) {
                      setState(() {
                        showFill = value;
                      });
                    },
                  ),
                ),
                Text('Phủ màu')
              ],
            )
          ],
        ),
      ],
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      minX: 0,
      maxX: 60,
      maxY: 1,
      minY: 0,
      backgroundColor: Colors.black,
      lineTouchData: LineTouchData(
        enabled: true,
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
              case '$VS':
                return '${value.toInt()}';
                break;
              case '$S':
                return '${value.toInt()}';
                break;
              case '$M':
                return '${value.toInt()}';
                break;
              case '$L':
                return '${value.toInt()}';
                break;
              case '$VL':
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
          FlSpot(VS, 1),
          FlSpot(S, 0),
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
          FlSpot(VS, 0),
          FlSpot(S, 1),
          FlSpot(M, 0),
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
          FlSpot(S, 0),
          FlSpot(M, 1),
          FlSpot(L, 0),
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
          FlSpot(M, 0),
          FlSpot(L, 1),
          FlSpot(VL, 0),
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
          FlSpot(L, 0),
          FlSpot(VL, 1),
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
    final x2 = (S - VS) * (1 - y) + VS;
    final spots = showFill
        ? [
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(S, 0),
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
    final x1 = (S - VS) * y + VS;
    final alpha = (M - S) < (S - VS) ? (M - VS) / (S - VS) : (M - VS) / (M - S);
    final x2 = alpha * (M - S) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(VS, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(M, 0),
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

    final x1 = (M - S) * y + S;
    final alpha = (L - M) < (M - S) ? (L - S) / (M - S) : (L - S) / (L - M);
    final x2 = alpha * (L - M) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(S, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(L, 0),
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
    final x1 = (L - M) * y + M;
    final alpha = (VL - L) < (L - M) ? (VL - M) / (L - M) : (VL - M) / (VL - L);
    final x2 = alpha * (VL - L) * (1 - y) + x1;
    // print(
    //     '{x1: ${x1.toStringAsFixed(2)}} , {x2: ${x2.toStringAsFixed(2)}} , {y: ${y.toStringAsFixed(2)}}');
    final spots = showFill
        ? [
            FlSpot(M, 0),
            FlSpot(x1, y),
            FlSpot(x2, y),
            FlSpot(VL, 0),
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
    final x1 = (VL - L) * (y) + L;
    final x2 = VL;
    final spots = showFill
        ? [
            FlSpot(L, 0),
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
