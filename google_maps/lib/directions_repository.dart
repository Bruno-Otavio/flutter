import 'dart:convert';

import 'package:google_maps/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps/.env.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com';

  static Future<LatLng> getLatLng(String address) async {
    final String queryParameters = 'query=$address&key=$googleAPIKey';
    final response = await http.get(Uri.parse(
        '$_baseUrl/maps/api/place/textsearch/json?$queryParameters'));

    if (response.statusCode == 200) {
      final data = (jsonDecode(response.body) as Map<String, dynamic>)['results'];

      final double lat = data[0]['geometry']['location']['lat'];
      final double lng = data[0]['geometry']['location']['lng'];

      return LatLng(lat, lng);
    } else {
      throw Exception('Failed to get location');
    }
  }

  static Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final queryParameters = 'origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleAPIKey';
    final response = await http.get(Uri.parse('$_baseUrl/maps/api/directions/json?$queryParameters'));

    if (response.statusCode == 200) {
      return Directions.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load destination');
    }
  }
}
