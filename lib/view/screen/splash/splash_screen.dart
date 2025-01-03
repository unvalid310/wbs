// ignore_for_file: library_private_types_in_public_api, use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/cubit/auth/auth_cubit.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  void splash() {
    if (BlocProvider.of<AuthCubit>(context).isLoginedIn()) {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.DASHBOARD,
          (route) => false,
        ),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.LOGIN_SCREEN,
          (route) => false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0064D9),
      body: Center(
        child: Image.asset(
          Images.splash_logo,
          width: 55.w,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
