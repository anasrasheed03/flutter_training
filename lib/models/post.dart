import 'package:flutter/foundation.dart';

class PostForm with ChangeNotifier {
  final String title;
  final String body;
  final int userId;
  final String id;

  PostForm({
    @required this.title,
    @required this.body,
    @required this.userId,
    this.id,
  });
}
