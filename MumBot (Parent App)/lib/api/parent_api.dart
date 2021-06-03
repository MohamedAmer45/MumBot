import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbot_v2/models/parent.dart';

class ParentAPI {
  List<Parent> _parents = [];

  List<Parent> get parents {
    return [..._parents];
  }

  Future<Parent> fetchParent(Parent parent) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/apis/api/parent/${parent.id}/'));

    if (response.statusCode == 200) {
      print('200');
      print('http://10.0.2.2:8000/apis/api/parent/${parent.id}/');
      return Parent.fromJson(jsonDecode(response.body));
    } else {
      print('404');
      throw Exception('Failed to load parent');
    }
  }

//String name,String email,String phone
  Future<Parent> updateParent(
      int id, String name, String email, String phone) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/apis/api/parent/update/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_name': name,
        'user_email': email,
        'user_phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Parent.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('http://10.0.2.2:8000/apis/api/parent/update/$id/');

      throw Exception(response.statusCode);
    }
  }

  void addUser(Parent parent) async {
    final response = await http.post('http://10.0.2.2:8000/api/parent/create/',
        headers: {"Content-Type": "application/json"},
        body: json.encode(parent));
    if (response.statusCode == 201) {
      parent.id = json.decode(response.body)['id'];
      _parents.add(parent);
    }
  }

  void deleteUser(Parent parent) async {
    final response =
        await http.delete('http://10.0.2.2:8000/apis/v1/${parent.id}/');
    if (response.statusCode == 204) {
      _parents.remove(parent);
    }
  }

  // fetchTasks(Parent parent) async {
  //   final url =
  //       'http://10.0.2.2:8000/apis/api/parent/${parent.id}/?format=json';
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body) as List;
  //     _parents = data.map<Parent>((json) => Parent.fromJson(json)).toList();
  //   }
  // }
}
