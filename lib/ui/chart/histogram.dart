import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistogramChart extends StatelessWidget {
  
  final List<(double?, double?)> x;
  final List<num> y;
  final int fixedX;
  //final int fixedY;

  const HistogramChart(this.x, this.y, {super.key, this.fixedX = 0});

  @override
  Widget build(BuildContext context) {
  

    return SizedBox(
        height: 300,
        child:
          BarChart(
            key: ValueKey('${x.join(",")}_${y.join(",")}'),
            BarChartData(
              barGroups: _getGroups(y),
              titlesData: FlTitlesData( 
                 bottomTitles: AxisTitles( 
                  sideTitles: SideTitles( 
                    showTitles: true, 
                    getTitlesWidget: (value, meta) {
                      final range = x[value.toInt()];
                      if(range.$1 != null && range.$2 != null){
                        return Text("${range.$1!.toStringAsFixed(fixedX)}-${range.$2!.toStringAsFixed(fixedX)}");
                      }
                      if(range.$1 != null){
                        return Text("<${range.$1!.toStringAsFixed(fixedX)}");
                      }
                      if(range.$2 != null){
                        return Text(">${range.$2!.toStringAsFixed(fixedX)}");
                      }
                      return Text("");
                    },
                  ), 
                ),
              ),
            ),
          )
    );
  }
}

List<BarChartGroupData> _getGroups(List<num> y){
  
  return List.generate(y.length, (i)=> BarChartGroupData(x:i, barRods:[BarChartRodData(toY: y[i].toDouble())]));
}
