import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/collection.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/components/progressbar.dart';
import 'package:test_flutter/ui/util.dart';
import 'package:test_flutter/ui/util.dart' as util;

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
          H2("Muscle Strength"),
          svg(lifts),
          pad(bar()),
          H2("Sets this week"),//week,month year
          svg(lifts),

          H2("max volume"),//week,month year
          H2("Heviest weight"),
         
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
      startColor: i>=spectrum.length ? util.spectrum.last : util.spectrum[i], 
      endColor: i+1>=spectrum.length ? util.spectrum.last : util.spectrum[i+1], 
      headline: Text(levels[i].shortLabel, maxLines: 1, overflow: TextOverflow.ellipsis),
    )
  ));

  return Row(spacing: 3, children: bars);
}

/*
	.s0 { fill: #808284 } 
		.s1 { fill: #bbbdbf } 
		.s2 { fill: #ec1c24 } 
		.s3 { fill: #e6e7e8 } 
*/

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
    
    // 0,    1,  2,  3,  4,  5
    // start,big,nov,ind,adv,elite
     //Colors.amberAccent.shade400; color +60
    final big = const Color.fromARGB(255, 255, 0+63*4, 0);
    final nov = const Color.fromARGB(255, 255, 0+63*3, 0);
    final ind = const Color.fromARGB(255, 255, 0+63*2, 0);
    final adv = const Color.fromARGB(255, 255, 0+63*1, 0);
    final elite=const Color.fromARGB(255, 255, 0+63*0, 0);
    //final colors = [color, big, nov, ind, adv, elite];

    final spectrum = List.generate(5, (i) => Color.fromARGB(255, 255, 51*(4-i), 0));
    final colors = [color, ...spectrum]; //color is the default gray color

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

