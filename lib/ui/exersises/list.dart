import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {

    return SearchBar(
          hintText: 'Search...',
          onChanged: (query) {
            // Handle search input here
            debugPrint('User typed: $query');
          },
          leading: const Icon(Icons.search),);
  }
  
}

class ExersiseList extends StatelessWidget {

  final Iterable<LiftBasicInfo> lifts;

  const ExersiseList(this.lifts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifts')),
      body: ListView(
        children: lifts.map((e) => Tile(e)).toList()
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