import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_analyzer/ui/history/components/workout_tables.dart';
import '/domain/workout.dart';
import '/ui/util.dart';

class HistoryInfo extends StatelessWidget{

  final Workout workout;
  final void Function() exit;

  const HistoryInfo(this.workout, this.exit, {super.key});
  
  @override
  Widget build(BuildContext context) {

    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    final maxWidth = const BoxConstraints(maxWidth: 700);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));
    
    
    return  ListView(children: [
      pad(_header(workout, exit, context)),
      constrain(workoutTables(workout, context, spacing:8)),
    ]);
  }
}

Widget _header(Workout workout, void Function() exit, BuildContext context){

  final formatter = DateFormat('EEEE, MMM d, yyyy'); 
  final subHeadline =Text(formatter.format(workout.startTime), style: TextStyle(color: Colors.grey,),);

  final headline =   Column(crossAxisAlignment: CrossAxisAlignment.start, 
    children: [H1(workout.title),subHeadline]);
  
  final fontSize = Theme.of(context).textTheme.headlineLarge?.fontSize ?? 20;
  final exitButton = IconButton(onPressed: exit, icon: Icon(Icons.close, size: fontSize));

  return Row( 
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [headline, exitButton],);
}