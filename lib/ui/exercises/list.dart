import 'package:flutter/material.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_info.dart';
import 'package:workout_analyzer/domain/info/i_info.dart';
import 'package:workout_analyzer/ui/exercises/components/selected.dart';
import '/domain/info/lift_info.dart';
import '/domain/standards/muscle_group.dart';

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
typedef SetInfo = void Function(LiftBasicInfo?, CardioBasicInfo?);

class ExerciseList extends StatefulWidget {

  final List<LiftBasicInfo> lifts;
  final List<CardioBasicInfo> cardio;
  final List<Muscle> muscles;
  final SetInfo setLiftInfo;
  final Selected selected;

  ExerciseList(this.lifts, this.cardio, this.selected, this.setLiftInfo, {super.key}):
  muscles = {
    ...lifts.map((v) => v.muscle),
    if (cardio.isNotEmpty) Muscle.cardio,
  }.toList()..sort((a, b) => a.index.compareTo(b.index));


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

  List<CardioBasicInfo> filterCardio(List<CardioBasicInfo> cardio){

    if(muscleFilter != null && muscleFilter != Muscle.cardio) return [];

    return cardio
      .where((c) => c.id.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {

    final lifts = search(filter(widget.lifts));
    final cardio = filterCardio(widget.cardio);

    final infoList = createList(lifts, cardio, widget.setLiftInfo);
    
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
                itemCount: infoList.length,
                itemBuilder: (context, index) {
                  return tile(infoList[index].$1, widget.selected.selected, infoList[index].$2);
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

List<(IInfo, void Function())> createList(List<LiftBasicInfo> lift, List<CardioBasicInfo> cardio, SetInfo setInfo){

  final List<(IInfo, void Function())> info = lift.map<(IInfo, void Function())>((l)=>(l, () => setInfo(l, null))).toList();
  info.addAll(cardio.map<(IInfo, void Function())>((c)=>(c, () => setInfo(null, c))));
  
  info.sort((a, b) => a.$1.compareTo(b.$1));

  return info;
}

Widget tile(IInfo info, IInfo? selected, void Function() setInfo){
  return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16), 
          child: Card(
            child: ListTile(
              selected: selected == info ,
              onTap: () => setInfo(),
              leading: FlutterLogo(size: 56.0),
              title: Text(info.id),
              subtitle: Text(info.muscle.string),
            ),
          ));
}