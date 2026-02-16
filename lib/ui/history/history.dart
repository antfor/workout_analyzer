import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/ui/util.dart';
import '/domain/info/lift_info.dart';
import '/domain/workout.dart';

class History extends StatelessWidget{ //TODO impove preformance
  
  final bool groupByDate;
  final LiftBasicInfo? lift;
  final DateTime? day; //TODO for modal popup in calender on summary page
  final List<Workout> workouts;
  final Workout? selected;
  final void Function(Workout) setWorkout;

  const History(this.workouts, this.selected ,this.setWorkout, {super.key, this.day, this.lift, this.groupByDate = true });

  @override
  Widget build(BuildContext context) {

    List<Workout> history = workouts;

    if(lift != null){
      history = workouts.where((w)=> w.exercises.any((e)=> e.id == lift?.id)).toList();
    }

    if(day != null){
      history = workouts.where((w) => isSameDay(w.startTime, day)).toList();
    }

    if(groupByDate){
      //TODO ExpansionTile for each Month?, paginator for months, tabs by by year, week?
      final years = history.map((w) => w.startTime.year).toSet().toList()..sort((a,b)=> b.compareTo(a));
      final tabs = years.map((y) => listBuilder(history, selected, setWorkout, lift, year:y));

      return DefaultTabController(
        initialIndex: 0,
        length: years.length,
          child:Column(
          children: [
            TabBar(
            tabs: years.map((y) => H3(y.toString())).toList(),
            isScrollable: true,
            ),
            Expanded(child:
              TabBarView(
                children: tabs.toList(),
              )
            )
          ])
        );
    }

    return listBuilder(history, selected, setWorkout, lift);
  }
  
}

Widget listBuilder(Iterable<Workout> history, final Workout? selected, void Function(Workout) setWorkout, LiftBasicInfo? lift, {int? year, int? month}){

  if(year != null){
    if(month != null){
      history = history.where((w) => w.startTime.year == year && w.startTime.month == month);
    }else{
      history = history.where((w) => w.startTime.year == year);
    }
  }

  final data = history.toList();

  return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Align( child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600,), 
                child: WorkoutItem(data[index], data[index] == selected, setWorkout, lift?.id)));
            },
          );
}

Widget monthView(Iterable<Workout> history, final Workout? selected, void Function(Workout) setWorkout, LiftBasicInfo? lift, {required int year}){
  //TODO make look like this https://api.flutter.dev/flutter/widgets/PageView-class.html
  final controller = PageController(initialPage: 0);
  
  final months = <int>{};

  for (final w in history) {
    if (w.startTime.year == year) {
      months.add(w.startTime.month);
    }
  }

  final sortedMonths = months.toList()..sort((b, a) => a.compareTo(b));

  return PageView(
    controller: controller,
    children: [ for(final month in sortedMonths) listBuilder(history, selected, setWorkout, lift, year: year, month: month)],
  );
}

class WorkoutItem extends StatelessWidget{

    final Workout workout;
    final bool selected;
    final void Function(Workout) setWorkout;
    final String? filterId;
 
    const WorkoutItem(this.workout, this.selected, this.setWorkout, this.filterId, {super.key});
      
    @override
    Widget build(BuildContext context) {
        return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16), 
          child: Card( child: Column(children: [
            ListTile(
              selected: selected,
              onTap: () => setWorkout(workout),
              title: Text(workout.title),
              subtitle: getInfo(workout, context),
            ),
            ?exerciseList(workout, filterId),
          ]),
          ));
    }
}

Widget? exerciseList(Workout workout, String? filterId){

  final exercises = workout.getWorkoutExersiseInfo(filterId);

  if(exercises.isEmpty) return null;

  return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [ for (final e in exercises) ExerciseTile(e) ],
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

  final exercises = workout.exercises;
  final cardio = workout.cardio;

  final volume = exercises.fold<double>(0,(s,e)=> s + e.volume).toStringAsFixed(0);
  final distance = cardio.fold<double>(0, (s,c)=> s + c.distanceKm).toStringAsFixed(0);
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
          if(exercises.isNotEmpty) infoWithTitle('Volume',Text('$volume kg'),context),
          if(cardio.isNotEmpty && exercises.isEmpty) infoWithTitle('distance',Text('$distance km'),context),
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
