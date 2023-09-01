import 'dart:convert';

import 'package:bizfra/models/registration_model.dart';
import 'package:http/http.dart' as http;

class HttpHelper {

  static const String baseUrl = "http://localhost:8080";
  static Future<String> submitData(RegistrationModel model,  String httpcontext) async {
    final Uri uri = Uri.parse(baseUrl+httpcontext);

    // Create a JSON representation of the model
    final jsonModel = json.encode(model);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonModel,
      );

      if (response.statusCode == 200) {
        // Successful API call, return response body
        return response.body;
      } else {
        // Failed API call, return an error message
        return 'Error: ${response.body}';
      }
    } catch (e) {
      // Handle any exceptions that occur during the request.
      print('Error: $e');
      return 'Error: $e';
    }
  }
}

class Model {
  final String textData;
  final List<int> imageBytes;

  Model({required this.textData, required this.imageBytes});

  Map<String, dynamic> toJson() {
    return {
      'text_data': textData,
      'image': base64Encode(imageBytes), // Convert image bytes to base64
    };
  }
}
