import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/components/progressbar.dart';
import 'package:test_flutter/ui/util.dart' as util;
import 'dart:math' as math;

final double bodyWeight = 75;
final sex = Sex.male;

class Summary extends StatelessWidget {

  final List<LiftBasicInfo> lifts;

  const Summary(this.lifts, {super.key});

  @override
  Widget build(BuildContext context) {

    final maxWidth = const BoxConstraints(maxWidth: 400);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));

    final maxStrenghLevel = getMaxStrenghLevel(lifts, sex, bodyWeight);
    //final minStrenghLevel = maxStrenghLevel.reduce((a,b)=>)
    
    return ListView(children: [
      constrain(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          util.H2("Muscle Strength"),
          svg(maxStrenghLevel, sex, bodyWeight),
          pad(bar()),
          pad(strengthList(maxStrenghLevel)),
          util.H2("Sets this week"),//week,month year
          util.H2("max volume"),//week,month year
          util.H2("Heviest weight"),
         
        ],)),
    ]);

  }
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
    
    final start = 0;
    final end = 0;
    final len = 5 - start - end;
  
    final colors = [color, ...util.spectrumN(len)];

    final strengthLevel = getLevel(lift, sex, bodyWeight);

    final iPrev = math.min(math.max(0, strengthLevel.floor()), colors.length-1);
    final iNext = math.max(0,math.min(colors.length-1, (strengthLevel +1).floor()));
    final fraction = strengthLevel - strengthLevel.floor();
    
    return  Color.lerp(colors[iPrev],colors[iNext],fraction) ?? color;
  }
}

Widget strengthList(Map<Muscle, LiftBasicInfo> maxStrenghLevel){

  return const ExpansionTile(
          title: Text('Stength breakdown'),
          children: <Widget>[ListTile(title: Text('This is tile number 1'))],
        );
}


double getLevel(LiftBasicInfo l, Sex sex, double bodyWeight) {//todo move to info
    final info = l.getInfo();
    final orm = info.values.orm.value ;

    final standard  = sex == Sex.male ? info.maleStandard : info.femaleStandard;
    final strengthLevel = standard.weight ?? standard.reps;
    if(strengthLevel != null){
      return strengthLevel.levelValue(bodyWeight, orm);
    }   

    return 0;
}

Map<Muscle, LiftBasicInfo> getMaxStrenghLevel(List<LiftBasicInfo> lifts, Sex sex, double bodyWeight){

  final muscles = lifts.map((lift) => lift.muscle).toSet();
  Map<Muscle, LiftBasicInfo> maxStrength = {};

  for(final muscle in muscles){

    if(!(muscle == Muscle.other || muscle == Muscle.cardio || muscle == Muscle.fullBody)){
      final liftsForMuscle = lifts.where((l)=>l.muscle==muscle);

      if(liftsForMuscle.isNotEmpty){

        final strengthLevel = liftsForMuscle.reduce((a, b) {
          return getLevel(b,sex,bodyWeight) > getLevel(a,sex,bodyWeight) ? b : a;
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

