import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef TextFormat = String Function(num, bool);
String dfaultFomrat(num d, bool tooltip) => d.toStringAsFixed(tooltip ? 2 : 0);

class BasicLineChart extends StatelessWidget {
  
  final List<DateTime> x;
  final List<num> y;
  final TextFormat textFormat;

  const BasicLineChart(this.x, this.y, {super.key, this.textFormat=dfaultFomrat});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 300,
        child:
          LineChart(
            key: ValueKey('${x.map((d) => d.millisecondsSinceEpoch).join(",")}_${y.join(",")}'),
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: _getSpots(x,y),
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
                    minIncluded: false,
                    maxIncluded: false,
                    getTitlesWidget: (value, meta) {
                      if(value == meta.min || value == meta.max){
                         //return Text("");
                      }
                      final date = DateTime.fromMillisecondsSinceEpoch((value).toInt());
                      return Text("${date.month}/${date.day}"); //TODO fix
                    },
                  ),),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    minIncluded: false,
                    maxIncluded: false,
                    reservedSize: 40, //TODO chart setting for this, to handle longer titles
                    getTitlesWidget: (value, meta) {
                      if(value == meta.min || value == meta.max){
                         //return Text("");
                      }
                      return Text(maxLines: 1, overflow: TextOverflow.clip ," "+textFormat(value, false));
                    },
                  ),) 
              ),
               lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((touchedSpot) =>
                   LineTooltipItem(
                      textFormat(touchedSpot.y, true),
                      const TextStyle(),
                    )
                  ).toList();
               },
                ),
              ),
            ),
          )
    );
  }
}

List<FlSpot> _getSpots(List<DateTime> x, List<num> y){

  final len = math.min(x.length, y.length);
  final spots = List.generate(len, (i)=> FlSpot(x[i].millisecondsSinceEpoch.toDouble(), y[i].toDouble()));
  spots.sort((a,b) => a.x.compareTo(b.x));
  return spots;
}
