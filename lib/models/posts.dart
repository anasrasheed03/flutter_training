import 'package:assignment1/models/post.dart';
import 'package:flutter/foundation.dart';

class PostItems with ChangeNotifier {
  List<PostForm> postList = [];

  List<PostForm> get posts {
    return [...postList];
  }
}
