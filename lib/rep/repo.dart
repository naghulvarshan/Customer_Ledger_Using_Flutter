import 'dart:core';

import 'package:http/http.dart';
import 'dart:convert';
import '../get.dart';
// import 'package:flutter/material.dart';

class LoadData {
  String api = "https://jsonplaceholder.typicode.com/users";
  Future<List<User>> getDetails() async {
    var response = await get(Uri.parse(api));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map(((e) => User.fromjson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<User> getUserDetails(int id) async {
    var response = await get(Uri.parse("$api/${id.toString()}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromjson(data);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
