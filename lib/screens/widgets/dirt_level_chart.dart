import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuzzylogic/blocs/blocs.dart';
import 'package:fuzzylogic/utils/chart.dart';

class DirtLevelChart extends StatelessWidget {
  final DirtLevelState state;
  DirtLevelChart({this.state});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Độ bẩn',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.all(10),
          child: LineChart(lineChartData()),
        ),
      ],
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
      minX: 0,
      maxX: 100,
      maxY: 1,
      minY: 0,
      backgroundColor: Colors.black,
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: SHOW_GRID,
        drawVerticalLine: true,
        verticalInterval: 10,
        horizontalInterval: 0.1,
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
            switch (value.toInt()) {
              case 0:
                return '0';
                break;
              case 50:
                return '50';
                break;
              case 100:
                return '100';
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

  baseSmall() => LineChartBarData(
        spots: [
          FlSpot(0, 1),
          FlSpot(50, 0),
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
  baseMedium() => LineChartBarData(
        spots: [
          FlSpot(50, 0),
          FlSpot(100, 1),
        ],
        isCurved: false,
        curveSmoothness: 0,
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
  baseLarge() => LineChartBarData(
        spots: [
          FlSpot(0, 0),
          FlSpot(50, 1),
          FlSpot(100, 0),
        ],
        isCurved: false,
        curveSmoothness: 0,
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
  getSmall() => LineChartBarData(
        spots: [
          FlSpot(state.value, 0),
          FlSpot(state.value, state.level.getSmall),
          FlSpot(0, state.level.getSmall),
        ],
        isCurved: false,
        curveSmoothness: 0,
        colors: const [
          Colors.red,
        ],
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );
  getMedium() => LineChartBarData(
        spots: [
          FlSpot(state.value, 0),
          FlSpot(state.value, state.level.getMedium),
          FlSpot(0, state.level.getMedium),
        ],
        isCurved: false,
        curveSmoothness: 0,
        colors: const [
          Colors.yellow,
        ],
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );
  getLarge() => LineChartBarData(
        spots: [
          FlSpot(state.value, 0),
          FlSpot(state.value, state.level.getLarge),
          FlSpot(0, state.level.getLarge),
        ],
        isCurved: false,
        curveSmoothness: 0,
        colors: const [
          Colors.green,
        ],
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: SHOW_POINT,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );

  List<LineChartBarData> linesBarData() {
    List<LineChartBarData> lines = [
      baseSmall(),
      baseMedium(),
      baseLarge(),
      getSmall(),
      getMedium(),
      getLarge(),
    ];

    return lines;
  }
}
