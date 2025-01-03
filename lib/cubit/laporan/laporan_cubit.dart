import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbs_app/data/model/base/response_model.dart';
import 'package:wbs_app/data/model/mpejabat.dart';
import 'package:wbs_app/data/model/mpengaduan.dart';
import 'package:wbs_app/data/repository/laporan_repo.dart';

part 'laporan_state.dart';

class LaporanCubit extends Cubit<LaporanState> {
  final LaporanRepo laporanRepo;
  LaporanCubit({required this.laporanRepo}) : super(LaporanInitial());

  Future<void> getLaporan({String status = ''}) async {
    try {
      emit(LaporanProgress());

      final apiResponse = await laporanRepo.getLaporan(status: status);

      final response = apiResponse.response;

      if (response != null && response.statusCode == 200) {
        final success = response.data['success'];
        List<LaporanModel> _laporan = [];

        if (success) {
          final data = response.data['data'].toList();
          data.map(
            (value) => _laporan.add(LaporanModel.fromMap(value as Map<String, dynamic>)),
          ).toList();

          emit(LaporanSuccess(
            laporan: _laporan,
            message: response.data['message'].toString(),
          ));
        } else {
          emit(LaporanSuccess(
            message: response.data['message'].toString(),
          ));
        }
      } else {
        emit(LaporanError(message: apiResponse.error));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createdLaporan({
    required Map<String, dynamic> data,
    required List<Map<String, dynamic>> terlapor,
    required List<Map<String, dynamic>> lampiran,
  }) async {
    try {
      emit(CreatedLaporanProgress());
      ResponseModel responseModel =
          ResponseModel(false, 'Terjadi kesalahan', 'Gagal membuat laporan');

      final apiResponse = await laporanRepo.created(
          data: data, terlapor: terlapor, lampiran: lampiran);

      final response = apiResponse.response;

      if (response != null && response.statusCode == 200) {
        responseModel = ResponseModel(response.data['success'],
            'created laporan', response.data['message']);
        emit(CreatedLaporanSuccess(responseModel: responseModel));
      } else {
        emit(CreatedLaporanError(message: apiResponse.error));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchNip({required String nip}) async {
    try {
      emit(SearchNipProgress());

      final apiResponse = await laporanRepo.searchNip(nip: nip);

      final response = apiResponse.response;

      if (response != null && response.statusCode == 200) {
        final success = response.data['success'];
        if (success) {
          final data = response.data['data'] as Map<String, dynamic>;
          final _pegawai = PejabatModel.fromMap(data);

          emit(SearchNipSuccess(
            pejabat: _pegawai,
            message: response.data['message'].toString(),
          ));
        } else {
          emit(SearchNipSuccess(
            message: response.data['message'].toString(),
          ));
        }
      } else {
        emit(SearchNipError(message: apiResponse.error));
      }
    } catch (e) {
      print(e);
    }
  }
}
