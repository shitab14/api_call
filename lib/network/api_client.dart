import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:io' as IO;

import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiClient {

  /// GET CALL
  static Future<dynamic> get(
      String url, dynamic parameters, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response = await dio.get(url, queryParameters: parameters);
      print(response);
      return _response(response);
    } catch (e) {
      throw e;
    }
  }

  /// GET CALL JS Object
  static Future<dynamic> getJs(
      String url, dynamic parameters, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response = await dio.get(url, queryParameters: Map<String, dynamic>());
      print(response);
      return _response(response);
    } catch (e) {
      throw e;
    }
  }

  /// POST CALL
  static Future<dynamic> post(
      String url, dynamic params, dynamic body, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response =
      await dio.post(url, queryParameters: params, data: body);
      return _response(response);
    } catch (e) {
      throw e;
    }
  }

  /// UPDATE CALL
  static Future<dynamic> put(
      String url, dynamic params, dynamic body, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response =
      await dio.put(url, queryParameters: params, data: body);
      return _response(response);
    } catch (e) {
      throw e;
    }
  }

  /// DELETE CALL
  static Future<dynamic> delete(
      String url, dynamic params, dynamic body, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response =
      await dio.delete(url, queryParameters: params, data: body);
      return _response(response);
    } catch (e) {
      throw e;
    }
  }

  /// POST CALL with Files
  static Future<dynamic> upload(
      String url, dynamic params, dynamic body, bool isJWTRequired) async {
    try {
      Dio dio = await _dioClient(isJWTRequired);
      Response response = await dio.post(
        url,
        queryParameters: params,
        data: FormData.fromMap(body),
      );
      return _response(response);
    } catch (e) {
      print(e);
      return e;
    }
  }

  /// CLIENT
  static Future<Dio> _dioClient(bool isJWTRequired) async {
    String token = "";
    if (isJWTRequired) {
      token = ''; //tba
    }
    Dio dio = Dio(await _options(token, isJWTRequired));
    // dio.interceptors.add(DioFirebasePerformanceInterceptor());

    // TODO: Turn off after done debugging
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));


    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (IO.HttpClient client) {
      client.badCertificateCallback =
          (IO.X509Certificate cert, String host, int port) => true;
    };
    return dio;
  }

  static Future<BaseOptions> _options(
      String token, bool isJWTRequired) async {
    String versionCode = "1.0";

    var customHeaders = {
      // 'portal-name': 'my-app',
      // 'version-code': versionCode
    };

    var header = {
      // 'portal-name': 'my-app',
      // 'user-id': userID,
      // 'version-code': versionCode,
      // 'User-Agent': userAgent,
      // "custom-headers": customHeaders
      'Content-Type':'application/json',
      'contentType':'application/json',
    };

    // if (isJWTRequired) {
    //   header['Authorization'] = 'Bearer ' + token;
    // }

    return BaseOptions(
      connectTimeout: 50000,
      receiveTimeout: 50000,
      headers: header,
    );
  }

  /// Response Parser
  static dynamic _response(Response response) {
    var responseJson = json.decode(response.toString());
    return responseJson;
  }
  /// Response Parser for Javascript Object
  static dynamic _responseJS(Response response) {
    print(JsonEncoder.withIndent(" ").convert(JsonDecoder().convert(response.toString())));
    return JsonEncoder.withIndent(" ").convert(JsonDecoder().convert(response.toString()));
    // return response;
  }

}