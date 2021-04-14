import '../models/form.dart';
import 'package:flutter/material.dart';

class AssignmentTwo extends StatefulWidget {
  @override
  _AssignmentTwoState createState() => _AssignmentTwoState();
}

class _AssignmentTwoState extends State<AssignmentTwo> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final ageController = TextEditingController();

  final messageController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _ageFocusNode = FocusNode();

  final _messageFocusNode = FocusNode();
  var pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  final _form = GlobalKey<FormState>();
  var _userData = UserForm(
    name: '',
    email: '',
    age: 0,
    message: '',
  );

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _ageFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
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
    _form.currentState.save();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    showAlertDialog(ctx);
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
      content: Text("Name: " +
          _userData.name +
          "\n" +
          "Email: " +
          _userData.email +
          "\n" +
          "Age: " +
          _userData.age.toString() +
          "\n" +
          "Message: " +
          _userData.message),
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

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => _validateFields(nameController.text),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) {
                    _userData = UserForm(
                      name: value,
                      email: _userData.email,
                      age: _userData.age,
                      message: _userData.message,
                    );
                  },
                ),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Field is required';
                      } else if (!RegExp(pattern, caseSensitive: false)
                          .hasMatch(value)) {
                        return 'Email is not correct';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email ',
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_ageFocusNode);
                    },
                    onSaved: (value) {
                      _userData = UserForm(
                        name: _userData.name,
                        email: value,
                        age: _userData.age,
                        message: _userData.message,
                      );
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_messageFocusNode);
                  },
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
                    _userData = UserForm(
                      name: _userData.name,
                      email: _userData.email,
                      age: int.parse(value),
                      message: _userData.message,
                    );
                  },
                ),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                  ),
                  maxLines: 550,
                  minLines: 2,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => _validateFields(messageController.text),
                  onSaved: (value) {
                    _userData = UserForm(
                      name: _userData.name,
                      email: _userData.email,
                      age: _userData.age,
                      message: value,
                    );
                  },
                ),
                FlatButton(
                    onPressed: () => _onSubmit(context),
                    child: Text('Add Details'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
