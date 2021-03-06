import 'package:assignment1/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPost extends StatefulWidget {
  var _initialValues = {'title': '', 'body': '', 'userId': '', 'id': null};
  final Function submittedHandler;
  AddPost(this._initialValues, this.submittedHandler);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final titleController = TextEditingController();

  final bodyController = TextEditingController();

  final userIdController = TextEditingController();

  final _bodyFocusNode = FocusNode();

  final _userIdFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _userData = PostForm(
    title: '',
    body: '',
    userId: 0,
  );

  showAlertDialog(BuildContext context) {
    var alertTxt;
    if (widget._initialValues['id'] == null) {
      alertTxt = 'Form Submitted';
    } else {
      alertTxt = 'Form Updated';
    }
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertTxt),
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

  _onSubmit(ctx) {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (widget._initialValues['id'] == null) {
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
                widget.submittedHandler(),
                showAlertDialog(ctx),
              });
    } else {
      final url = Uri.parse(
          'https://flutter-learning-b838c-default-rtdb.firebaseio.com/posts/${widget._initialValues['id']}.json');
      http
          .patch(
            url,
            body: json.encode({
              'title': _userData.title,
              'body': _userData.body,
              'userId': _userData.userId,
            }),
          )
          .then((res) => {
                showAlertDialog(ctx),
                widget.submittedHandler(),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field is required';
                  } else {
                    return null;
                  }
                },
                initialValue: widget._initialValues['title'],
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
                decoration: InputDecoration(
                  labelText: 'Body',
                ),
                maxLines: 550,
                minLines: 2,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_userIdFocusNode);
                },
                initialValue: widget._initialValues['body'],
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field is required';
                  } else {
                    return null;
                  }
                },
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
                initialValue: widget._initialValues['userId'].toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
