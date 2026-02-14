
import 'dart:math' as math;

import '/domain/info/i_info.dart';

enum History {
      individual,
      period,
      complete;

  String get label {
    switch(this){
      case History.individual : return"Individual";
      case History.period : return"Period";
      case History.complete : return"Complete";
    }
  }
}

abstract class Graph implements IExerciseUpdate{

  final List<DateTime> time = [];

  Map<DateTime, T> getGraphData<T extends num>(List<T> data, History type, {DateTime? startDate, DateTime? endDate}){
    if(data.isEmpty || time.isEmpty){
      return {};
    }
    
    final start = startDate == null ? 0 : time.indexWhere((d) => 0 >= startDate.compareTo(d));
    
    final min = math.min(data.length, time.length);
    int end = endDate == null ?  min :  time.indexWhere((d) => d.isAfter(endDate));
    end = end == -1 ? min : end;

    if(start == -1 || end < start){
      return {};
    }

    final x = time.getRange(start, end); 

    Iterable<T> y;

    switch(type){
      case History.individual: y=data.getRange(start, end); break;
      case History.period: y=_getMaxOverTime(data.getRange(start, end)); break;
      case History.complete: y=_getMaxOverTime(data).toList().getRange(start, end); break;
    }

    return Map.fromIterables(x, y);
  }

  //day, month, year
  Map<DateTime, T> getLatestGraphData<T extends num>(List<T> data, History type, {bool currentTime=true, int days=0, int months=0, int years=0}){
    if(data.isEmpty || time.isEmpty){
      return {};
    }
    
    final end = currentTime ?  DateTime.now() : time.last;
 
    if([years,months,days].every((p) => 0 == p)){
      return getGraphData(data, type, endDate: end);
    }

    final start = DateTime(end.year - years, end.month - months, end.day - days);

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