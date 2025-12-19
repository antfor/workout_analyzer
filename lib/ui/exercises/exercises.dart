import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';



class ExerciseInfo extends StatelessWidget {

  final LiftInfo info;

  const ExerciseInfo(this.info, {super.key});

  @override
  Widget build(BuildContext context) {

    final repPB = info.tables.repPB;

    return _LiftPbTable(repPB);
    /*
    return Column(children: [
      _LiftPbTable(repPB),
    ]);
    */
  }
}

class _LiftPbTable extends StatelessWidget{
  
  final RepPb table;

  const _LiftPbTable(this.table);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Reps')),
        DataColumn(label: Text('Personal Best')),
      ],
      rows: getRows(),
    );
  }

  List<DataRow> getRows(){
    final len = table.weight.length;
    final reps = table.reps.toList();
    final weight = table.weight.toList();
    final zip = List.generate(len,(i)=>(reps[i], weight[i]));
    zip.sort((a,b) => a.$1.compareTo(b.$1));
    final list = zip.map( (v)=> DataRow(cells: 
          [DataCell(Text('${v.$1}')),DataCell(Text('${v.$2}kg'))]));
    return list.toList();
  } 
  
}