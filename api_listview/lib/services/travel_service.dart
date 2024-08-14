import 'dart:convert';

import 'package:api_listview/constants.dart';
import 'package:api_listview/models/travel.dart';
import 'package:http/http.dart' as http;

class TravelService {
  static Future<List<Travel>> getTravels() async {
    final response = await http.get(Uri.parse('$apiUrl/travels'));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get travels.');
    }
  }
}