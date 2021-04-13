import 'package:flutter/foundation.dart';

class UserForm {
  final String name;
  final String email;
  final int age;
  final String message;

  UserForm({
    @required this.name,
    @required this.email,
    @required this.age,
    @required this.message,
  });
}
