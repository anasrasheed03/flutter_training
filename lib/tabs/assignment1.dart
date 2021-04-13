import 'package:flutter/material.dart';

import '../widgets/row1.dart';
import '../widgets/row2.dart';
import '../widgets/row3.dart';
import '../widgets/row4.dart';

class AssignmentOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [RowOne(), RowTwo(), RowThree(), RowFour()],
      ),
    );
  }
}
