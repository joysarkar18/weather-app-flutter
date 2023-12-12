import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchWeatherData(String city) async {
  String apiUrl =
      'https://api.weatherapi.com/v1/current.json?key=f6bab52ac952417a8c8123219231212&q=$city&aqi=yes';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      Map<String, dynamic> data = json.decode(response.body);
      // Process the data as needed
      return data;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // Handle any errors that occurred during the request.
    return {};
  }
}
