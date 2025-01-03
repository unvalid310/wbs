// ignore_for_file: constant_identifier_names

class Routes {
  static const String SPLASH_SCREEN = '/splash';
  static const String LOGIN_SCREEN = '/login';
  static const String DASHBOARD_SCREEN = '/dashboard';
  static const String DASHBOARD = '/';
  static const String HOME_SCREEN = '/home';
  static const String ABSENSI_SCREEN = '/absensi';
  static const String RIWAYAT_ABSENSI_SCREEN = '/riwayat-absensi';
  static const String SURAT_SCREEN = '/surat';
  static const String BERITA_SCREEN = '/berita';
  static const String KINERJA_SCREEN = '/kinerja';
  static const String DAFTAR_PEJABAT_SCREEN = '/daftar-pejabat';

  static String getSplashRoute() => SPLASH_SCREEN;
  static String getLoginRoute() => LOGIN_SCREEN;
  static String getMainRoute() => DASHBOARD;
  static String getDashboardRoute(String page) =>
      '$DASHBOARD_SCREEN?page=$page';
}
