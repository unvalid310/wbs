// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/cubit/laporan/laporan_cubit.dart';
import 'package:wbs_app/data/model/mpengaduan.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/view/base/widget/header_widget.dart';

class ListLaporanPage extends StatefulWidget {
  const ListLaporanPage({Key? key}) : super(key: key);

  @override
  _ListLaporanPageState createState() => _ListLaporanPageState();
}

class _ListLaporanPageState extends State<ListLaporanPage> {
  final menuDropdown = <String>[
    'Semua Laporan',
    'Laporan Baru',
    'Laporan Diverifikasi',
    'Laporan Ditolak',
  ];
  String _selectedMenu = 'Semua Laporan';
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Filter : ',
                                  style: robotoMedium,
                                ),
                                SizedBox(width: 2.h),
                                DropdownButton<String>(
                                  hint: Text(
                                    'Pilih Laporan',
                                    style: robotoMedium,
                                  ),
                                  value: _selectedMenu,
                                  onChanged: (String? newValue) async {
                                    String _status = '';
                                    if (newValue == 'Semua Laporan') {
                                      _status = '';
                                    }
                                    if (newValue == 'Laporan Baru') {
                                      _status = 'baru';
                                    }
                                    if (newValue == 'Laporan Diverifikasi') {
                                      _status = 'selesai';
                                    }
                                    if (newValue == 'Laporan Ditolak') {
                                      _status = 'baru';
                                    }

                                    print('status laporan : ${_status}');

                                    setState(() {
                                      _selectedMenu = newValue!;
                                    });

                                    BlocProvider.of<LaporanCubit>(context,
                                            listen: false)
                                        .getLaporan(status: _status);
                                  },
                                  alignment: AlignmentDirectional.centerStart,
                                  items: menuDropdown
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: robotoMedium,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
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
                                  print('List Laporan ${_listLaporan.length}');

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
                      // ListView.separated(
                      //   itemCount: _menuList.length,
                      //   clipBehavior: Clip.none,
                      //   padding: EdgeInsets.zero,
                      //   separatorBuilder: (context, index) =>
                      //       SizedBox(height: 2.h),
                      //   itemBuilder: (context, index) => Container(
                      //     width: double.infinity,
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           _menuList[index]['icon'] as IconData?,
                      //           size: 19.sp,
                      //         ),
                      //         SizedBox(width: 2.w),
                      //         Text(_menuList[index]['title'].toString())
                      //       ],
                      //     ),
                      //   ),
                      // ),
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

extension on BuildContext? {
  get loaderOverlay => null;
}
