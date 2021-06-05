import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbot_v2/models/parent.dart';

class ParentAPI {
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
      throw Exception(response.statusCode);
    }
  }

  Future<Parent> updateParentPassword(int id, String password) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/apis/api/parent/update/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Parent.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  Future<Parent> addParent(
      String name, String email, String phone, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/apis/api/parent/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_name': name,
        'user_email': email,
        'user_password': password,
        'user_phone': phone,
        'user_role': '3',
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Parent.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add parent.');
    }
  }
}
