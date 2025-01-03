import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbs_app/data/datasource/remote/dio/dio_client.dart';
import 'package:wbs_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:wbs_app/data/model/base/api_response.dart';
import 'package:wbs_app/utill/app_constants.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> login(
      {required String nip,
      required String password,
      String deviceID = ''}) async {
    try {
      print('nip ${nip} password ${password}');
      Map<String, dynamic> formData = <String, dynamic>{
        'nip': nip,
        'password': password,
      };

      final response = await dioClient.post(
        '${dotenv.env['BASE_API_URL']}/login',
        data: FormData.fromMap(formData),
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.ID_USER);
  }

  Future<bool> logout() async {
    return await sharedPreferences.clear();
  }
}
