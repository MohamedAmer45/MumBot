import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parenting_specialist/models/specialist.dart';

class SpecialistAPI {
  Future<Specialist> fetchSpecialist(Specialist specialist) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/apis/api/specialist/${specialist.id}/'));

    if (response.statusCode == 200) {
      print('200');
      print('http://10.0.2.2:8000/apis/api/parent/${specialist.id}/');
      return Specialist.fromJson(jsonDecode(response.body));
    } else {
      print('404');
      throw Exception('Failed to load parent');
    }
  }

//String name,String email,String phone
  Future<Specialist> updateSpecialist(
      int id, String name, String email, String phone) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/apis/api/specialist/update/$id/'),
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
      return Specialist.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  Future<Specialist> updateSpecialistPassword(int id, String password) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/apis/api/specialist/update/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Specialist.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }
}
