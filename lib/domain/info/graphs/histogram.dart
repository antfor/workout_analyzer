import 'dart:math' as math;


class Histogram{

  final double _max;
  final double _min;
  final double _binWidth;

  final int _over;
  final int _under;
  final Iterable<int> _histogram;

  Histogram.empty()
    : _max = 0,
      _min = 0,
      _binWidth = 0,
      _over = 0,
      _under = 0,
      _histogram = {};

  Histogram({
    required double max,
    required double min,
    required double binWidth,
    required int over,
    required int under,
    required Iterable<int> histogram,
  })  : _max = max,
        _min = min,
        _binWidth = binWidth,
        _over = over,
        _under = under,
        _histogram = histogram;

  bool get isEmpty => _histogram.isEmpty;

  int get _total => _histogram.reduce((a,b) => a+b);

  ({List<(double?, double?)> x, Iterable<double> y})getData({bool over=false, bool under=false, bool percentage = false}){
    
    final N = _total  + (over ? _over : 0) + (under ? _under : 0);
    

    final x =[if(under) (null, _min),
              ...(List.generate(_total, (i) => (_min + _binWidth * i, math.min(_min + _binWidth * (i+1), _max)))),
              if(over) (_max, null)
            ];


    final v =[if (under) _under.toDouble(),
              ...(_histogram.map((i)=>i.toDouble())),
              if (over) _over.toDouble()
             ];
      
    final y = percentage ? v.map((v)=>v/N) : v;

    return (x:x,y:y);
  }
}