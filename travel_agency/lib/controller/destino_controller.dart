import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_agency/constants.dart';
import 'package:travel_agency/models/destino_model.dart';

class DestinoController {
  static Future<List> fetchDestinos() async {
    final response = await http.
      get(Uri.parse('$apiUrl/destinos'));

    if (response.statusCode == 200 ) {
      final body = jsonDecode(response.body);

      return body.map((e) => Destino.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch Destinos');
    }
  }
}