import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

//FlSpot(x,y)
class BasicLineChart extends StatelessWidget {
  
  final List<DateTime> x;
  final List<num> y;

  const BasicLineChart(this.x, this.y, {super.key});

  @override
  Widget build(BuildContext context) {


    return SizedBox(
        height: 300,
        child:
          LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: getSpots(x,y),
                  isCurved: false,
                  barWidth: 3,
                ),
              ],
              titlesData: FlTitlesData( 
                topTitles: AxisTitles( sideTitles: SideTitles(showTitles: false), ),
                leftTitles: AxisTitles( sideTitles: SideTitles(showTitles: false), ),
                bottomTitles: AxisTitles( 
                  sideTitles: SideTitles( 
                    showTitles: true, 
                    getTitlesWidget: (value, meta) {
                      final date = DateTime.fromMillisecondsSinceEpoch((value).toInt());
                      return Text("${date.month}/${date.day}"); 
                    },
                  ), 
                ), 
              ),
              lineTouchData: LineTouchData(
                enabled: true,             
                handleBuiltInTouches: false, 
                ),
            ),
          )
    );
  }
}

List<FlSpot> getSpots(List<DateTime> x, List<num> y){

  final len = math.min(x.length, y.length);
  final spots = List.generate(len, (i)=> FlSpot(x[i].millisecondsSinceEpoch.toDouble(), y[i].toDouble()));
  spots.sort((a,b) => a.x.compareTo(b.x));
  return spots;
}
