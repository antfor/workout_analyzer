import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_graphs.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_table.dart';
import 'package:workout_analyzer/domain/info/i_info.dart';
import 'package:workout_analyzer/domain/standards/muscle_group.dart';


class CardioBasicInfo extends IInfo{
  @override
  final String id;
  @override
  final Muscle muscle = Muscle.cardio;
  final CardioInfo Function () getInfo;

  CardioBasicInfo(this.id, this.getInfo);

}

class CardioInfo extends IInfo{
 
  @override
  final String id;
  @override
  final Muscle muscle = Muscle.cardio;
  final List<Cardio> history;
  //final CardioValues values;
  final CardioGraphs graphs;
  //final BucketGraphs bucketGraphs; //Group by distance 100m, 200m, 400m, 800m, 1000m, 2.5km, 5km, 10km
  final DistPb tables;
  

  //final Standard maleStandard;
  //final Standard femaleStandard;

  CardioInfo._({
    required this.id, 
    required this.history, 
    required this.graphs,
    required this.tables,
  });

  factory CardioInfo(String id, Iterable<Cardio> exercises){
    final filtered = exercises.where((e) => e.id == id).toList()..sort();

    final graphs = CardioGraphs();
    final table = DistPb.empty();

    for(Cardio c in filtered){
      table.update(c);
      graphs.update(c);
    }

    graphs.done(id);

    return CardioInfo._(
      id: id,
      history: filtered,
      graphs: graphs,
      tables: table,
    );
  }
  
}