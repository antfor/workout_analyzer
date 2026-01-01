import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/chart/chart.dart';
import 'package:test_flutter/ui/exercises/components/rep_pb.dart';
import 'package:test_flutter/ui/exercises/components/strength_level.dart';
import 'package:test_flutter/ui/exercises/components/value.dart';
import 'package:test_flutter/ui/util.dart';

final double bodyWeight = 75;
final sex = Sex.male;

class ExerciseInfo extends StatelessWidget {

  final LiftInfo info;

  const ExerciseInfo(this.info, {super.key});

  @override
  Widget build(BuildContext context) {

    final standard = sex == Sex.male ? info.maleStandard : info.femaleStandard;
    final strength =  StrengthLevel(standard, bodyWeight, info.values.orm.value);
    

    final maxWidth = const BoxConstraints(maxWidth: 500);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));
    

    return ListView(children: [
      pad(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [H1(info.id),Text('Muscle: ${info.muscle.string}', style: TextStyle(color: Colors.grey,),)])),
      //pad(H3('Records')),
      pad(Chart(info.graphs, info.bucketGraphs)),
      pad(valueTable(info.values)),
      constrain(strength) ,
      //pad(H3("PR's")),
      constrain(repPbTableFiltered(info.tables.repPB))
      
    ]);
    
  }
}