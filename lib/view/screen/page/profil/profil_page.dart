import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/utill/app_constants.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/di_container.dart' as di;
import 'package:wbs_app/view/base/widget/header_widget.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final SharedPreferences _sharPref = di.getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              Images.header_decoration,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.px, 6.h, 24.px, 3.h),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  HeaderWidget(),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Unit Kerja',
                                style: robotoBold,
                              ),
                              Text(
                                _sharPref
                                    .getString(AppConstants.UNIT_KERJA)
                                    .toString(),
                                style: robotoMedium,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Jabatan',
                                style: robotoBold,
                              ),
                              Text(
                                _sharPref
                                    .getString(AppConstants.JABATAN)
                                    .toString(),
                                style: robotoMedium,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'NIP',
                                style: robotoBold,
                              ),
                              Text(
                                _sharPref
                                    .getString(AppConstants.NIP)
                                    .toString(),
                                style: robotoMedium,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'NIK',
                                style: robotoBold,
                              ),
                              Text(
                                _sharPref
                                    .getString(AppConstants.NIK)
                                    .toString(),
                                style: robotoMedium,
                              ),
                              SizedBox(height: 2.h),
                              // Text(
                              //   'Eselon',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Golongan',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Status ASN',
                              //   style: robotoBold,
                              // ),
                              // Text(
                              //   'PNS',
                              //   style: robotoMedium,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Masa Kerja',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Tempat Tanggal Lahir',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              Text(
                                'Jenis Kelamin',
                                style: robotoBold,
                              ),
                              Text(
                                _sharPref
                                    .getString(AppConstants.J_KEL)
                                    .toString(),
                                style: robotoMedium,
                              ),
                              SizedBox(height: 2.h),
                              // Text(
                              //   'Agama',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Nomor Telpon',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Email',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                              // Text(
                              //   'Alamat',
                              //   style: robotoBold,
                              // ),
                              // SizedBox(height: 2.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
