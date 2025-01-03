class PejabatModel {
  PejabatModel({
    required this.namaPegawai,
    required this.unitKerja,
    required this.jabatanPegawai,
  });

  factory PejabatModel.fromMap(Map<String, dynamic> map) {
    
    return PejabatModel(
      namaPegawai:
          (map['nama_pegawai'] == null) ? '' : map['nama_pegawai'].toString(),
      unitKerja:
          (map['unit_kerja'] == null) ? '' : map['unit_kerja'].toString(),
      jabatanPegawai: (map['jabatan_pegawai'] == null)
          ? ''
          : map['jabatan_pegawai'].toString(),
    );
  }

  String namaPegawai = '';
  String jabatanPegawai = '';
  String unitKerja = '';
}
