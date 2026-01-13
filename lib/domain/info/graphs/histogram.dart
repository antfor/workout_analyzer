import 'dart:math' as math;


class Histogram{

  final double _max;
  final double _min;
  final double _binWidth;

  final int _over;
  final int _under;
  final Iterable<num> _histogram;
  final Iterable<DateTime>? _labels;

  Histogram.empty()
    : _max = 0,
      _min = 0,
      _binWidth = 0,
      _over = 0,
      _under = 0,
      _histogram = {},
      _labels = null;

  Histogram({
    required double max,
    required double min,
    required double binWidth,
    required int over,
    required int under,
    required Iterable<num> histogram,
    Iterable<DateTime>? labels,
  })  : _max = max,
        _min = min,
        _binWidth = binWidth,
        _over = over,
        _under = under,
        _histogram = histogram,
        _labels = labels;

  bool get isEmpty => _histogram.isEmpty;

  num get _total => _histogram.fold(0,(a,b) => a+b);
  
  
  ({List<(double?, double?)> x, Iterable<num> y})getData({bool over=false, bool under=false, bool percentage = false}){
    if(_binWidth != 0){
      return _getData(over: over, under: under, percentage: percentage);
    }
    Iterable<DateTime> labels = _labels ?? [];
    final x = labels.map((i)=> (i.millisecondsSinceEpoch.toDouble(),null));
    return (x:x.toList(), y:_histogram);
  }
    


  ({List<(double?, double?)> x, Iterable<num> y})_getData({bool over=false, bool under=false, bool percentage = false}){
    

    final x =[if(under) (null, _min),
              ...(List.generate(_histogram.length, (i) => (_min + _binWidth * i, math.min(_min + _binWidth * (i+1), _max)))),
              if(over) (_max, null)
            ];

    final v =[if (under) _under,
              ...(_histogram),
              if (over) _over
             ];
    
    final N = _total  + (over ? _over : 0) + (under ? _under : 0);
    final Iterable<num> y = percentage ? v.map((v)=>v/N) : v;

    return (x:x,y:y);
  }
}