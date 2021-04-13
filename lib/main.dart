import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './row1.dart';
import './row2.dart';
import './row3.dart';
import './row4.dart';

void main() {
  runApp(AssignmentOne());
}

class AssignmentOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Application App Bar'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [RowOne(), RowTwo(), RowThree(), RowFour()],
          ),
        ),
      ),
    );
  }
}
