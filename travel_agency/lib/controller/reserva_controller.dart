import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservaController {
  static Future<http.Response> createReserva(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('http://10.87.195.24:3000/destinos'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        jsonEncode(data),
      }
    );
  }
}