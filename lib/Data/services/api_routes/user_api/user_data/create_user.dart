import 'dart:convert';

import 'package:dubaiprojectxyvin/Data/utils/globals.dart';
import 'package:dubaiprojectxyvin/Data/models/user_model.dart';
import 'package:dubaiprojectxyvin/Data/services/snackbar_service.dart';
import 'package:http/http.dart'as http;


Future<void> createUser(
    {required UserModel user}) async {
  final url = Uri.parse('$baseUrl/feeds');

  final headers = {
    'accept': '*/*',
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
{
  "name": user.name,
  "uid": user.name,
  "memberId": user.name,
  "bloodgroup": user.name,
  "role":user.name,
  "chapter": user.name,
  "image": user.name,
  "email": user.name,
  "phone":user.name,
  "bio": user.name,
  "status": user.name,
  "address": user.name,
  "businessCatogary":user.name,
  "businessSubCatogary": user.name,
  "company": {
    "name": user.company?[0].name,
    "designation":user.company?[0].designation,
    "email": user.company?[0].email,
    "websites": user.company?[0].websites,
    "phone": user.company?[0].phone,
  }
}
  });

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Feed created successfully');
    } else {
      print('Failed to create user: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

