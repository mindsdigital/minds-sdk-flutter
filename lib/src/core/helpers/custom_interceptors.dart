import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import '../../minds_initializer.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers['Access-Control-Allow-Origin'] = '*';
    options.headers.addAll({
      'Access-Control-Allow-Origin': "*",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${MindsApiWrapper.token}',
    });
    developer.log("Base ${options.baseUrl}");
    developer.log("Payload ${json.encode(options.headers)}");
    developer.log("Payload ${json.encode(options.data)}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    developer.log('DATA ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    developer.log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
