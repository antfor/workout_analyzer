import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_info.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_table.dart';
import 'package:workout_analyzer/ui/exercises/components/cardio/chart.dart';
import '/ui/util.dart';


class InfoCardio extends ConsumerWidget {

  final CardioInfo info;
  final void Function() exit;

  const InfoCardio(this.info, this.exit, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final settings = ref.watch(settingsProvider);
    //final standard = settings.sex == Sex.male ? info.maleStandard : info.femaleStandard;
    //final bodyWeight = settings.bodyweight;
    //final strength =  StrengthLevel(standard, bodyWeight, info.values.orm.value);
    

    final maxWidth = const BoxConstraints(maxWidth: 500);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));

    return ListView(children: [//TODO add tab bar with info,history and the exit button
      pad(_header(info, exit, context)),
      //pad(H3('Records')),
      pad(CardioChart(info.graphs)), //graphs
      //pad(valueTable(info.values)), //pace, longest distance, 
      //constrain(strength) , //running level
      //pad(H3("PR's")),
      constrain(pbTable(info.tables)) //best time and pace, 100m, 200m, 400m, 800m, 1km, 2.5km, 5km, 10km
      
    ]);
    
  }
}

Widget _header(CardioInfo info, void Function() exit, BuildContext context){
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

Widget pbTable(DistPb table){
    final data = table.data;

    final list = data.map( (v)=> DataRow(cells: 
        [DataCell(Center(child:Text("${v.key < 1 ? (v.key*1000).round() : v.key}${v.key < 1 ? "m" : "km"}"))),
        DataCell(Center(child:Text(Cardio.calcDuration(v.value)))),
        DataCell(Center(child:Text('${Cardio.toPace(v.value/v.key, decimals: 0)}/km'))),
        ]));
  return DataTable(
      columns: const [
        DataColumn(label: Center(child:Text('Distance'))),
        DataColumn(label: Center(child:Text('Personal Best'))),
        DataColumn(label: Center(child:Text('Pace'))),
      ],
      rows: list.toList(),
  );
}