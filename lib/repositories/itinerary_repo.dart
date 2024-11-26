import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/dummy_response_model.dart';
import 'package:letstrip/models/saved_itinerary.dart';
import 'package:letstrip/network/environment.dart';

class ItineraryRepository {
  static final ItineraryRepository _instance = ItineraryRepository._internal();
  final String baseUrl = Environment.itineraryBaseUrl;
  static const int maxAttempts = 3;

  ItineraryRepository._internal();

  factory ItineraryRepository() => _instance;

  Future<BaseResponse<DummyResponseModel>> getItinerary(
      Map<String, dynamic> data) async {
    var attempt = 1;

    while (attempt <= maxAttempts) {
      try {
        // Log the data being sent
        print("Sending data to API: $data");

        final response = await http.post(
          Uri.parse('$baseUrl/itinerary'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmJhNTNhYzJkZjdlY2ZiMGMyYjQzNCIsImVtYWlsIjoic2hpa2hhcnMzNjlAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJjdXJyZW5jeSI6eyJjb3VudHJ5IjoiTmV3IFplYWxhbmQgRG9sbGFyIiwic3ltYm9sIjoiJCIsImNvZGUiOiJOWkQifSwicm9sZSI6InVzZXIiLCJkZWxldGVkIjpmYWxzZSwiaWF0IjoxNzMxNzQ3Mjk3LCJleHAiOjE3MzQzMzkyOTd9.FPMHcum4v0kROuOpJQkl2C5ac8K7XtSJWORw1C6WNaY',
          },
          body: json.encode(data),
        );

        // Log the raw response
        print("Raw Response: ${response.body}");

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final responseData = json.decode(response.body);
          print("Decoded response data: $responseData");

          return BaseResponse.fromJson(
            responseData,
            (json) => DummyResponseModel.fromJson(json),
          );
        } else {
          print("Error: ${response.statusCode}");
          throw BaseApiException(
              'Failed to load itinerary', response.statusCode);
        }
      } catch (e) {
        print("Error occurred: $e");
        if (attempt == maxAttempts) {
          rethrow;
        }
        attempt++;
      }
    }
    throw BaseApiException("Max attempts reached", 0);
  }

  Future<BaseResponse<List<SavedItineraryModel>>> getAllItineraries() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/itinerary'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmJhNTNhYzJkZjdlY2ZiMGMyYjQzNCIsImVtYWlsIjoic2hpa2hhcnMzNjlAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJjdXJyZW5jeSI6eyJjb3VudHJ5IjoiTmV3IFplYWxhbmQgRG9sbGFyIiwic3ltYm9sIjoiJCIsImNvZGUiOiJOWkQifSwicm9sZSI6InVzZXIiLCJkZWxldGVkIjpmYWxzZSwiaWF0IjoxNzMxNzQ3Mjk3LCJleHAiOjE3MzQzMzkyOTd9.FPMHcum4v0kROuOpJQkl2C5ac8K7XtSJWORw1C6WNaY',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return BaseResponse.fromListJson(
          responseData,
          (json) => (json as List<dynamic>)
              .map((e) => SavedItineraryModel.fromJson(e))
              .toList(),
        );
      } else {
        throw BaseApiException(
            'Failed to load itineraries', response.statusCode);
      }
    } catch (e) {
      throw BaseApiException('Error fetching itineraries: $e', 0);
    }
  }
}

class BaseApiException implements Exception {
  final String message;
  final int code;

  BaseApiException(this.message, this.code);

  @override
  String toString() => 'Error $code: $message';
}
