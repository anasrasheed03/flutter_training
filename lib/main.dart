import 'tabs/assignment2.dart';
import 'tabs/assignment3.dart';
import 'tabs/assignment4.dart';

import 'tabs/assignment1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Assignments());
}

class Assignments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AssignmentOne(),
    AssignmentTwo(),
    AssignmentThree(),
    AssignmentFour()
  ];
  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Application App Bar'),
            backgroundColor: Colors.green,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'Tab1',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                label: 'Tab2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Tab3',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Tab4',
              )
            ],
          ),
          body: _children[_currentIndex]),
    );
  }
}
