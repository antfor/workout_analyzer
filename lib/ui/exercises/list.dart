import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';

class Search extends StatelessWidget {

  final void Function(String) setQuery; 

  const Search(this.setQuery, {super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child:
          SearchBar(
            hintText: 'Search...',
            onChanged: (query) {
              //debugPrint('User typed: $query');
              setQuery(query);
            },
            leading: const Icon(Icons.search),
            ),
      );
  }
  
}

class ExerciseList extends StatefulWidget {

  final List<LiftBasicInfo> lifts;
  final List<Muscle> muscles;

  ExerciseList(this.lifts, {super.key}):muscles = lifts.map((v)=>v.muscle).toSet().toList(){
    muscles.sort((a, b) => a.index.compareTo(b.index));
  }

  @override
  State<ExerciseList> createState() => _ExerciseList();
}

class _ExerciseList extends State<ExerciseList> {

  String query = '';
  Muscle? muscleFilter;

  List<LiftBasicInfo> search(List<LiftBasicInfo> lifts){
    return lifts
        .where((lift) => lift.id.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<LiftBasicInfo> filter(List<LiftBasicInfo> lifts){
    if(muscleFilter == null){
      return lifts;
    }
    return lifts
        .where((lift) => lift.muscle == muscleFilter).toList();
  }

  @override
  Widget build(BuildContext context) {

    final filtered = search(filter(widget.lifts));

    return Scaffold(
      appBar: AppBar(title: const Text('Lifts')),
      body:
        Column(
          children: [   
            Search((text) => setState(() => query = text)),
            MuscleFilter(muscleFilter, widget.muscles, (value) => setState(() => muscleFilter = value)),
            Expanded(
              child:
                ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return Tile(filtered[index]);
                  },
                ),
            ),
          ],
        ),
    );
  }
}

class MuscleFilter extends StatelessWidget {
  
  final Muscle? muscleFilter;
  final Iterable<Muscle> muscles;
  final void Function(Muscle?) setMuscle; 

  const MuscleFilter(this.muscleFilter, this.muscles, this.setMuscle, {super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.only(bottom:8),
        child:
            DropdownButton<Muscle>(
              value: muscleFilter,
              hint: const Text('Filter by muscle'),
              isExpanded: true,
              items: muscles.map((m) {
                return DropdownMenuItem(
                  value: m,
                  child: ListTile(
                    leading: FlutterLogo(),
                    title: Text(m.string),
                  ),
                );
              }).toList()
                ..insert(
                  0,
                  const DropdownMenuItem(
                    value: null,
                    child: ListTile(
                     title: Text('All muscles'),
                    )
                  ),
                ),
              onChanged: (value) => setMuscle(value),
            ),
      );
  }
}

class Tile extends StatelessWidget{
    final LiftBasicInfo lift;
    const Tile(this.lift, {super.key});
    
      
    @override
    Widget build(BuildContext context) {
        return Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text(lift.id),
              subtitle: Text(lift.muscle.string),
            ),
          );
    }

}