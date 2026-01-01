import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/histogram.dart';

class HistogramChart extends StatelessWidget {
  
  final Histogram histogram;
  final int fixed;

  const HistogramChart(this.histogram, {super.key, this.fixed = 0});

  @override
  Widget build(BuildContext context) {
    final xy = histogram.getData();
    final x = xy.x.toList();
    final y = xy.y.toList();

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
                        return Text("${range.$1!.toStringAsFixed(fixed)}-${range.$2!.toStringAsFixed(fixed)}");
                      }
                      if(range.$1 != null){
                        return Text("<${range.$1}");
                      }
                      if(range.$2 != null){
                        return Text(">${range.$2}");
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
