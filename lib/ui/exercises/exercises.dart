import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/util.dart';

final double bodyWeight = 75;
final sex = Sex.male;

class ExerciseInfo extends StatelessWidget {

  final LiftInfo info;

  const ExerciseInfo(this.info, {super.key});

  @override
  Widget build(BuildContext context) {

    final repPB = info.tables.repPB;
    final standard = sex == Sex.male ? info.maleStandard : info.femaleStandard;
    final orm = info.tables.ormValue;
    final strength =  strengthLevel(standard, bodyWeight, orm.value);
  

    final maxWidth = const BoxConstraints(maxWidth: 500);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    container(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));

    return ListView(children: [
      Container(padding:padding ,child:H3(info.id)),
      if(strength != null) container(strength) ,
      container(repPbTable(repPB))
    ]);
    
  }
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
      border: TableBorder.symmetric(outside: BorderSide()),
  );
} 