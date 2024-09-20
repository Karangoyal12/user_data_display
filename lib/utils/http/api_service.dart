import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{

  ApiService();

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      _handleResponse(response);
      return response;
    } catch (ex) {
      // Create a CrashedApiResponse object
      CrashedApiResponse response = CrashedApiResponse(message: ex.toString());

      // Convert it to JSON
      String jsonResponse = jsonEncode(response);

      // Return an http.Response object with the error data
      return http.Response(
        jsonResponse,
        response.statusCode ?? 500,
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  void _handleResponse(http.Response response) async {
      print("error==> ${response.statusCode}");
      print("error==> ${response.body}");
  }

}



class CrashedApiResponse {
  String? message;
  bool? success;
  int? statusCode;

  CrashedApiResponse({this.message = "Error Occur", this.success = false, this.statusCode = 500});

  CrashedApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['statusCode'] = statusCode;
    return data;
  }
}