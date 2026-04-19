import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/exercise.dart';
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
      constrain(cardios(workout, context)),
      constrain(exercises(workout, context)),
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

Widget exercises(Workout workout, BuildContext context){

  final exercisesIds = workout.exercises.map((e) => e.id).toSet();

  return Column(children: [
    ...exercisesIds.map((id)=>exercise(id, workout, context)),

  ],);
}

Widget exercise(String id, Workout workout, BuildContext context){

  final exercises = workout.exercises.where((w)=>w.id == id);
  
  //final list = exercises.map((e) => lift(e, context));
  
  return( Card( 
    //margin: EdgeInsets.all(8.0),
    child: Padding(padding: EdgeInsetsGeometry.all(16), child:
      ListBody(
        children: [
          H3(id),
          summary(exercises),
          //...list,
          liftTable(exercises),
        ],
      ))
  ));
}

Widget summary(Iterable<Exercise> lifts){

  final sets = lifts.length.toString();
  final volume = lifts.fold<double>(0,(a,e)=>a+e.volume).toString(); 
  final sesionORM = lifts.fold<double>(0,(a,e)=> math.max(a, e.orm)).toStringAsFixed(2);  
  //final currentORM = lifts.first.exerciseORM().toStringAsFixed(2); 
  
  return(
    Row(
      spacing: 8,
      children:[
        infoWithTitle("Sets",Text(sets)),
        infoWithTitle("Total Volume",Text(volume)),
        infoWithTitle("Sesion 1RM",Text(sesionORM)),
        //infoWithTitle("1RM at the time",Text(currentORM)),
      ]
    )
  );
}

Widget lift(Exercise lift, BuildContext context){

  final scheme = Theme.of(context).colorScheme;
  return(Card(
    color: scheme.surfaceContainerHigh,
    child:ListTile(
      title: Row(
        spacing: 8,
        children:[
          infoWithTitle("Reps",Text(lift.reps.toString())),
          infoWithTitle("Weight",Text(lift.weightKg.toString())),
          infoWithTitle("Volume",Text(lift.volume.toString())),
          infoWithTitle("1RM", Text(lift.orm.toStringAsFixed(2))),
      ]),
  )));
}

Widget liftTable(Iterable<Exercise> lifts){

  return DataTable(
      columns: const [
        DataColumn(label: Center(child:Text('Reps'))),
        DataColumn(label: Center(child:Text('Weight'))),
        DataColumn(label: Center(child:Text('Volume'))),
        DataColumn(label: Center(child:Text('1RM'))),
        //DataColumn(label: Center(child:Text('%'))),
      ],
      rows: lifts.map((e) => liftRow(e)).toList(),
      //border: TableBorder.symmetric(outside: BorderSide()),
  );
}

DataRow liftRow(Exercise lift){
  
  return(
    DataRow(cells:[
      DataCell(Text(maxLines: 1,"${lift.reps}")),
      DataCell(Text(maxLines: 1,"${lift.weightKg} kg")),
      DataCell(Text(maxLines: 1,"${lift.volume} kg")),
      DataCell(Text(maxLines: 1,"${lift.orm.toStringAsFixed(2)} kg")),
      //DataCell(Text(maxLines: 1,"${(lift.percantage()*100).toStringAsFixed(0)}%")),
    ],
  ));
}

Widget cardios(Workout workout, BuildContext context){
  final cardioIds = workout.cardio.map((e) => e.id).toSet();

  return Column(children: [
    ...cardioIds.map((id)=>cadio(id, workout, context)),
  ],);
}

Widget cadio(String id, Workout workout, BuildContext context){

  final cardio = workout.cardio.where((w)=>w.id == id);

  return( Card( 
    //margin: EdgeInsets.all(8.0),
    child: Padding(padding: EdgeInsetsGeometry.all(16), child:
      ListBody(
        children: [
          H3(id),
          //cardioSummary(cardio),
          //...list,
          cardioTable(cardio),
        ],
      ))
  ));
}


Widget cardioTable(Iterable<Cardio> cardio){

  return DataTable(
      columns: [
        DataColumn(label: Center(child:Text('Lap'))),
        DataColumn(label: Center(child:Text('Distance'))),
        DataColumn(label: Center(child:Text('Time'))),
        DataColumn(label: Center(child:Text('Pace'))),
        //DataColumn(label: Center(child:Text('%'))),
      ],
      rows: cardio.indexed.map((ci) => cardioRow(ci.$2, ci.$1)).toList(),
      //border: TableBorder.symmetric(outside: BorderSide()),
  );
}

DataRow cardioRow(Cardio cardio, int lap){
  final pace = cardio.pace;

  return(
    DataRow(cells:[
      DataCell(Text(maxLines: 1, "${lap + 1}")),
      DataCell(Text(maxLines: 1, "${cardio.distanceKm.toStringAsFixed(2)} km")),
      DataCell(Text(maxLines: 1, cardio.duration)),
      DataCell(Text(maxLines: 1, "${pace.min} : ${pace.sec.toStringAsFixed(1)} /km")),
    ],
  ));
}