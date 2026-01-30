import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';

DataTable repPbTable(RepPb table){

  return _repPbTable(table.reps.toList(), table.weight.toList());
} 


DataTable repPbTableFiltered(RepPb table){

  final reps = table.reps.toList();
  final weights = table.weight.toList();
  final len = math.min(reps.length, weights.length);

  if(len <= 1){
    return _repPbTable(reps,weights);
  }

  final highToLowRep = List.generate(len,(i)=>(reps[i], weights[i]));
  highToLowRep.sort((a,b) => b.$1.compareTo(a.$1));

  double minWeight = highToLowRep[0].$2;
  final repWeight = [(highToLowRep[0].$1,minWeight)];
  
  for(int i = 1; i < highToLowRep.length; i++ ){
    final weight = highToLowRep[i].$2;
    
    if(weight > minWeight){
      repWeight.insert(0, (highToLowRep[i].$1, weight));
      minWeight = weight;
    }
    
  }

  //final filtred = rw.where((a) => a.$1 <= 20);
  return _repPbTable(repWeight.map((v) => v.$1).toList(), repWeight.map((v) => v.$2).toList());
} 

DataTable _repPbTable(List<int> reps, List<double> weight){

  final len = math.min(reps.length, weight.length);
  final zip = List.generate(len,(i)=>(reps[i], weight[i]));
  zip.sort((a,b) => a.$1.compareTo(b.$1));
  final List<(String, double)> data = [];

  for(int i = zip.length-1; i >= 0; i--){
    final prev = i == 0 ? 0 : zip[i-1].$1;
    final middle = prev + 1;
    final value =  zip[i].$1;
    final String label = value==middle ? value.toString() : '$middle-$value' ;
    data.add((label, zip[i].$2));
  }

  final list = data.reversed.map( (v)=> DataRow(cells: 
        [DataCell(Center(child:Text(v.$1))),DataCell(Center(child:Text('${v.$2}kg')))]));

  return DataTable(
      columns: const [
        DataColumn(label: Center(child:Text('Reps'))),
        DataColumn(label: Center(child:Text('Personal Best'))),
      ],
      rows: list.toList(),
      //border: TableBorder.symmetric(outside: BorderSide()),
  );
}