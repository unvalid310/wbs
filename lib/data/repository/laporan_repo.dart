// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbs_app/data/datasource/remote/dio/dio_client.dart';
import 'package:wbs_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:wbs_app/data/model/base/api_response.dart';
import 'package:wbs_app/utill/app_constants.dart';

class LaporanRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LaporanRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getLaporan({String status = ''}) async {
    try {
      print('status : $status');
      final response = await dioClient.get(
        '${dotenv.env['BASE_API_URL']}/pengaduan',
        queryParameters: {
          'user_id':
              sharedPreferences.getString(AppConstants.ID_USER).toString(),
          'status': status,
        },
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  Future<ApiResponse> created({
    required Map<String, dynamic> data,
    required List<Map<String, dynamic>> terlapor,
    required List<Map<String, dynamic>> lampiran,
  }) async {
    try {
      FormData _formData = FormData();

      _formData.fields.add(MapEntry('user_id',
          sharedPreferences.getString(AppConstants.ID_USER).toString()));

      data.forEach((key, value) {
        _formData.fields.add(MapEntry(key, value.toString()));
      });

      for (var i = 0; i < terlapor.length; i++) {
        terlapor[i].forEach(
          (key, value) {
            _formData.fields.add(MapEntry(key, value.toString()));
          },
        );
      }

      for (var i = 0; i < lampiran.length; i++) {
        _formData.files.add(MapEntry(
          "file_lampiran[]",
          await MultipartFile.fromFile(
            lampiran[i]['path'].toString(),
            filename: lampiran[i]['filename'].toString(),
          ),
        ));

        _formData.fields.add(MapEntry("deskripsi_lampiran[]",
            lampiran[i]['deskripsi_lampiran'].toString()));
      }

      print('${terlapor.length} form data ${_formData.fields.toString()}');

      final response = await dioClient.post(
        '${dotenv.env['BASE_API_URL']}/pengaduan/create',
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
        data: _formData,
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  Future<ApiResponse> searchNip({nip}) async {
    try {
      final response = await dioClient.post(
        '${dotenv.env['BASE_API_URL']}/search-nip',
        data: FormData.fromMap({'nip': nip}),
      );

      return ApiResponse.withSuccess(response);
    } on DioException catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
