import 'package:dio/dio.dart';
import 'package:letstrip/utils/shared_pref.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constants.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers[authorizationHeaderKey] == true) {
      options.headers.remove(authorizationHeaderKey);
      options.headers.addAll({
        authorizationHeaderTag: "Bearer ${SharedPref.getString(authToken)}"
      });
    } else {
      options.headers.remove(authorizationHeaderKey);
    }
    super.onRequest(options, handler);
  }
}

var logInterceptor = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false);
