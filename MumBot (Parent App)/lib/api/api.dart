import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mumbot_v2/models/parent.dart';
import 'package:mumbot_v2/models/user.dart';

class ParentProvider with ChangeNotifier {
  ParentProvider() {
    // this.fetchTasks();
  }
  List<Parent> _parents = [];

  List<Parent> get parents {
    return [..._parents];
  }

  void addUser(Parent parent) async {
    final response = await http.post('http://10.0.2.2:8000/api/parent/create/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(parent));
    if (response.statusCode == 201) {
      parent.id = json.decode(response.body)['id'];
      _parents.add(parent);
      notifyListeners();
    }
  }

  void deleteUser(Parent parent) async {
    final response =
        await http.delete('http://10.0.2.2:8000/apis/v1/${parent.id}/');
    if (response.statusCode == 204) {
      _parents.remove(parent);
      notifyListeners();
    }
  }

  fetchTasks(Parent parent) async {
    final url =
        'http://10.0.2.2:8000/apis/api/parent/${parent.id}/?format=json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _parents = data.map<User>((json) => User.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
