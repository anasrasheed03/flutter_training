import 'package:flutter/material.dart';

class RowFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.blueAccent,
            width: 50.0,
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.greenAccent,
            width: 160.0,
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.blueAccent,
            width: 50.0,
            height: 50.0,
          )
        ],
      ),
    );
  }
}
