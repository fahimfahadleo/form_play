import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RequestController{
  BuildContext context;
  RequestController(this.context);
  Future<String> getList() async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users'),
    );
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      return response.body;
    } else {
      return 'Request failed with status: ${response.body}';

    }
  }
  Future<String> register(String userName,String password) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/register'),
      body: {"email": userName, "password": password},
    );
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      return response.body;
    } else {
      return 'Request failed with status: ${response.body}';

    }
  }
  Future<String> login(String userName,String password) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {"email": userName, "password": password},
    );
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      return response.body;
    } else {
      return 'Request failed with status: ${response.body}';

    }
  }

}