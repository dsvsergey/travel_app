import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/geocoding_result_model.dart';

class GeocodingService {
  static Future<GeocodingResultModel> getLocationInfo(
      double lat, double lon) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final address = data['address'];
      return GeocodingResultModel(
        cityName: address['city'] ?? address['town'] ?? 'Unknown',
        country: address['country'] ?? 'Unknown',
        countryCode: address['country_code']?.toUpperCase() ?? 'Unknown',
      );
    } else {
      throw Exception('Failed to get location info');
    }
  }
}
