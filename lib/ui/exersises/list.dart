import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';

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

class ExersiseList extends StatefulWidget {

  final Iterable<LiftBasicInfo> lifts;

  const ExersiseList(this.lifts, {super.key});

  @override
  State<ExersiseList> createState() => _ExersiseList();
}

class _ExersiseList extends State<ExersiseList> {

  String query = '';

  Iterable<LiftBasicInfo> search(){
    return widget.lifts
        .where((lift) => lift.id.toLowerCase().contains(query.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {

    final filtered = search();

    return Scaffold(
      appBar: AppBar(title: const Text('Lifts')),
      body:
        Column(
          children: [   
            Search((text) => setState(() => query = text)),
            Expanded(
              child:
                 ListView(children: filtered.map((e) => Tile(e)).toList()),
            )
          ],
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