import 'package:flutter/material.dart';

class TriviaCategory {
  late int id;
  late String name;

  TriviaCategory({required this.id, required this.name});

  TriviaCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
