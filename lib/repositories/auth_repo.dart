import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/location_model.dart';
import 'package:letstrip/models/send_code_model.dart';
import 'package:letstrip/models/verify_code.dart';
import 'package:letstrip/network/environment.dart';

class AuthService {
  String baseUrl = Environment.authBaseUrl;
  // Send OTP function
  Future<BaseResponse<SendCodeModel>> sendOtp(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        BaseResponse<SendCodeModel> result =
            BaseResponse.fromJson(responseData, SendCodeModel.fromJson);
        return result;
      } else {
        throw BaseApiException(response.body, response.statusCode);
      }
    } catch (ex) {
      throw BaseApiException(ex.toString(), ex.hashCode);
    }
  }

  Future<BaseResponse<List<LocationModel>>> searchPlaces(String query) async {
    const String accessToken =
        'pk.eyJ1Ijoic2hpa2hhcjA1MDkiLCJhIjoiY20yN2h5amJhMGhyNTJxcXRtNTliOHh0eiJ9.-kHiR7WIHaL6ZxEBBCIcog';
    final String url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$accessToken&autocomplete=true&types=place,locality,region,country&limit=10';

    try {
      // Make the HTTP GET request
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['features'] != null) {
          // Parse features into LocationModel objects
          List<LocationModel> locations =
              (data['features'] as List).map((json) {
            return LocationModel.fromJson(json);
          }).toList();

          return BaseResponse<List<LocationModel>>(
            data: locations,
            success: true,
            message: 'Locations found successfully',
          );
        } else {
          log('No features found in response: $data');
          return BaseResponse<List<LocationModel>>(
            data: [],
            success: false,
            message: 'No locations found',
          );
        }
      } else {
        throw BaseApiException(
            response.reasonPhrase ?? 'Unknown error', response.statusCode);
      }
    } catch (ex) {
      // Log the error and rethrow it
      log('Error in searchPlaces: $ex');
      return BaseResponse<List<LocationModel>>(
        data: [],
        success: false,
        message: 'An error occurred: $ex',
      );
    }
  }

  // Verify OTP function
  Future<BaseResponse<VerifyCodeModel>> verifyCode(
      Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}auth/verifyOtp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        BaseResponse<VerifyCodeModel> result =
            BaseResponse.fromJson(responseData, VerifyCodeModel.fromJson);
        return result;
      } else {
        throw BaseApiException(response.body, response.statusCode);
      }
    } catch (ex) {
      throw BaseApiException(ex.toString(), ex.hashCode);
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
