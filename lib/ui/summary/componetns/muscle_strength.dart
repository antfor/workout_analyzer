
//TODO click on bar so it is deselected, if beg is deselected then the color spectrum can go from Nov-Elite
// Making it easier to tell diffrence, and begginer is not used that ofthen
// or just cheack boxes under (adv and elite can share state)
// or just min streng level to max strength level, so if you are only Nov and Int on lift, only them will be on the spectrum
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/domain/info/lift_info.dart';
import '/domain/standards/muscle_group.dart';
import '/domain/standards/standards.dart';
import '/ui/components/progressbar.dart';
import '/ui/util.dart' as util;

Widget muscleStrengthBar(){
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

Widget strengthList(Map<Muscle, LiftBasicInfo> maxStrenghLevel, Sex sex, double bodyWeight){

  final list = maxStrenghLevel.entries
    .map((e) => (e.key, e.value,  e.value.getLevel(sex, bodyWeight)))
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

Widget muscleStrength(Map<Muscle, LiftBasicInfo> maxStrenghLevel, Sex sex, double bodyWeight){
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

