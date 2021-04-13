import 'package:flutter/material.dart';

class RowThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.blueAccent,
            width: 50.0,
            height: 50.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
            color: Colors.greenAccent,
            width: 50.0,
            height: 50.0,
          )
        ],
      ),
    );
  }
}
