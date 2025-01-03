import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbs_app/app/app.dart';
import 'package:wbs_app/cubit/auth/auth_cubit.dart';
import 'package:wbs_app/cubit/laporan/laporan_cubit.dart';
import 'package:wbs_app/di_container.dart' as di;
import 'package:wbs_app/helper/http_overrides_helper.dart';
import 'package:wbs_app/utill/app_bloc_observer.dart';

BuildContext? testContext;
void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    BindingBase.debugZoneErrorsAreFatal = true;
    HttpOverrides.global = HttpOverridesHelper();
    await di.init();

    Bloc.observer = AppBlocObserver();
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => di.getIt<AuthCubit>()),
          BlocProvider<LaporanCubit>(create: (context) => di.getIt<LaporanCubit>()),
        ],
        child: const App(),
      ),
    );
  }, (error, stackTrace) async {
    log(error.toString(), stackTrace: stackTrace);
    // await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
