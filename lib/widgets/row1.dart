import 'package:flutter/material.dart';

class RowOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Colors.blueAccent,
            width: 50.0,
            height: 50.0,
          ),
          Container(
            color: Colors.greenAccent,
            width: 50.0,
            height: 50.0,
          ),
          Container(
            color: Colors.deepOrangeAccent,
            width: 50.0,
            height: 50.0,
          ),
          Container(
            color: Colors.amberAccent,
            width: 50.0,
            height: 50.0,
          )
        ],
      ),
    );
  }
}
