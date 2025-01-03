import 'dart:developer';

import 'package:wbs_app/helper/string_helper.dart';

class Mlogin {
  String idUser;
  String username;
  String nip;
  String nik;
  String nama;
  String ketJab;
  String ketUkerja;
  String jKelamin;

  Mlogin({
    this.idUser = '',
    this.username = '',
    this.nip = '',
    this.nik = '',
    this.nama = '',
    this.ketJab = '',
    this.ketUkerja = '',
    this.jKelamin = '',
  });

  factory Mlogin.fromMap(Map<String, dynamic> map) {
    log('USER_ID ${map['id_user']}');

    return Mlogin(
      idUser: (map['id_user'] != null) ? map['id_user'].toString() : '',
      username: (map['username'] != null) ? map['username'].toString() : '',
      nip: (map['nip'] != null) ? map['nip'].toString() : '',
      nik: (map['nik'] != null) ? map['nik'].toString() : '',
      nama: (map['nama'] != null) ? map['nama'].toString() : '',
      ketJab: (map['ket_jab'] != null) ? map['ket_jab'].toString() : '',
      ketUkerja: (map['ket_ukerja'] != null)
          ? replaceComma(map['ket_ukerja'].toString())
          : '',
      jKelamin: (map['j_kelamin'] == 'L') ? 'Laki-laki' : 'Perempuan',
    );
  }
}
