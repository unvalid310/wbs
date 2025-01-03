// ignore_for_file: unnecessary_statements, empty_catches, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wbs_app/data/datasource/remote/dio/dio_client.dart';
import 'package:wbs_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:wbs_app/data/model/base/api_response.dart';

class BeritaRepo {
  final DioClient dioClient;

  BeritaRepo({required this.dioClient});

  Future<ApiResponse> getBerita({int? pages}) async {
    try {
      int pages0 = (pages != null) ? pages : 1;
      final response = await dioClient.get(
        dotenv.env['URL_BERITA'].toString(),
        options: Options(
          headers: <String, dynamic>{
            'Content-Type':
                'application/json; charset=UTF-8; multipart/form-data;',
          },
        ),
        queryParameters: <String, dynamic>{
          'page': pages0.toString(),
          '_embed': null
        },
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
