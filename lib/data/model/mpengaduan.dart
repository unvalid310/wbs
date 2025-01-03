import 'dart:convert';

class LaporanModel {
  LaporanModel({
    required this.id,
    required this.userId,
    required this.nomorPengaduan,
    required this.judul,
    required this.tanggal,
    required this.tempat,
    required this.nominal,
    required this.deskripsi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pihakTerlibat,
    required this.lampiran,
  });

  factory LaporanModel.fromMap(Map<String, dynamic> map) {
    List<PihakTerlibatModel> _pihakTerlibat = [];
    List<LampiranModel> _lampiran = [];

    map['pihak_terlibat'].toList().map(
      (value) => _pihakTerlibat.add(
        PihakTerlibatModel.fromMap(value as Map<String, dynamic>),
      ),
    ).toList();

    map['lampiran'].toList().map(
      (value) => _lampiran.add(
        LampiranModel.fromMap(value as Map<String, dynamic>),
      ),
    ).toList();

    return LaporanModel(
      id: map['id'],
      userId: map['user_id'],
      nomorPengaduan: map['nomor_pengaduan'],
      judul: map['judul'],
      tanggal: map['tanggal'],
      tempat: map['tempat'],
      nominal: map['nominal'],
      deskripsi: map['deskripsi'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      pihakTerlibat: _pihakTerlibat,
      lampiran: _lampiran,
    );
  }

  String id;
  String userId;
  String nomorPengaduan;
  String judul;
  String tanggal;
  String tempat;
  String nominal;
  String deskripsi;
  String status;
  String createdAt;
  String updatedAt;
  List<PihakTerlibatModel> pihakTerlibat = [];
  List<LampiranModel> lampiran = [];
}

class PihakTerlibatModel {
  String id;
  String pengaduanId;
  String nipTerlapor;
  String namaTerlapor;
  String jabatanTerlapor;
  String unitKerja;

  PihakTerlibatModel({
    required this.id,
    required this.pengaduanId,
    required this.nipTerlapor,
    required this.namaTerlapor,
    required this.jabatanTerlapor,
    required this.unitKerja,
  });

  factory PihakTerlibatModel.fromMap(Map<String, dynamic> map) {
    return PihakTerlibatModel(
      id: map['id'],
      pengaduanId: map['pengaduan_id'],
      nipTerlapor: map['nip_terlapor'],
      namaTerlapor: map['nama_terlapor'],
      jabatanTerlapor: map['jabatan_terlapor'],
      unitKerja: map['unit_kerja'],
    );
  }
}

class LampiranModel {
  String id;
  String pengaduanId;
  String fileLampiran;
  String deskripsi;

  LampiranModel({
    required this.id,
    required this.pengaduanId,
    required this.fileLampiran,
    required this.deskripsi,
  });

  factory LampiranModel.fromMap(Map<String, dynamic> map) {
    return LampiranModel(
      id: map['id'],
      pengaduanId: map['pengaduan_id'],
      fileLampiran: map['file_lampiran'],
      deskripsi: map['deskripsi'],
    );
  }
}
