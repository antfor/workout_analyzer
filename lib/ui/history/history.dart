import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/domain/info/lift_info.dart';
import '/domain/workout.dart';

class History extends StatelessWidget{ //TODO impove preformance
  
  final LiftBasicInfo? lift;
  final List<Workout> workouts;
  final void Function(Workout) setWorkout;

  const History(this.lift, this.workouts, this.setWorkout, {super.key});

  @override
  Widget build(BuildContext context) {

    List<Workout> history = workouts;

    if(lift != null){
      history = workouts.where((w)=> w.exercises.any((e)=> e.id == lift!.id)).toList();
    }

    return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Align( child: ConstrainedBox(
                   constraints: BoxConstraints(maxWidth: 600,), 
                   child: WorkoutItem(history[index], setWorkout)));
                },
            );
  }
  
}

class WorkoutItem extends StatelessWidget{

    final Workout workout;
    final void Function(Workout) setWorkout;
 
    const WorkoutItem(this.workout, this.setWorkout, {super.key}); //this.selected, this.setWorkout,
      
    @override
    Widget build(BuildContext context) {
        return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16), 
          child: Card( child: Column(children: [
            ListTile(
              selected: false,
              onTap: () => setWorkout(workout),
              title: Text(workout.title),
              subtitle: getInfo(workout, context),
            ),
            exerciseList(workout),
          ]),
          ));
    }
}

Widget exerciseList(Workout workout){

  final exercises = workout.getWorkoutExersiseInfo();


  return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [ for (final e in exercises) ExerciseTile(e), ],
            ),
          ),
        );     
}

class ExerciseTile extends StatelessWidget{

    final WorkoutExersiceInfo info;

    const ExerciseTile(this.info, {super.key});
      
    @override
    Widget build(BuildContext context) {

        final scheme = Theme.of(context).colorScheme;

        return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16), 
          child: Card(
            color: scheme.surfaceContainerHigh,
            child: ListTile(
              onTap: () => 1 , //TODO navigate to exersice info
              leading: FlutterLogo(size: 56.0),
              title: Text(info.id),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  infoWithTitle('Sets', Text(info.sets.toString()), context),
                  infoWithTitle('Volume', Text('${info.volume.toStringAsFixed(0)} kg'), context),
                  infoWithTitle('max set Volume', Text('${info.maxSetVolume.toStringAsFixed(0)} kg'), context),
                  infoWithTitle('max set 1RM', Text('${info.maxOrm.toStringAsFixed(2)} kg'), context),
                  infoWithTitle('max Weight', Text('${info.maxWeight.toStringAsFixed(2)} kg'), context),
                ],),
            ),
          ));
    }
}

Widget getInfo(Workout workout, BuildContext context){
  final start = workout.startTime;
  final end = workout.endTime;
  final formatter = DateFormat('EEEE, MMM d, yyyy'); 
  final volume = workout.exercises.fold<double>(0,(s,e)=> s + e.volume).toStringAsFixed(0);
  final distance = workout.cardio.fold<double>(0, (s,c)=> s + c.distanceKm);
  final records = 1;

  return Column( 
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(formatter.format(start)),
      Row(
        mainAxisAlignment:MainAxisAlignment.start,
        spacing: 16,
        children: [
          infoWithTitle('Duration',Text(getDuration(start, end)),context),
          if(workout.exercises.isNotEmpty) infoWithTitle('Volume',Text('$volume kg'),context),
          if(workout.cardio.isNotEmpty && workout.exercises.isEmpty) infoWithTitle('distance',Text('$distance km'),context),
          if(records > 0) infoWithTitle('Records' ,Row(
            spacing: 2,
            children: [
            Icon(
              Icons.workspace_premium, 
              color: Colors.amber,
              size: DefaultTextStyle.of(context).style.fontSize,
            ),
            Text(records.toString())],),context),
      ],)
    ]);
}

String getDuration(DateTime start, DateTime end){
  final duartion = end.difference(start);
  final hours = duartion.inHours; 
  final minutes = duartion.inMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return '${hours}h ${minutes}min';
  } else if (hours > 0) {
    return '${hours}h';
  } else {
    return '${minutes}min';
  }
}

Widget infoWithTitle(String title, Widget info, BuildContext context){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$title:', style: TextStyle(fontSize: 12, color: Colors.grey) ),
      info,
    ],
  );
}

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper({super.key, required this.child});

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
