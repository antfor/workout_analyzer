import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/workout.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:test_flutter/ui/summary/componetns/calender.dart';
import 'package:test_flutter/ui/summary/componetns/muscle_strength.dart';
import 'package:test_flutter/ui/summary/componetns/streak.dart';
import 'package:test_flutter/ui/util.dart' as util;

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
    pad(Widget? w) => w == null ? null : Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));

    final maxStrenghLevel = getMaxStrenghLevel(lifts, settings.sex, _bodyWeight);
    //final minStrenghLevel = maxStrenghLevel.reduce((a,b)=>)
    
    return ListView(children: [
      constrain(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          //util.H2("Calender"),
          ?pad(streak(workouts)),
          ?pad(calender(workouts)),
          util.H2("Muscle Strength"),
          muscleStrength(maxStrenghLevel, settings.sex, _bodyWeight),
          ?pad(muscleStrengthBar()),
          ?pad(strengthList(maxStrenghLevel, settings.sex, _bodyWeight)),
          //util.H2("Sets this week"),//week,month year
          //util.H2("max volume"),//week,month year
          //util.H2("Heviest weight"),
         
        ],)),
    ]);

  }
}
