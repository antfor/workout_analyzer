import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/ui/chart/line_chart.dart';

class Chart extends StatefulWidget {

  final Graphs graphs; 
  const Chart(this.graphs,{super.key});

  @override
  State<Chart> createState() => _Chart();
}

enum Span{
  month3(0,3,0),
  month6(0,6,0),
  year(0,0,1),
  all(0,0,0);

  final int days;
  final int months;
  final int years;

  const Span(this.days, this.months, this.years);
}

enum CharType{
  orm,
  wight,
  volume;
}

class _Chart extends State<Chart> {

  Span duration = Span.month3;
  CharType type = CharType.orm;
  History history = History.indevidual;

  @override
  Widget build(BuildContext context) {

     
    List<double> data; 

    switch(type){
      case CharType.orm: data=widget.graphs.ormOverTime; break;
      case CharType.wight: data=widget.graphs.weightOverTime; break;
      case CharType.volume: data=widget.graphs.volumeOverTime; break;
    }

    final xy = widget.graphs.getLatestGraphData(data, history,currentTime:false, days:duration.days, months: duration.months, years: duration.years);

    final x = xy.keys.toList();
    final y = xy.values.toList();

    return BasicLineChart(x, y);
  }
}
