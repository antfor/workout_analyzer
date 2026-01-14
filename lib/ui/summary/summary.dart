import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/collection.dart';
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
    
    return ListView(children: [
      constrain(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          util.H2("Muscle Strength"),
          svg(lifts),
          pad(bar()),
          util.H2("Sets this week"),//week,month year
          svg(lifts),

          util.H2("max volume"),//week,month year
          util.H2("Heviest weight"),
         
        ],)),
    ]);

  }
}


Widget bar(){
  final levels = Level.values;
  final bars = List.generate(Level.values.length, (i) => 
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

  final Multimap<Muscle,LiftBasicInfo> mapLifts;
  final Sex sex;
  final double bodyWeight;

  _MyColorMapper(List<LiftBasicInfo> lifts, this.sex, this.bodyWeight):
    mapLifts = Multimap.fromIterable(lifts, key:(l)=> l.muscle, value:(l) => l);

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color,) {

    final muscle = Muscle.fromString(id ?? "");
    final lifts = mapLifts[muscle].toList();


    if(lifts.isEmpty || muscle == Muscle.other){
      return color;
    }

    double getLevel(LiftBasicInfo l) {
        final info = l.getInfo();
        final orm = info.values.orm.value ;

        final standard  = sex == Sex.male ? info.maleStandard : info.femaleStandard;
        final strengthLevel = standard.weight ?? standard.reps;
        if(strengthLevel != null){
          return strengthLevel.levelValue(bodyWeight, orm);
        }   

        return 0;
    }

    final strengthLevel = lifts.fold<double>(0,(t, l) {
        final level = getLevel(l);
        return  level > t ? level : t;
      });
    
    final colors = [color, ...util.spectrum];

    final iPrev = math.max(0, strengthLevel.ceil());
    final iNext = math.min(colors.length-1, (strengthLevel +1).ceil());
    final fraction = strengthLevel - strengthLevel.ceil();
    
    return  Color.lerp(colors[iPrev],colors[iNext],fraction) ?? color;
  }
}

Widget svg(List<LiftBasicInfo> info){
  return(
    FittedBox(child: 
      SvgPicture.asset(
        'assets/images/man.svg',
        fit: BoxFit.contain,
        semanticsLabel: 'Man',
        colorMapper: _MyColorMapper(info, sex, bodyWeight),
    ))
  );
}

