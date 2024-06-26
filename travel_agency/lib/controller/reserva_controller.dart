import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_agency/constants.dart';

class ReservaController {
  static Future<http.Response> createReserva(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$apiUrl/reservas'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data, toEncodable: (dynamic object) {
        if (object is DateTime) {
          return '${object.toIso8601String()}Z';
        }
        return object;
      }),
    );
  }
}