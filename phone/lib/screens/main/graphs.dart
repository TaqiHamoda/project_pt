import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class Graph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GraphState();
}

class GraphState extends State<Graph> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              colors: const [
                Color(0xff2c274c),
                Color(0xff46426c),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 37,
                  ),
                  Text(
                    'Weight',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: LineChart(
                          sampleData2(),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: const Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'JAN';
              case 7:
                return 'FEB';
              case 12:
                return 'MAR';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '100';
              case 2:
                return '110';
              case 3:
                return '120';
              case 4:
                return '130';
              case 5:
                return '140';
              case 6:
                return '150';
              case 7:
                return '160';
              case 8:
                return '170';
              case 9:
                return '180';
              case 10:
                return '190';

            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 20,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }




  List<LineChartBarData> linesBarData2() {
    return [
      const LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(12, 2),
        ],
        curveSmoothness: 0,
        colors: [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
      ),
    ];
  }
}