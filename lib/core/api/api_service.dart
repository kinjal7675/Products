import 'package:dio/dio.dart';

// A utility service class to perform API GET requests using Dio
class ApiService {
  // A static method to perform a GET request
  static Future<Response?> getApi({
    required Dio dio, // Dio instance for making HTTP requests
    required String url, // The API endpoint URL
    required Map<String, dynamic>? data, // Optional query parameters
  }) async {
    try {
      // Attempt to send GET request with optional query parameters
      final Response response = await dio.get(url, queryParameters: data);
      return response; // Return the response if successful
    } on DioError catch (e) {
      // If a Dio-specific error occurs, return null (consider logging `e`)
      return null;
    }
  }
}
