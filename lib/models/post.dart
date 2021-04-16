import 'package:flutter/foundation.dart';

class PostForm {
  final String title;
  final String body;
  final int userId;

  PostForm({
    @required this.title,
    @required this.body,
    @required this.userId,
  });
}
