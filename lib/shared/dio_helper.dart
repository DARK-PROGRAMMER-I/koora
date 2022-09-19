import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://koorazone92.com/api/',
        validateStatus: (status) => true,
        // headers:{
        //
        // },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {@required String url, Map<dynamic, dynamic> query, String token}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<dynamic> postData({
    @required String url,
    Map<dynamic, dynamic> query,
    @required dynamic data,
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      'Authorization': 'Bearer $token',
    };

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    @required String url,
    Map<dynamic, dynamic> query,
    @required dynamic data,
    String token,
  }) async {
    Encoding.getByName('utf-8');

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio.put(url, queryParameters: query, data: data);
  }
}
