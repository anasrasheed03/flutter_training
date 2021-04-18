import 'package:assignment1/widgets/addpost.dart';

import '../models/post.dart';
import '../widgets/postlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var _initialValues = {'title': '', 'body': '', 'userId': '', 'id': null};
  var _isLoading = false;
  var _isInit = true;
  List<PostForm> _items = [];
  var _editedPost = PostForm(title: '', body: '', userId: 0, id: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      fetchAndSetUserFormList().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> fetchAndSetUserFormList() async {
    _items = [];
    final url = Uri.parse(
        'https://flutter-learning-b838c-default-rtdb.firebaseio.com//posts.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<PostForm> loadedProducts = [];
      print(responseData);
      if (responseData != null) {
        responseData.forEach((prodId, userData) {
          loadedProducts.add(PostForm(
            userId: userData['userId'],
            title: userData['title'],
            body: userData['body'],
            id: prodId,
          ));
        });
      }
      setState(() {
        _isLoading = false;
      });
      _items = loadedProducts;
    } catch (error) {
      throw (error);
    }
  }

  editPost(id) {
    _editedPost = _items.firstWhere((post) => post.id == id);
    _initialValues = {
      'title': _editedPost.title,
      'body': _editedPost.body,
      'id': _editedPost.id,
      'userId': _editedPost.userId.toString()
    };
    addNewPost(context, true);
  }

  addNewPost(BuildContext ctx, isEdit) {
    if (!isEdit) {
      _initialValues = {'title': '', 'body': '', 'userId': '', 'id': null};
    }
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddPost(_initialValues, fetchAndSetUserFormList),
            onTap: () {},
          );
        });
  }

  showAlertDialog(BuildContext context) {
    var alertTxt;
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        fetchAndSetUserFormList();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Record Deleted'),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deletePost(id, ctx) {
    print(id);
    _editedPost = _items.firstWhere((post) => post.id == id);
    print(_editedPost.title);
    final url = Uri.parse(
        'https://flutter-learning-b838c-default-rtdb.firebaseio.com/posts/${id}.json');
    http
        .delete(
          url,
        )
        .then((res) => {showAlertDialog(ctx)});
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
            children: [
              RaisedButton(
                onPressed: () => addNewPost(context, false),
                child: Text('Add New Post'),
              ),
              PostList(_items, editPost, deletePost)
            ],
          ));
  }
}
