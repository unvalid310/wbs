// ignore_for_file: unused_element, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:wbs_app/utill/routes.dart';
import 'package:wbs_app/view/screen/auth/login_screen.dart';
import 'package:wbs_app/view/screen/dashboard/dashboard_screen.dart';
import 'package:wbs_app/view/screen/splash/splash_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static final Handler _splashHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => SplashScreen(),
  );
  static final Handler _loginHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => LoginScreen(),
  );
  static final Handler _dashScreenBoardHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen(
        pageIndex: params['page'][0] == 'home'
            ? 0
            : params['page'][0] == 'laporan'
                ? 1
                : params['page'][0] == 'tambah-laporan'
                    ? 2
                    : params['page'][0] == 'informasi'
                        ? 3
                        : params['page'][0] == 'profil'
                            ? 4
                            : 0),
  );
  static final Handler _deshboardHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen(
      pageIndex: 0,
    ),
  );

  static void setupRouter() {
    router.define(Routes.SPLASH_SCREEN,
        handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD_SCREEN,
        handler: _dashScreenBoardHandler,
        transitionType: TransitionType.fadeIn); // ?page=home
    router.define(Routes.DASHBOARD,
        handler: _deshboardHandler, transitionType: TransitionType.fadeIn);
  }
}
