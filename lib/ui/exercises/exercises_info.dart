import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:test_flutter/ui/chart/chart.dart';
import 'package:test_flutter/ui/exercises/components/rep_pb.dart';
import 'package:test_flutter/ui/exercises/components/strength_level.dart';
import 'package:test_flutter/ui/exercises/components/value.dart';
import 'package:test_flutter/ui/util.dart';

final double _bodyWeight = 75;

class ExerciseInfo extends ConsumerWidget {

  final LiftInfo info;
  final void Function() exit;

  const ExerciseInfo(this.info, this.exit, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settings = ref.watch(settingsProvider);
    final standard = settings.sex == Sex.male ? info.maleStandard : info.femaleStandard;
    final strength =  StrengthLevel(standard, _bodyWeight, info.values.orm.value);
    

    final maxWidth = const BoxConstraints(maxWidth: 500);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));
    

    return ListView(children: [//TODO add tab bar with info,history and the exit button
      pad(_header(info, exit, context)),
      //pad(H3('Records')),
      pad(Chart(info.graphs, info.bucketGraphs)),
      pad(valueTable(info.values)),
      constrain(strength) ,
      //pad(H3("PR's")),
      constrain(repPbTableFiltered(info.tables.repPB))
      
    ]);
    
  }
}

Widget _header(LiftInfo info, void Function() exit, BuildContext context){
  final subHeadline = Text('Muscle: ${info.muscle.string}', style: TextStyle(color: Colors.grey,),);
  final headline =   Column(crossAxisAlignment: CrossAxisAlignment.start, 
    children: [H1(info.id),subHeadline]);
  
  final fontSize = Theme.of(context).textTheme.headlineLarge?.fontSize ?? 20;
  final exitButton = IconButton(onPressed: exit, icon: Icon(Icons.close, size: fontSize));

  return Row( 
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [headline, exitButton],);
}