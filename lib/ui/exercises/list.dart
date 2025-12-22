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
  final void Function(LiftBasicInfo) setLiftInfo;
  final LiftBasicInfo? selected;

  ExerciseList(this.lifts, this.selected, this.setLiftInfo, {super.key}):
    muscles = lifts.map((v)=>v.muscle).toSet().toList()
      ..sort((a, b) => a.index.compareTo(b.index));

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

    return 
      Column(
        children: [   
          Search((text) => setState(() => query = text)),
          Align(
            alignment: Alignment.centerRight,
            child: MuscleFilter(muscleFilter, widget.muscles, (value) => setState(() => muscleFilter = value)),
          ),
          Expanded(
            child:
              ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return Tile(filtered[index], widget.selected, widget.setLiftInfo);
                },
              ),
          ),
        ],
      );
  }
}

typedef Entries = List<DropdownMenuEntry<Muscle?>>;
class MuscleFilter extends StatelessWidget {
  
  final Muscle? muscleFilter;
  final Iterable<Muscle> muscles;
  final void Function(Muscle?) setMuscle; 

  const MuscleFilter(this.muscleFilter, this.muscles, this.setMuscle, {super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.only(bottom:8, right: 16, left:16),
        child:
            DropdownMenu<Muscle?>(
              initialSelection: muscleFilter,
              hintText: 'Filter by muscle',
              menuHeight: 400,
              onSelected: setMuscle,
              dropdownMenuEntries:  entries()
            ),
      );
  }

  
Entries entries(){
    final Entries all = [const DropdownMenuEntry(value: null,label: 'All muscles')];
    final Entries muscleEntries = 
          muscles.map((m) => DropdownMenuEntry(
                value: m,
                  leadingIcon: FlutterLogo(),
                  label: m.string
                )).toList();

    return all..addAll(muscleEntries);
  }
}

class Tile extends StatelessWidget{

    final LiftBasicInfo lift;
    final LiftBasicInfo? selected;
    final void Function(LiftBasicInfo) setLiftInfo;

    const Tile(this.lift, this.selected, this.setLiftInfo, {super.key});
      
    @override
    Widget build(BuildContext context) {
        return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16), 
          child: Card(
            child: ListTile(
              selected: selected == lift,
              onTap: () => setLiftInfo(lift),
              leading: FlutterLogo(size: 56.0),
              title: Text(lift.id),
              subtitle: Text(lift.muscle.string),
            ),
          ));
    }

}