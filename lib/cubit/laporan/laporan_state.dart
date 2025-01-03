part of 'laporan_cubit.dart';

class LaporanState extends Equatable {
  const LaporanState();

  @override
  List<Object> get props => [];
}

class LaporanInitial extends LaporanState {}

class CreatedLaporanProgress extends LaporanState {}

class CreatedLaporanSuccess extends LaporanState {
  final ResponseModel responseModel;
  const CreatedLaporanSuccess({required this.responseModel});
}

class CreatedLaporanError extends LaporanState {
  final Map<String, dynamic> message;
  const CreatedLaporanError({required this.message});
}

class SearchNipProgress extends LaporanState {}

class SearchNipSuccess extends LaporanState {
  final PejabatModel? pejabat;
  final String message;
  const SearchNipSuccess({this.pejabat, this.message = ''});
}

class SearchNipError extends LaporanState {
  final Map<String, dynamic> message;
  const SearchNipError({required this.message});
}

class LaporanProgress extends LaporanState {}

class LaporanSuccess extends LaporanState {
  final List<LaporanModel>? laporan;
  final String message;
  LaporanSuccess({this.laporan, this.message = ''});
}

class LaporanError extends LaporanState {
  final Map<String, dynamic> message;
  const LaporanError({required this.message});
}
