// ignore_for_file: omit_local_variable_types, unawaited_futures, cascade_invocations, avoid_print, depend_on_referenced_packages, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strings/strings.dart';
import 'package:wbs_app/data/model/base/response_model.dart';
import 'package:wbs_app/data/model/mlogin.dart';
import 'package:wbs_app/data/repository/auth_repo.dart';
import 'package:wbs_app/utill/app_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthCubit({required this.authRepo, required this.sharedPreferences})
      : super(AuthInitial());

  Future<void> login({required String nip, required String password}) async {
    try {
      List dataUnitOrganisasi;
      List<String> unitOrganisasi = [];
      String deviceID = '';
      ResponseModel responseModel =
          ResponseModel(false, 'Terjadi kesalahan', 'Nip atau password salah');

      emit(AuthProgress());

      final apiResponse = await authRepo.login(
        nip: nip,
        password: password,
      );

      final response = apiResponse.response;

      if (response != null && response.statusCode == 200) {
        final success = response.data['success'];

        if (success) {
          final data = response.data['data'] as Map<String, dynamic>;
          print('USER_ID ${data}');

          final mlogin = Mlogin.fromMap(data);
          print('USER_ID ${mlogin.idUser}');

          sharedPreferences.setString(AppConstants.ID_USER, mlogin.idUser);
          sharedPreferences.setString(AppConstants.NIP, mlogin.nip);
          sharedPreferences.setString(AppConstants.NIK, mlogin.nik);
          sharedPreferences.setString(AppConstants.JABATAN, mlogin.ketJab);
          sharedPreferences.setString(AppConstants.NAMA, mlogin.nama);
          sharedPreferences.setString(AppConstants.J_KEL, mlogin.jKelamin);
          sharedPreferences.setString(
              AppConstants.UNIT_KERJA, camelize(mlogin.ketUkerja));

          responseModel = ResponseModel(true, 'Login berhasil', 'selamat');
        } else {
          final String message = response.data['message'].toString();
          responseModel = ResponseModel(false, 'Login gagal', message);
        }

        emit(AuthProeses(responseModel: responseModel));
      } else {
        emit(AuthError(message: apiResponse.error));
      }
    } catch (e) {
      print(e);
    }
  }

  bool isLoginedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> logout() async {
    if (await authRepo.logout()) {
      return true;
    }
    return false;
  }
}
