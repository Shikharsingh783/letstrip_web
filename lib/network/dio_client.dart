import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/constants.dart';
import 'interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
        contentType: contentType,
      ),
    );
    dio.interceptors.add(CustomInterceptor());
    if (!kReleaseMode) {
      dio.interceptors.add(logInterceptor);
    }
  }

  Future<Response> getRequest({
    required String endPoint,
    Options? options,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        options: options ??
            Options(
              headers: {
                if (requiresAuthorizationHeader) authorizationHeaderKey: true,
              },
            ),
      );
      return response;
    } on DioException catch (dioError) {
      log("Dio GET Request Error: ${dioError.message}");
      rethrow; // Pass the exception to the caller
    } on Exception catch (e) {
      log("General GET Request Error: $e");
      throw Exception(e.toString());
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required dynamic data,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      return await dio.post(
        endPoint,
        data: data,
        options: Options(
          headers: {
            if (requiresAuthorizationHeader) authorizationHeaderKey: true,
          },
        ),
      );
    } on DioException catch (dioError) {
      log("Dio POST Request Error: ${dioError.message}");
      rethrow;
    } on Exception catch (e) {
      log("General POST Request Error: $e");
      throw Exception(e.toString());
    }
  }

  Future<Response> patchRequest({
    required String endPoint,
    required dynamic data,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      return await dio.patch(
        endPoint,
        data: data,
        options: Options(
          headers: {
            if (requiresAuthorizationHeader) authorizationHeaderKey: true,
          },
        ),
      );
    } on DioException catch (dioError) {
      log("Dio PATCH Request Error: ${dioError.message}");
      rethrow;
    } on Exception catch (e) {
      log("General PATCH Request Error: $e");
      throw Exception(e.toString());
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    required dynamic data,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      return await dio.put(
        endPoint,
        data: data,
        options: Options(
          headers: {
            if (requiresAuthorizationHeader) authorizationHeaderKey: true,
          },
        ),
      );
    } on DioException catch (dioError) {
      log("Dio PUT Request Error: ${dioError.message}");
      rethrow;
    } on Exception catch (e) {
      log("General PUT Request Error: $e");
      throw Exception(e.toString());
    }
  }

  Future<Response> deleteRequest({
    required String endPoint,
    required dynamic data,
    bool requiresAuthorizationHeader = false,
  }) async {
    try {
      return await dio.delete(
        endPoint,
        data: data,
        options: Options(
          headers: {
            if (requiresAuthorizationHeader) authorizationHeaderKey: true,
          },
        ),
      );
    } on DioException catch (dioError) {
      log("Dio DELETE Request Error: ${dioError.message}");
      rethrow;
    } on Exception catch (e) {
      log("General DELETE Request Error: $e");
      throw Exception(e.toString());
    }
  }
}
