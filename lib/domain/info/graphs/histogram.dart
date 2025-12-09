import 'dart:math' as math;


class Histogram{

  final double _max;
  final double _min;
  final double _binWidth;

  final int _over;
  final int _under;
  final Iterable<int> _histogram;

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

  double get max => _max;
  double get min => _min;
  double get binWidth => _binWidth;

  int get over => _over;
  int get under => _under;

  int get total => _histogram.reduce((a,b) => a+b);

  ({List<(double?, double?)> x, Iterable<double> y})getData({bool over=false, bool under=false, bool percentage = false}){
    
    final N = total  + (over ? this.over : 0) + (under ? this.under : 0);
    

    final x =[if(under) (null, min),
              ...(List.generate(total, (i) => (min + binWidth * i, math.min(min + binWidth * (i+1), max)))),
              if(over) (max, null)
            ];


    final v =[if (under) this.under.toDouble(),
              ...(_histogram.map((i)=>i.toDouble())),
              if (over) this.over.toDouble()
             ];
      
    final y = percentage ? v.map((v)=>v/N) : v;

    return (x:x,y:y);
  }
}