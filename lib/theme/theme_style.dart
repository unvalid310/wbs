import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/utill/style.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: const Color(0xfff1eded),
  primaryColor: const Color(0xFF0064D9),
  brightness: Brightness.light,
  focusColor: const Color(0xFFADC4C8),
  hintColor: const Color(0xFF52575C),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ),
  primaryTextTheme: TextTheme(
    bodyMedium: robotoRegular.copyWith(
      fontSize: 16.sp,
      color: const Color(0XFF141212),
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: robotoRegular.copyWith(
      fontSize: 16.sp,
      color: const Color(0XFF141212),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xffa5a5a5), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
          color: const Color(0xff3168b9).withOpacity(0.7), width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
          color: const Color(0xffdc5555).withOpacity(0.7), width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
          color: const Color(0xffdc5555).withOpacity(0.7), width: 1.5),
    ),
    filled: true,
    fillColor: const Color(0Xffa5a5a5).withOpacity(0.04),
    isDense: true,
    hintStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xffa5a5a5),
    ),
    alignLabelWithHint: true,
  ),
);
