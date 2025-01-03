// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/cubit/laporan/laporan_cubit.dart';
import 'package:wbs_app/data/model/mpengaduan.dart';
import 'package:wbs_app/main.dart';
import 'package:wbs_app/utill/app_constants.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/di_container.dart' as di;
import 'package:wbs_app/view/base/widget/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SharedPreferences _sharPref = di.getIt();
  List<LaporanModel> _listLaporan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LaporanCubit>(context, listen: false).getLaporan();
  }

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
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF85B4EE),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _sharPref
                                        .getString(AppConstants.UNIT_KERJA)
                                        .toString(),
                                    style: robotoMedium,
                                  ),
                                  Text(
                                      _sharPref
                                          .getString(AppConstants.JABATAN)
                                          .toString(),
                                      style: robotoRegular),
                                  // SizedBox(height: 1.h),
                                  // const Divider(color: Colors.black),
                                  // SizedBox(height: 1.h),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Text(
                                  //               'Lama Menjabat : ',
                                  //               style: robotoRegular,
                                  //             ),
                                  //             Text(
                                  //               '25 Tahun',
                                  //               style: robotoRegular,
                                  //             ),
                                  //             SizedBox(height: 2.h),
                                  //             Text(
                                  //               'Satuan ASN : ',
                                  //               style: robotoRegular,
                                  //             ),
                                  //             Text(
                                  //               'PNS',
                                  //               style: robotoRegular,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 3.w),
                                  //     Expanded(
                                  //       child: Container(
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Text(
                                  //               'Golongan : ',
                                  //               style: robotoRegular,
                                  //             ),
                                  //             Text(
                                  //               'III/A',
                                  //               style: robotoRegular,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            BlocBuilder<LaporanCubit, LaporanState>(
                              builder: (context, state) {
                                if (state is LaporanProgress) {
                                  return Container(
                                    child: ListView.separated(
                                      itemCount: 4,
                                      clipBehavior: Clip.none,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 1.h),
                                      itemBuilder: (context, index) =>
                                          Shimmer.fromColors(
                                        baseColor:
                                            ColorsResource.shimmerBaseColor,
                                        highlightColor: ColorsResource
                                            .shimmerHighlightColor,
                                        child: Container(
                                          padding: EdgeInsets.all(2.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xFF85B4EE),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '-',
                                                    style: robotoBold,
                                                  ),
                                                  SizedBox(width: 1.h),
                                                  Text(
                                                    '-',
                                                    style: robotoBold,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                '-',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoBold,
                                              ),
                                              SizedBox(height: 1.5.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is LaporanSuccess) {
                                  if (state.laporan != null) {
                                    _listLaporan = state.laporan!;
                                  } else {
                                    _listLaporan = [];
                                  }

                                  return (_listLaporan.isNotEmpty)
                                      ? Container(
                                          child: ListView.separated(
                                            itemCount: _listLaporan.length,
                                            clipBehavior: Clip.none,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 1.h,
                                            ),
                                            itemBuilder: (context, index) =>
                                                Container(
                                              padding: EdgeInsets.all(2.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xFF85B4EE),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _listLaporan[index]
                                                            .nomorPengaduan,
                                                        style: robotoBold,
                                                      ),
                                                      SizedBox(width: 1.h),
                                                      Text(
                                                        _listLaporan[index]
                                                            .tanggal,
                                                        style: robotoBold,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Text(
                                                    _listLaporan[index].judul,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: robotoBold,
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  Text(
                                                    _listLaporan[index]
                                                        .deskripsi,
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: robotoRegular,
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Status :',
                                                        style: robotoBold,
                                                      ),
                                                      SizedBox(width: 1.h),
                                                      Text(
                                                        _listLaporan[index]
                                                            .status,
                                                        style: robotoRegular,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Tidak ada laporan untuk ditampilkan',
                                          textAlign: TextAlign.center,
                                          style: robotoRegular.copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        );
                                }
                                if (state is LaporanError) {
                                  testContext?.loaderOverlay.hide();
                                  final _error = state.message;

                                  return Text(
                                    _error['message'].toString(),
                                    textAlign: TextAlign.center,
                                    style: robotoRegular.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  );
                                }

                                return SizedBox.shrink();
                              },
                            ),
                          ],
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
