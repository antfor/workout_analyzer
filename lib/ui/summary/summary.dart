import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/domain/workout.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:test_flutter/ui/components/progressbar.dart';
import 'package:test_flutter/ui/util.dart' as util;
import 'dart:math' as math;

final double _bodyWeight = 75;

class Summary extends ConsumerWidget {

  final List<LiftBasicInfo> lifts;
  final List<Workout> workouts;

  const Summary(this.lifts, this.workouts, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settings = ref.watch(settingsProvider);

    final maxWidth = const BoxConstraints(maxWidth: 400);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));

    final maxStrenghLevel = getMaxStrenghLevel(lifts, settings.sex, _bodyWeight);
    //final minStrenghLevel = maxStrenghLevel.reduce((a,b)=>)
    
    return ListView(children: [
      constrain(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          //util.H2("Calender"),
          //pad(streak(workouts)),
          pad(calender(workouts)),
          util.H2("Muscle Strength"),
          svg(maxStrenghLevel, settings.sex, _bodyWeight),
          pad(bar()),
          pad(strengthList(maxStrenghLevel, settings.sex)),
          //util.H2("Sets this week"),//week,month year
          //util.H2("max volume"),//week,month year
          //util.H2("Heviest weight"),
         
        ],)),
    ]);

  }
}

Widget streak(List<Workout> workouts){
 

  final int streak = 20;
  final double sizeFactor = math.min(streak/52, 1);
  final double flameSize = 10 + 20*sizeFactor; //TODO size depends on streak length
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if(streak !=0) Lottie.asset('assets/images/fire_lottie.json', width: flameSize, height: flameSize),
      if(streak !=0) Text(" $streak week streak! "),
      if(streak !=0) Lottie.asset('assets/images/fire_lottie.json', width: flameSize, height: flameSize),
    ],);
}


bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
}

List<Workout> events(DateTime date, List<Workout> workouts){

  final events = workouts.where((w)=> isSameDay(w.startTime, date));
  return events.toList();
}

Widget calender(List<Workout> workouts){
  //todo min size
  return TableCalendar<Workout>(
    firstDay: DateTime.utc(2000, 1, 1),
    lastDay: DateTime.now(),
    focusedDay: DateTime.now(),
    eventLoader: (d)=>events(d, workouts),

    //pageJumpingEnabled: true,
    startingDayOfWeek: StartingDayOfWeek.monday,
    weekNumbersVisible: true,
    availableCalendarFormats: {CalendarFormat.month: 'Month'},
    calendarStyle: CalendarStyle( 
      outsideDaysVisible: false,
      todayTextStyle: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold),
      todayDecoration: const BoxDecoration(),
    ),

    calendarBuilders: CalendarBuilders(
       markerBuilder: (context, date, events) {

        if (events.isEmpty) return null;
  
        Color getColor(Workout w) => w.exercises.isNotEmpty? Colors.deepOrangeAccent.shade400 : Colors.blueAccent.shade400 ; 

        return Transform.translate( offset: const Offset(0, -6),
          child: SizedBox(
          height: 6,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: events.take(4).map((event) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(event),
              ),
            );
          }).toList(),
          ))
        );
      },
      defaultBuilder: (context, day, focusedDay) {
        final events = workouts.where((w)=>isSameDay(w.startTime,day));

        Color color = Colors.orange.shade400;
     
        final textColor = Colors.black;

        if (events.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          );
        }

        return null; // use default rendering
      },
    ),
  );
}



//TODO click on bar so it is deselected, if beg is deselected then the color spectrum can go from Nov-Elite
// Making it easier to tell diffrence, and begginer is not used that ofthen
// or just cheack boxes under (adv and elite can share state)
// or just min streng level to max strength level, so if you are only Nov and Int on lift, only them will be on the spectrum
Widget bar(){
  final start = 0;
  final end = 5 - 0;
  final levels = Level.values.getRange(start, end).toList();
  final bars = List.generate(levels.length, (i) => 
  Expanded( child:
    GradientProgressBar(
      value: 1, 
      startColor: i>=util.spectrum.length ? util.spectrum.last : util.spectrum[i], 
      endColor: i+1>=util.spectrum.length ? util.spectrum.last : util.spectrum[i+1], 
      headline: Text(levels[i].shortLabel, maxLines: 1, overflow: TextOverflow.ellipsis),
    )
  ));

  return Row(spacing: 3, children: bars);
}

class _MyColorMapper extends ColorMapper {

  final Map<Muscle, LiftBasicInfo> maxStrenghLevel;
  final Sex sex;
  final double bodyWeight;

  const _MyColorMapper(this.maxStrenghLevel, this.sex, this.bodyWeight);

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color,) {

    final muscle = Muscle.fromString(id ?? "");
    final lift = maxStrenghLevel[muscle];

    if(lift == null || muscle == Muscle.other){
      return color;
    }
    
    final strengthLevel = lift.getLevel(sex, bodyWeight);
 
    return  getLerpColor(strengthLevel, defaultColor: color);
  }
}

 Color getLerpColor(double level, {Color defaultColor = Colors.grey}){

    final start = 0;
    final end = 0;
    final len = 5 - start - end;
  
    final colors = [defaultColor, ...util.spectrumN(len)];

    final iPrev = math.min(math.max(0, level.floor()), colors.length-1);
    final iNext = math.max(0,math.min(colors.length-1, (level +1).floor()));
    final fraction = level - level.floor();
    
    return  Color.lerp(colors[iPrev],colors[iNext],fraction) ?? defaultColor;
}

Widget strengthList(Map<Muscle, LiftBasicInfo> maxStrenghLevel, Sex sex){

  final list = maxStrenghLevel.entries
    .map((e) => (e.key, e.value,  e.value.getLevel(sex, _bodyWeight)))
    .toList();

  list.sort((a,b)=> b.$3.compareTo(a.$3));

  String getPer(double level){
    if(level == 5){
      return ",        ";
    }
    final percent = ((level-level.toInt())*100).truncate();
    final spacing = percent < 10 ? " " : "";
    return ": $percent%$spacing,";
  }

  Widget getBar(double level, String exercise)=> GradientProgressBar(
      value: level == 5 ? 1 : level-level.toInt(), 
      startColor: getLerpColor(level), 
      endColor: getLerpColor(level), 
      headline: Text('${Level.byIndex(level.toInt()).shortLabel}${getPer(level)}    Exersice: $exercise', maxLines: 1, overflow: TextOverflow.ellipsis),
  );

  return ExpansionTile(
          title: Text('Stength breakdown'),
          children: list.map<Widget>((v)=>
              ListTile(
                title: Text(v.$1.string, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: 
                  getBar(v.$3, v.$2.id),
                onTap: ()=>1,  //TODO navigate to exersise
              )
            ).toList(),
        );
}

Map<Muscle, LiftBasicInfo> getMaxStrenghLevel(List<LiftBasicInfo> lifts, Sex sex, double bodyWeight){

  final muscles = lifts.map((lift) => lift.muscle).toSet();
  Map<Muscle, LiftBasicInfo> maxStrength = {};

  for(final muscle in muscles){

    if(!(muscle == Muscle.other || muscle == Muscle.cardio || muscle == Muscle.fullBody)){
      final liftsForMuscle = lifts.where((l)=>l.muscle==muscle);

      if(liftsForMuscle.isNotEmpty){

        final strengthLevel = liftsForMuscle.reduce((a, b) {
          return b.getLevel(sex,bodyWeight) > a.getLevel(sex,bodyWeight) ? b : a;
        });

        maxStrength[muscle] = strengthLevel;
      }
      
    }

  }

  return maxStrength;
}

Widget svg(Map<Muscle, LiftBasicInfo> maxStrenghLevel, Sex sex, double bodyWeight){
  return(
    FittedBox(child: 
      SvgPicture.asset(
        'assets/images/man.svg',
        fit: BoxFit.contain,
        semanticsLabel: 'Man',
        colorMapper: _MyColorMapper(maxStrenghLevel,sex,bodyWeight),
    ))
  );
}

