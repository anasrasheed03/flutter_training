import '../models/post.dart';
import '../widgets/postlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final titleController = TextEditingController();

  final bodyController = TextEditingController();

  final userIdController = TextEditingController();

  final _bodyFocusNode = FocusNode();

  final _userIdFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _isInit = true;

  List<PostForm> _items = [];

  var _userData = PostForm(
    title: '',
    body: '',
    userId: 0,
  );

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

  _validateFields(value) {
    print(value);
    if (value.isEmpty) {
      return 'Field is required';
    } else {
      return null;
    }
  }

  _onSubmit(ctx) {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final url = Uri.parse(
        'https://flutter-learning-b838c-default-rtdb.firebaseio.com//posts.json');
    http
        .post(
          url,
          body: json.encode({
            'title': _userData.title,
            'body': _userData.body,
            'userId': _userData.userId,
          }),
        )
        .then((res) => {
              showAlertDialog(ctx),
              setState(() {
                _isLoading = true;
              }),
              fetchAndSetUserFormList()
            });
  }

  Future<void> fetchAndSetUserFormList() async {
    _form.currentState?.reset();
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

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Submitted Form"),
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) => _validateFields(titleController.text),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_bodyFocusNode);
                    },
                    onSaved: (value) {
                      _userData = PostForm(
                        title: value,
                        body: _userData.body,
                        userId: _userData.userId,
                      );
                    },
                  ),
                  TextFormField(
                    controller: bodyController,
                    decoration: InputDecoration(
                      labelText: 'Body',
                    ),
                    maxLines: 550,
                    minLines: 2,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_userIdFocusNode);
                    },
                    keyboardType: TextInputType.multiline,
                    validator: (value) => _validateFields(bodyController.text),
                    onSaved: (value) {
                      _userData = PostForm(
                        title: _userData.title,
                        body: value,
                        userId: _userData.userId,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'User ID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field is required';
                      } else if (int.tryParse(value) == null) {
                        return 'Enter valid Number';
                      } else if (int.parse(value) > 120) {
                        return 'Age cannot be greater than 120';
                      } else if (int.tryParse(value) <= 0) {
                        return 'Please enter a age greater than zero.';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _userData = PostForm(
                        title: _userData.title,
                        body: _userData.body,
                        userId: int.parse(value),
                      );
                    },
                  ),
                  FlatButton(
                      onPressed: () => _onSubmit(context),
                      child: Text('Add Details')),
                  PostList(_items)
                ],
              ),
            ),
          );
  }
}
