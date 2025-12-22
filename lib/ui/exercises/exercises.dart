import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/exercises/components/strength_level.dart';
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
      pad(valueTable(info.values)),
      constrain(strength) ,
      //pad(H3("PR's")),
      constrain(repPbTable(info.tables.repPB))
    ]);
    
  }
}

Widget valueTable(ExerciseValues levels){
  final wv = levels.maxWeight;
  final vv = levels.maxVolume;
  final ov = levels.orm;

  final weight = DataRow(cells:[
    DataCell(Text('Heaviest Weight')),
    DataCell(Text('${wv.reps}x${wv.weight}kg')),
    DataCell(Text('${wv.value}kg'))]);

  final volume = DataRow(cells:[
    DataCell(Text('Max Volume')),
    DataCell(Text('${vv.reps}x${vv.weight}kg')),
    DataCell(Text('${vv.value}kg'))]);

  final orm = DataRow(cells:[
    DataCell(Text('One Rep Max')),
    DataCell(Text('${ov.reps}x${ov.weight}kg')),
    DataCell(Text('${ov.simplifyValue(2)}kg'))]);

  final rows =[weight, volume, orm];

  return DataTable(
      columns: const [
        DataColumn(label: Center(child:Text('Record'))),
        DataColumn(label: Center(child:Text('Set'))),
        DataColumn(label: Center(child:Text('Weight'))),
      ],
      rows: rows,
      border: TableBorder.symmetric(outside: BorderSide()),
    );
}

Widget? strengthLevel(Standard standard, double bodyWeight, double orm){
  
  final table = standard.weight ?? standard.reps;
  final double height = 10;

  if(table == null){
    return Text('');
  }

  int index = table.bodyweight.toList().lastIndexWhere((i) => i <= bodyWeight);
  index = index == -1 ? 0 : index;
  final bwStandard = table.standrads(index);

  bar(double v, String level, String weight) => Expanded(child:
    Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children:[Text(level, maxLines: 1, overflow: TextOverflow.ellipsis),
      LinearProgressIndicator(value: v, minHeight: height), 
      Text(weight,maxLines: 1, overflow: TextOverflow.ellipsis)],));

  final List<Widget> bars = [];
  bool belowLevel = true;
  for(int i = 0; i < bwStandard.length; i++ ){
    final weight = bwStandard[i];
    final next = i+1 < bwStandard.length ? bwStandard[i+1] : bwStandard[i] / Level.elite.percentage;
    final level = Level.byIndex(i).label;
    final limit = '$weight kg';

    if(next <= orm){
      bars.add(bar(1, level, limit));
    }else if(belowLevel){
      bars.add(bar((orm-weight)/(next-weight), level, limit)); //TODO orm or max reps
      belowLevel=false;
    }else{
      bars.add(bar(0, level, limit));
    }
  }
  return Row(spacing: 5, children: bars,);
}

DataTable repPbTable(RepPb table){

  final len = table.weight.length;
  final reps = table.reps.toList();
  final weight = table.weight.toList();
  final zip = List.generate(len,(i)=>(reps[i], weight[i]));
  zip.sort((a,b) => a.$1.compareTo(b.$1));
  final list = zip.map( (v)=> DataRow(cells: 
        [DataCell(Center(child:Text('${v.$1}'))),DataCell(Center(child:Text('${v.$2}kg')))]));

  return DataTable(
      columns: const [
        DataColumn(label: Center(child:Text('Reps'))),
        DataColumn(label: Center(child:Text('Personal Best'))),
      ],
      rows: list.toList(),
      //border: TableBorder.symmetric(outside: BorderSide()),
  );
} 