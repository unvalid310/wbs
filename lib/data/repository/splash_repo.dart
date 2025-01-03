// ignore_for_file: unnecessary_cast, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbs_app/data/datasource/remote/dio/dio_client.dart';
import 'package:wbs_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:wbs_app/data/model/base/api_response.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getUserData({nip, deviceID}) async {
    try {
      Map<String, dynamic> formData = <String, dynamic>{
        'nip': nip,
        'apps': 'pns',
        'device_id': deviceID,
      };

      final response = await dioClient.post(
        '${dotenv.env['BASE_URL_DATAWAREHOUSE']}/api/uservalidate',
        data: FormData.fromMap(formData),
        options: Options(
          contentType: 'application/json, application/x-www-form-urlencoded',
          headers: <String, String>{
            'authorization':
                'Basic ${base64Encode(utf8.encode(dotenv.env['AUTH_KEY'].toString()))}'
          },
        ),
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
