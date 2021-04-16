import '../widgets/post.dart';
import 'package:flutter/material.dart';

class AssignmentFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [NewPost()],
        ),
      ),
    );
  }
}
