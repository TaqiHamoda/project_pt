import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/components/users.dart';
import 'dart:math';





class Graph extends StatelessWidget {

  final String timeInterval;
  final Client user;
  final Goal goal;
  List<FlSpot> monthlySpots = [];



  Graph(this.timeInterval, this.user, this.goal){
    addSpot(1, _getMinY());
    addSpot(2, _getMaxY());
    addSpot(3, (_getMaxY() + _getMinY()) / 2);
  }

  String _getInterval(double value, String unit){
    if(value == _getMinY()){
      return value.toInt().toString();
    }

    else if(value == _getMaxY()){
      return value.toInt().toString();
    }


    double average = ((_getMaxY() + _getMinY()) / 2).roundToDouble();
    if(value == average){
      return average.toInt().toString();
    }

    return '';




  }

  double _getMinY(){


    return (this.goal.current * 0.9).roundToDouble();
  }

  double _getMaxY(){

    return (this.goal.current * 1.1).roundToDouble();
  }

  void addSpot(double x, double y){
    this.monthlySpots.add(FlSpot(x, y));
  }

  LineChartData _whichData(){
    if(timeInterval == 'Monthly'){
      return monthlyData();
    }
    else if(timeInterval == '3 Month'){
      return monthly3Data();
    }
    else{
      return yearlyData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      _whichData(),
      swapAnimationDuration: Duration(milliseconds: 250),
    );
  }

  LineChartData monthlyData() {

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData( // this is for the bubble that shows when you tap on a dot
            tooltipBgColor: Colors.pink,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toInt().toString() + ' lbs',
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            }),
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
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'J';
              case 2:
                return 'F';
              case 3:
                return 'M';
              case 4:
                return 'A';
              case 5:
                return 'M';
              case 6:
                return 'J';
              case 7:
                return 'J';
              case 8:
                return 'A';
              case 9:
                return 'S';
              case 10:
                return 'O';
              case 11:
                return 'N';
              case 12:
                return 'D';
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
          getTitles: (double value){ // value is each individual value between minY and maxY, hence it needs to be filtered
            return _getInterval(value, 'lbs');
          },
          margin: 4,
          reservedSize: 25,
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
      maxX: 13,
      maxY: _getMaxY(),
      minY: _getMinY(),
      lineBarsData: monthlySpotsData(),
    );
  }

  List<LineChartBarData> monthlySpotsData() {
    return [
       LineChartBarData(
        spots: this.monthlySpots,
        curveSmoothness: 0,
        colors: [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
      ),
    ];
  }

  LineChartData monthly3Data() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData( // this is for the bubble that shows when you tap on a dot
            tooltipBgColor: Colors.pink,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toInt().toString() + ' lbs',
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            }),
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
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'J';
              case 2:
                return 'F';
              case 3:
                return 'M';
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
          getTitles: (double value){
            return _getInterval(value, 'lbs');
          },
          margin: 4,
          reservedSize: 25,
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
      maxX: 4,
      maxY: _getMaxY(),
      minY: _getMinY(),
      lineBarsData: monthly3SpotsData(),
    );
  }

  List<LineChartBarData> monthly3SpotsData() {
    return [
       LineChartBarData(
        spots: this.monthlySpots,
        curveSmoothness: 0,
        colors: [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
      ),
    ];
  }


  LineChartData yearlyData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData( // this is for the bubble that shows when you tap on a dot
            tooltipBgColor: Colors.pink,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toInt().toString() + ' lbs',
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            }),
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
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2020';
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
          getTitles: (double value){
            return _getInterval(value, 'lbs');
          },
          margin: 4,
          reservedSize: 25,
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
      maxX: 2,
      maxY: _getMaxY(),
      minY: _getMinY(),
      lineBarsData: yearlySpotsData(),
    );
  }

  List<FlSpot> _yearlyAverageSpots(){
    double average = 0;
    for(FlSpot fs in this.monthlySpots){
      average += fs.y;
    }
    return [FlSpot(1, average / this.monthlySpots.length)];
  }

  List<LineChartBarData> yearlySpotsData() {
    return [
      LineChartBarData(
        spots: _yearlyAverageSpots(),
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