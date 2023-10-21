import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum APIMethod { post, put, get, delete, patch }

class ApiHandler {
  //to make the class singleton and create only one instance:
  static final ApiHandler instance = ApiHandler._internal();

  factory ApiHandler() {
    return instance;
  }

  ApiHandler._internal();

  //to log api-call behavior in debug mode
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  late Dio _dio;
  bool allRequestSent = false;
  String? _userToken;
  String? _lang;

  static const int _kConnectTimeout = 120000;
  static const _kLang = 'AR';

  void setLang(String lang) => _lang = lang;

  void setUserToken(String? accessToken) => _userToken = accessToken;

  String get unAuthorized => "غير مصرح !";

  String get httpException => "تعذر الاتصال بالخادم";

  String get formatException => "حدث خطأ في البيانات";

  String get socketException => "فشل اتصال الشبكة";

  String get cancelException => "تم إلغاء الطلب";

  void _onSendProgress(int count, int total) {
    if (kDebugMode) {
      if (count == total) {
        allRequestSent = true;
        log('Request progress Done 100%');
      } else {
        log('Request progress : ${(count / total).toStringAsFixed(2)} %');
      }
    }
  }

  dynamic _validateAndReturnResponse(Response response, String route) {
    if (!response.data.toString().contains('Error')) {
      return response.data;
    } else {
      throw DioError(
        requestOptions: RequestOptions(path: route),
        type: DioErrorType.badResponse,
        response: Response<APIError>(
          data: APIError(
            message: json.decode(response.data.toString())['message'],
            code: -1,
          ),
          statusCode: 999,
          requestOptions: RequestOptions(path: route),
        ),
      );
    }
  }

  Future<dynamic> call({
    required String path,
    required APIMethod method,
    int apiVersion = 1,
    Map<String, dynamic>? body,
    FormData? formData,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    int? connectTimeout,
    Function(int? count, int? total)? onSendProgress,
    Function(int? count, int? total)? onReceiveProgress,
    bool handleErrors = true,
  }) async {
    try {
      allRequestSent = false;

      final baseUrl = 'https://demo.smartsoleg.com/api/method/$path';

      // No need for Content-Type if the request is get or delete,
      // because they don't have body or formData
      headers ??= {
        "Accept-Language": _lang ?? _kLang,
        "accept": "application/json",
        if (method != APIMethod.get || method != APIMethod.delete)
          "Content-Type": "application/json",
      };
      headers.putIfAbsent("Authorization", () => 'Bearer $_userToken');
      _dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: connectTimeout ?? _kConnectTimeout),
          headers: headers,
        ),
      );

      if (kDebugMode) {
        _dio.interceptors.add(_logger);
      }

      Response response;

      switch (method) {
        case APIMethod.post:
          response = await _dio.post(
            baseUrl,
            data: formData ?? body ?? {},
            onSendProgress: onSendProgress ?? _onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        case APIMethod.put:
          response = await _dio.put(
            baseUrl,
            data: formData ?? body ?? {},
            onSendProgress: onSendProgress ?? _onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        case APIMethod.get:
          response = await _dio.get(
            baseUrl,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
            data: formData ?? body ?? {},
          );
          break;
        case APIMethod.delete:
          response = await _dio.delete(
            baseUrl,
            data: formData ?? body ?? {},
            cancelToken: cancelToken,
          );
          break;
        case APIMethod.patch:
          response = await _dio.patch(
            baseUrl,
            data: formData ?? body ?? {},
            options: Options(headers: headers),
          );
          break;
      }
      return _validateAndReturnResponse(response, path);
    } on FormatException catch (formatError) {
      if (kDebugMode) {
        log('FormatException : ${formatError.message}');
      }
      throw httpException;
    } on DioError catch (dioError) {
      if (kDebugMode) {
        log('DioError ::: ${dioError.type.name} '
            ',${dioError.error.toString()} '
            ',${dioError.response.toString()}');
      }
      if (handleErrors) {
        switch (dioError.type) {
          case DioErrorType.badResponse:
            throw await _handleAPIError(
              APIError(
                code: dioError.response!.statusCode,
                message: dioError.response!.data!.toString().contains('message')
                    ? dioError.response!.data!['message']
                    : formatException,
              ),
            );
          case DioErrorType.connectionTimeout:
          case DioErrorType.cancel:
            throw httpException;
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.unknown:
            if (dioError.error.toString().contains('FormatException')) {
              /// This state when a response is a web page error <!DOCTYPE html>
              throw httpException;
            }
            throw socketException;
          default:
            throw formatException;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<String> _handleAPIError(APIError error) async {
    if (kDebugMode) {
      log('API error : ${error.code} -:- ${error.message}');
    }
    String errorMsg = error.message ?? '';
    if (error.code! <= 500) {
      switch (error.code) {
        case 401:
          errorMsg = unAuthorized;
          break;
      }
      return errorMsg;
    }
    return httpException;
  }
}

class APIError {
  final String? message;
  final int? code;

  APIError({
    this.message,
    this.code,
  });
}
