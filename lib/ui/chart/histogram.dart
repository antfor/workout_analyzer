import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistogramChart extends StatelessWidget {
  
  final List<(double?, double?)> x;
  final List<num> y;
  final int fixedX;
  final bool percentage;
  final bool barChart;
  //final int fixedY;

  const HistogramChart(this.x, this.y, this.barChart, {super.key, this.fixedX = 0, this.percentage = false});

  @override
  Widget build(BuildContext context) {
  
    final double reservedSize = 44;
    return SizedBox(
        height: 300,
        child:
          BarChart(
            key: ValueKey('${x.join(",")}_${y.join(",")}'),
            BarChartData(
              barGroups: _getGroups(y),
              titlesData: FlTitlesData( 
                leftTitles:  AxisTitles( sideTitles: SideTitles(showTitles: false), ),
                topTitles:  AxisTitles( sideTitles: SideTitles(showTitles: false), ),
                rightTitles: AxisTitles(sideTitles: SideTitles(
                  reservedSize: reservedSize,
                  showTitles: true, 
                )),
                 bottomTitles: AxisTitles( 
                  sideTitles: SideTitles( 
                    showTitles: true, 
                    getTitlesWidget: (value, meta) {
                      if(barChart){
                        final ms = (x[value.toInt()].$1 ?? 0).toInt();
                        final date = DateTime.fromMillisecondsSinceEpoch(ms);
                        if(value % 2 == 0 || x.length < 10){
                          return Text("${date.month}/${date.day}"); //TODO based on Span if span is month only show month...
                        }
                        return Text("");
                      }else{
                        final range = x[value.toInt()];
                        final v1 = ((percentage ? 100 : 1) * (range.$1 ?? 0)).toStringAsFixed(fixedX) + (percentage ? "%":"");
                        final v2 = ((percentage ? 100 : 1) * (range.$2 ?? 0)).toStringAsFixed(fixedX) + (percentage ? "%":"");
                        
                        if(range.$1 != null && range.$2 != null){
                          if(range.$1 == range.$2){
                            return Text(v1);
                          }
                          return Text("$v1-$v2");
                        }
                        if(range.$1 != null){
                          return Text("<$v1");
                        }
                        if(range.$2 != null){
                          return Text(">$v2");
                        }
                        return Text("");
                      }
                    },
                  ), 
                ),
              ),
              barTouchData: BarTouchData( 
                touchTooltipData: BarTouchTooltipData( 
                  getTooltipItem: (group, groupIndex, rod, rodIndex) { 
                    if(barChart){
                      final text = rod.toY.toStringAsFixed(fixedX); 
                      return BarTooltipItem(text, TextStyle()); 
                    }else{
                      final value = rod.toY * 100;
                      final text = "${value.round()}%"; 
                      return BarTooltipItem(text, TextStyle()); 
                    }
                  }, 
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
