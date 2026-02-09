import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_flutter/domain/workout.dart';
import 'dart:math' as math;

Widget? streak(List<Workout> workouts){
 
  int streak = 0;
  if(workouts.isNotEmpty){
    final weeks = workouts.map((w)=>w.week).toSet().toList()..sort((a, b) => b.compareTo(a));

    final currentWeek = WeekYear(DateTime.now());
    final latestWeek = weeks.first;

    if(latestWeek == currentWeek || latestWeek == currentWeek.prev){
      WeekYear nextWeek = weeks.first;
      for(final week in weeks){

        final dif = week.difInWeeks(nextWeek);
        
        if(dif == 1 || dif ==0){
          streak += 1;
        }else{
          break;
        }

        nextWeek = week;
      }
    }

  }
  
  final double sizeFactor = math.min(streak/52, 1);
  final double flameSize = 10 + 20*sizeFactor;

  if(streak ==0){
    return null;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset('assets/images/fire_lottie.json', width: flameSize, height: flameSize),
      Text(" $streak week streak! "),
      Lottie.asset('assets/images/fire_lottie.json', width: flameSize, height: flameSize),
    ],);
}