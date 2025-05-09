import 'dart:convert';
import 'dart:developer';
import 'package:dubaiprojectxyvin/interface/Data/globals.dart';
import 'package:dubaiprojectxyvin/interface/Data/models/level_models/chapter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chapter_details.g.dart';

@riverpod
Future<ChapterDetailsModel> fetchChapterDetails(
    Ref ref, String chapterId) async {
  final url = Uri.parse('$baseUrl/hierarchy/chapter/$chapterId');
  print('Requesting URL: $url');
  final response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  log(response.body);
  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body)['data'];
    return ChapterDetailsModel.fromJson(data);
  } else {
    print(json.decode(response.body)['message']);

    throw Exception(json.decode(response.body)['message']);
  }
}
