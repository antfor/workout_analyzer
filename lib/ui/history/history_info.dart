


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/domain/workout.dart';
import '/ui/util.dart' as util;

class HistoryInfo extends StatelessWidget{

  final Workout workout;

  const HistoryInfo(this.workout, {super.key});
  
  @override
  Widget build(BuildContext context) {

    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    final formatter = DateFormat('EEEE, MMM d, yyyy'); 
    
    return  ListView(children: [
      pad(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [util.H1(workout.title),Text(formatter.format(workout.startTime), style: TextStyle(color: Colors.grey,),)])),
    ]);
  }

}