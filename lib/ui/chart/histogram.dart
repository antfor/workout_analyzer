import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistogramChart extends StatelessWidget {
  
  final List<(double?, double?)> x;
  final List<num> y;
  final int fixedX;
  final bool percentage;
  //final int fixedY;

  const HistogramChart(this.x, this.y, {super.key, this.fixedX = 0, this.percentage = false});

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
                      final v1 = ((percentage ? 100 : 1) * (range.$1 ?? 0)).toStringAsFixed(fixedX) + (percentage ? "%":"");
                      final v2 = ((percentage ? 100 : 1) * (range.$2 ?? 0)).toStringAsFixed(fixedX) + (percentage ? "%":"");
                      
                      if(range.$1 != null && range.$2 != null){
                        return Text("$v1-$v2");
                      }
                      if(range.$1 != null){
                        return Text("<$v1");
                      }
                      if(range.$2 != null){
                        return Text(">$v2");
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
