import 'dart:ffi';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/ui/exercises/components/lift/chart.dart';
import 'package:workout_analyzer/ui/history/history.dart';
import 'package:workout_analyzer/ui/util.dart' as util;
import '/domain/info/lift_info.dart';
import '/domain/standards/standards.dart';
import '/state/settings.dart';
import 'components/lift/rep_pb.dart';
import 'components/lift/strength_level.dart';
import 'components/lift/value.dart';
import '/ui/util.dart';


class ExerciseInfo extends ConsumerWidget {

  final LiftInfo info;
  final void Function() exit;

  const ExerciseInfo(this.info, this.exit, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final settings = ref.watch(settingsProvider);
    final standard = settings.sex == Sex.male ? info.maleStandard : info.femaleStandard;
    final bodyWeight = settings.bodyweight;
    final strength =  StrengthLevel(standard, bodyWeight, info.values.orm.value);
    
    return _tabView(info, strength, exit, context);
    
  }
}

Widget _tabView(LiftInfo info, StrengthLevel strength, void Function() exit, BuildContext context){
  
  final history = info.history.map((e) => e.workout).toList();
  void goTOHistory(workout) => Void; // TODO fix g to history view
  final tabs = [
    _infoTab(info, strength), 
    History(history, null, goTOHistory, preview:true, filterId:info.id),
    ]; 

  final headings = [util.H3("Info"), util.H3("History")];

  return  DefaultTabController(
        initialIndex: 0,
        length: math.min(tabs.length,headings.length),
          child: Column(
          children: [
            _header(info, exit, context),
            TabBar(
            tabs: headings,
            isScrollable: false,
            ),
            Expanded(child:
              TabBarView(
                children: tabs,
              ))
          ])
        );
}

Widget _infoTab(LiftInfo info, StrengthLevel strength){

  final maxWidth = const BoxConstraints(maxWidth: 500);
  final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
  pad(w) => Container(padding:padding , child: w,);
  constrain(w) => Center(child:Container(constraints: maxWidth,padding: padding,  child:w));

  return ListView(children: [
    pad(ExrchiseChart(info.graphs, info.bucketGraphs)),
    pad(valueTable(info.values)),
    constrain(strength) ,
    constrain(repPbTableFiltered(info.tables.repPB))
  ]);
}

Widget _header(LiftInfo info, void Function() exit, BuildContext context){
  final subHeadline = Text('Muscle: ${info.muscle.string}', style: TextStyle(color: Colors.grey,),);
  final headline =   Column(crossAxisAlignment: CrossAxisAlignment.start, 
    children: [H1(info.id),subHeadline]);
  
  final fontSize = Theme.of(context).textTheme.headlineLarge?.fontSize ?? 20;
  final exitButton = IconButton(onPressed: exit, icon: Icon(Icons.close, size: fontSize));

  final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);

  return Container(padding:padding , child:Row( 
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [headline, exitButton],));
}