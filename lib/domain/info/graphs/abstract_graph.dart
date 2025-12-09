
import 'dart:math' as math;

import 'package:test_flutter/domain/info/i_info.dart';

enum History {
      indevidual,
      period,
      complete,
}

abstract class Graph implements IExerciseUpdate{

  final List<DateTime> time = [];

  Map<DateTime, T> getGraphData<T extends num>(List<T> data, History type, {DateTime? startDate, DateTime? endDate}){
    final start = startDate == null ? 0 : time.indexWhere((d) => 0 <= startDate.compareTo(d));
    final min = math.min(data.length, time.length);
    final end = endDate == null ?  min :  time.indexWhere((d) => d.isAfter(endDate));


    final x = time.getRange(start, end); 

    Iterable<T> y;

    switch(type){
      case History.indevidual: y=data.getRange(start, end); break;
      case History.period: y=_getMaxOverTime(data.getRange(start, end)); break;
      case History.complete: y=_getMaxOverTime(data).toList().getRange(start, end); break;
    }

    return Map.fromIterables(x, y);
  }

  //day, month, year
  Map<DateTime, T> getLatestGraphData<T extends num>(List<T> data, History type, {bool currentTime=true, int? days, int? months,int? years}){
    final end = currentTime ?  DateTime.now() : time.last;

    if([years,months,days].every((p) => 0 == (p ?? 0))){
      return getGraphData(data, type, endDate: end);
    }

    final start = DateTime(end.year - (years ?? 0), end.month - (months ?? 0), end.day - (days ?? 0));

    return getGraphData(data, type, startDate: start, endDate: end);
  }
  
}

Iterable<T> _getMaxOverTime<T extends num>(Iterable<T> data){

  if(data.isEmpty){
    return [];
  }

  T max = data.first;
  return data.map((value) {
    max = math.max(max, value);
    return max;
  });
}