// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/helper/router_helper.dart';
import 'package:wbs_app/theme/theme_style.dart';
import 'package:wbs_app/utill/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static final navigatorKey = new GlobalKey<NavigatorState>();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RouterHelper.setupRouter();
  }

  void _route() {}

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return GlobalLoaderOverlay(
          overlayColor: const Color(0xff3168b9).withOpacity(0.7),
          overlayWidgetBuilder: (dynamic progress) {
            return Center(
              child: SpinKitThreeBounce(
                size: 5.w,
                color: Colors.white.withOpacity(0.9),
              ),
            );
          },
          child: MaterialApp(
            initialRoute: Routes.getSplashRoute(),
            onGenerateRoute: RouterHelper.router.generator,
            navigatorKey: App.navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
          ),
        );
      },
    );
  }
}
