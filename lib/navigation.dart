import 'package:flutter/material.dart';
import '/ui/app_page.dart';
import '/ui/settings/setting.dart';


class Navigation extends StatefulWidget {
  final List<AppPage> pages;


  const Navigation(this.pages,{super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    final page = widget.pages[currentPageIndex];
    final destinations = widget.pages.map((p)=>p.navIcon).toList();
    return Scaffold(
      appBar: AppBar(
        title: page.title,
        elevation: 100, //TODO fix color
        actions: [Settings()],
        ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: destinations,
      ),
      body: page.body,
    );
  }
}