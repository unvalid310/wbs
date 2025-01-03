import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/di_container.dart' as di;
import 'package:wbs_app/utill/app_constants.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({Key? key}) : super(key: key);
  final SharedPreferences _sharPref = di.getIt();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.foto_profil,
            width: 50.px,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sharPref.getString(AppConstants.NAMA).toString(),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: robotoBold,
                ),
                Text(
                  _sharPref.getString(AppConstants.NIP).toString(),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: robotoRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
