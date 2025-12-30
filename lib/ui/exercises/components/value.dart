

import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';

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