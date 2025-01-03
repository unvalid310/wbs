// ignore_for_file: unused_field, prefer_final_fields, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, prefer_const_declarations, unnecessary_string_interpolations, avoid_print, sort_child_properties_last

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/cubit/laporan/laporan_cubit.dart';
import 'package:wbs_app/main.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/view/base/widget/custom_toast_widget.dart';
import 'package:wbs_app/view/base/widget/header_widget.dart';

class TambahLaporanPage extends StatefulWidget {
  const TambahLaporanPage({Key? key}) : super(key: key);

  @override
  _TambahLaporanPageState createState() => _TambahLaporanPageState();
}

class _TambahLaporanPageState extends State<TambahLaporanPage> {
  late int _selectIndexTerlapor;
  late int _selectIndexLampiran;
  final _formKey = GlobalKey<FormState>();
  final FToast toast = FToast();

  TextEditingController _judul = TextEditingController();
  TextEditingController _tanggal = TextEditingController();
  TextEditingController _nominal = TextEditingController();
  TextEditingController _tempat = TextEditingController();
  TextEditingController _deskripsi = TextEditingController();

  List<TextEditingController> _nipTerlapor = [TextEditingController()];
  List<TextEditingController> _namaTerlapor = [TextEditingController()];
  List<TextEditingController> _jabatanTerlapor = [TextEditingController()];
  List<TextEditingController> _unitKerja = [TextEditingController()];
  List<TextEditingController> _lampiran = [TextEditingController()];
  List<TextEditingController> _deskripsiLampiran = [TextEditingController()];

  List<String> _filePath = [''];

  @override
  void initState() {
    super.initState();
    toast.init(context);
    // print('init tambah pengaduan');
  }

  @override
  void dispose() {
    // Dispose of all controllers when the widget is removed
    if (_nipTerlapor.isNotEmpty) {
      for (var i = 0; i < _nipTerlapor.length; i++) {
        _nipTerlapor[i].dispose();
        _namaTerlapor[i].dispose();
        _jabatanTerlapor[i].dispose();
        _unitKerja[i].dispose();
      }
    }

    if (_lampiran.isNotEmpty) {
      for (var i = 0; i < _lampiran.length; i++) {
        _lampiran[i].dispose();
        _deskripsiLampiran[i].dispose();
      }
    }

    super.dispose();
  }

  void foarmClear() {
    _formKey.currentState!.reset();

    _judul.clear();
    _tanggal.clear();
    _nominal.clear();
    _tempat.clear();
    _deskripsi.clear();

    _nipTerlapor = [TextEditingController()];
    _namaTerlapor = [TextEditingController()];
    _jabatanTerlapor = [TextEditingController()];
    _unitKerja = [TextEditingController()];
    _lampiran = [TextEditingController()];
    _deskripsiLampiran = [TextEditingController()];

    if (_nipTerlapor.isNotEmpty) {
      for (var i = 0; i < _nipTerlapor.length; i++) {
        _nipTerlapor[i].clear();
        _namaTerlapor[i].clear();
        _jabatanTerlapor[i].clear();
        _unitKerja[i].clear();
      }
    }

    if (_lampiran.isNotEmpty) {
      for (var i = 0; i < _lampiran.length; i++) {
        _lampiran[i].clear();
        _deskripsiLampiran[i].clear();
      }
    }

    _filePath = [''];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child:
          BlocConsumer<LaporanCubit, LaporanState>(listener: (context, state) {
        if (state is CreatedLaporanProgress) {
          testContext!.loaderOverlay.show();
        }

        if (state is CreatedLaporanSuccess) {
          final _responseModel = state.responseModel;
          testContext!.loaderOverlay.hide();
          if (_responseModel.isSuccess) {
            toast.showToast(
              child: CustomToastWidget(
                message: _responseModel.message,
              ),
              positionedToastBuilder: (context, child, gravity) => Positioned(
                child: child,
                bottom: 5.h,
                left: 0,
                right: 0,
              ),
            );
            Future.delayed(
              const Duration(seconds: 1),
              () => foarmClear(),
            );
          } else {
            toast.showToast(
              child: CustomToastWidget(
                message: _responseModel.message,
                isError: true,
              ),
              positionedToastBuilder: (context, child, gravity) => Positioned(
                child: child,
                bottom: 5.h,
                left: 0,
                right: 0,
              ),
            );
          }
        }

        if (state is CreatedLaporanError) {
          Map<String, dynamic> _message = state.message;
          testContext!.loaderOverlay.hide();
          toast.showToast(
            child: CustomToastWidget(
              message: _message['message'],
              isError: true,
            ),
            positionedToastBuilder: (context, child, gravity) => Positioned(
              child: child,
              bottom: 5.h,
              left: 0,
              right: 0,
            ),
          );
        }
      }, builder: (context, state) {
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
                          child: Container(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'DETAIL LAPORAN',
                                      style: robotoRegular.copyWith(
                                        color: const Color(0XFF2F97F1),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text('Judul Laporan*', style: robotoMedium),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      minLines: 2,
                                      maxLines: 3,
                                      controller: _judul,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Judul Laporan',
                                        hintStyle: robotoRegular.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text('Tanggal Kejadian*',
                                        style: robotoMedium),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      readOnly: true,
                                      controller: _tanggal,
                                      onTap: () async {
                                        print('show date picker');
                                        final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2024, 01, 01),
                                          lastDate: DateTime(2025, 12, 31),
                                        );

                                        if (date != null) {
                                          setState(() {
                                            _tanggal.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Tanggal Kejadian',
                                        hintStyle: robotoRegular.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text('Jumlah Rupiah (Jika Ada)',
                                        style: robotoMedium),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _nominal,
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: robotoRegular.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text('Tempat Kejadian*',
                                        style: robotoMedium),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      minLines: 2,
                                      maxLines: 3,
                                      controller: _tempat,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Tempat Kejadian',
                                        hintStyle: robotoRegular.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text('Deskripsi Kejadian*',
                                        style: robotoMedium),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      minLines: 5,
                                      maxLines: 6,
                                      controller: _deskripsi,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Deskripsi Kejadian',
                                        hintStyle: robotoRegular.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'PIHAK YANG DIDUGA TERLIBAT',
                                      style: robotoRegular.copyWith(
                                        color: const Color(0XFF2F97F1),
                                      ),
                                    ),
                                    Text(
                                      '*Jika anda tidak mengetahui Jabatan atau Unit Kerja dari pihak yang dilaporkan, berikan tanda (-) untuk melengkapi laporan.',
                                      style: robotoRegular,
                                    ),
                                    SizedBox(height: 2.h),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _nipTerlapor.length + 1,
                                      itemBuilder: (context, index) {
                                        if (_nipTerlapor.length == index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.h),
                                                decoration: BoxDecoration(
                                                  color: ColorsResource.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  'Tambah Terlapor Lain',
                                                  style: robotoBold.copyWith(
                                                    fontSize: 16.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _nipTerlapor.add(
                                                      TextEditingController());
                                                  _namaTerlapor.add(
                                                      TextEditingController());
                                                  _jabatanTerlapor.add(
                                                      TextEditingController());
                                                  _unitKerja.add(
                                                      TextEditingController());
                                                });
                                              },
                                            ),
                                          );
                                        }

                                        return BlocConsumer<LaporanCubit,
                                                LaporanState>(
                                            listener: (context, state) {
                                          if (state is SearchNipProgress) {
                                            testContext!.loaderOverlay.show();
                                          }

                                          if (state is SearchNipSuccess) {
                                            final _pejabatModel = state.pejabat;
                                            final _message = state.message;

                                            print(
                                                'nama pegawai ${_pejabatModel?.namaPegawai}');

                                            testContext!.loaderOverlay.hide();
                                            if (_pejabatModel == null) {
                                              toast.showToast(
                                                child: CustomToastWidget(
                                                  message: _message,
                                                  isError: true,
                                                ),
                                                positionedToastBuilder:
                                                    (context, child, gravity) =>
                                                        Positioned(
                                                  child: child,
                                                  bottom: 5.h,
                                                  left: 0,
                                                  right: 0,
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                _namaTerlapor[
                                                            _selectIndexTerlapor]
                                                        .text =
                                                    _pejabatModel.namaPegawai;
                                                _jabatanTerlapor[
                                                            _selectIndexTerlapor]
                                                        .text =
                                                    _pejabatModel
                                                        .jabatanPegawai;
                                                _unitKerja[_selectIndexTerlapor]
                                                        .text =
                                                    _pejabatModel.unitKerja;
                                              });
                                            }
                                          }

                                          if (state is SearchNipError) {
                                            testContext!.loaderOverlay.hide();
                                            Map<String, dynamic> _message =
                                                state.message;
                                            toast.showToast(
                                              child: CustomToastWidget(
                                                message: _message['message'],
                                                isError: true,
                                              ),
                                              positionedToastBuilder:
                                                  (context, child, gravity) =>
                                                      Positioned(
                                                child: child,
                                                bottom: 5.h,
                                                left: 0,
                                                right: 0,
                                              ),
                                            );
                                          }
                                        }, builder: (context, state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (index > 0)
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.grey[400],
                                                  height: 4.h,
                                                ),
                                              Text('Nip Terlapor*',
                                                  style: robotoMedium),
                                              SizedBox(height: 1.h),
                                              TextFormField(
                                                controller: _nipTerlapor[index],
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Wajib diisi';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Nip Terlapor',
                                                  hintStyle:
                                                      robotoRegular.copyWith(
                                                    color: Colors.grey[400],
                                                  ),
                                                  fillColor: Colors.transparent,
                                                  suffixIconConstraints:
                                                      BoxConstraints(
                                                          maxHeight: 4.4.h),
                                                  suffixIcon: IconButton(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    icon: Icon(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      Icons.search_rounded,
                                                      weight: 800,
                                                      size: 18.sp,
                                                    ),
                                                    onPressed: () async {
                                                      if (_nipTerlapor[index]
                                                          .text
                                                          .isNotEmpty) {
                                                        setState(() {
                                                          _selectIndexTerlapor =
                                                              index;
                                                        });
                                                        await BlocProvider.of<
                                                                    LaporanCubit>(
                                                                context)
                                                            .searchNip(
                                                                nip: _nipTerlapor[
                                                                        index]
                                                                    .text);
                                                      } else {
                                                        toast.showToast(
                                                          child:
                                                              const CustomToastWidget(
                                                            message:
                                                                'Nip tidak boleh kosong',
                                                            isError: true,
                                                          ),
                                                          positionedToastBuilder:
                                                              (context, child,
                                                                      gravity) =>
                                                                  Positioned(
                                                            child: child,
                                                            bottom: 5.h,
                                                            left: 0,
                                                            right: 0,
                                                          ),
                                                        );
                                                      }
                                                      print('search');
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text('Nama Terlapor*',
                                                  style: robotoMedium),
                                              SizedBox(height: 1.h),
                                              TextFormField(
                                                readOnly: true,
                                                controller:
                                                    _namaTerlapor[index],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Wajib diisi';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Nama Terlapor',
                                                  hintStyle:
                                                      robotoRegular.copyWith(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text('Jabatan*',
                                                  style: robotoMedium),
                                              SizedBox(height: 1.h),
                                              TextFormField(
                                                readOnly: true,
                                                controller:
                                                    _jabatanTerlapor[index],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Wajib diisi';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Jabatan',
                                                  hintStyle:
                                                      robotoRegular.copyWith(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text('Unit Kerja*',
                                                  style: robotoMedium),
                                              SizedBox(height: 1.h),
                                              TextFormField(
                                                minLines: 2,
                                                maxLines: 3,
                                                readOnly: true,
                                                controller: _unitKerja[index],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Wajib diisi';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Unit Kerja',
                                                  hintStyle:
                                                      robotoRegular.copyWith(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              if (index > 0)
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 1.h),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 1.h,
                                                              horizontal: 3.h),
                                                      decoration: BoxDecoration(
                                                        color: ColorsResource
                                                            .danger,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        'Hapus Terlapor',
                                                        style:
                                                            robotoBold.copyWith(
                                                          fontSize: 16.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        _nipTerlapor
                                                            .removeAt(index);
                                                        _namaTerlapor
                                                            .removeAt(index);
                                                        _jabatanTerlapor
                                                            .removeAt(index);
                                                        _unitKerja
                                                            .removeAt(index);
                                                      });
                                                    },
                                                  ),
                                                ),
                                            ],
                                          );
                                        });
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'LAMPIRAN PENDUKUNG LAPORAN',
                                      style: robotoRegular.copyWith(
                                        color: const Color(0XFF2F97F1),
                                      ),
                                    ),
                                    Text(
                                      '*Untuk laporan baru, anda hanya bisa menambahkan 3 file pendukung dengan kapasitas maksimal 5Mb untuk masing-masing filenya.',
                                      style: robotoRegular,
                                    ),
                                    SizedBox(height: 2.h),
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _lampiran.length + 1,
                                      itemBuilder: (context, index) {
                                        if (_lampiran.length == index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.h),
                                                decoration: BoxDecoration(
                                                  color: ColorsResource.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  'Tambah Lampiran Lain',
                                                  style: robotoBold.copyWith(
                                                    fontSize: 16.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _lampiran.add(
                                                      TextEditingController());
                                                  _deskripsiLampiran.add(
                                                      TextEditingController());
                                                  _filePath.add('');
                                                });
                                              },
                                            ),
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (index > 0)
                                              Divider(
                                                thickness: 1,
                                                color: Colors.grey[400],
                                                height: 4.h,
                                              ),
                                            Text('File Lampiran*',
                                                style: robotoMedium),
                                            SizedBox(height: 1.h),
                                            TextFormField(
                                              readOnly: true,
                                              controller: _lampiran[index],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Wajib diisi';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Nama Terlapor',
                                                hintStyle:
                                                    robotoRegular.copyWith(
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                              onTap: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  allowMultiple: false,
                                                  type: FileType.custom,
                                                  allowedExtensions: ['pdf'],
                                                );

                                                if (result != null) {
                                                  PlatformFile file =
                                                      result.files.first;
                                                  final _fileSize =
                                                      double.parse((file.size /
                                                              (1024 * 1024))
                                                          .toStringAsFixed(2));
                                                  final _maxSize = 2;

                                                  print('${file.name}');
                                                  print(
                                                      'size $_fileSize max size $_maxSize');
                                                  print(file.path);

                                                  if (_fileSize > _maxSize) {
                                                    print('file terlalu besar');

                                                    toast.showToast(
                                                      child:
                                                          const CustomToastWidget(
                                                        message:
                                                            'Ukuran file terlalu besar',
                                                        isError: true,
                                                      ),
                                                      positionedToastBuilder:
                                                          (context, child,
                                                                  gravity) =>
                                                              Positioned(
                                                        child: child,
                                                        bottom: 5.h,
                                                        left: 0,
                                                        right: 0,
                                                      ),
                                                    );
                                                  } else {
                                                    setState(() {
                                                      _lampiran[index].text =
                                                          file.name;
                                                      _filePath[index] =
                                                          file.path.toString();
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                            SizedBox(height: 2.h),
                                            Text('Deskripsi*',
                                                style: robotoMedium),
                                            SizedBox(height: 1.h),
                                            TextFormField(
                                              minLines: 3,
                                              maxLines: 4,
                                              controller:
                                                  _deskripsiLampiran[index],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Wajib diisi';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Deskripsi',
                                                hintStyle:
                                                    robotoRegular.copyWith(
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            if (index > 0)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 1.h),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.h,
                                                            horizontal: 3.h),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          ColorsResource.danger,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      'Hapus Terlapor',
                                                      style:
                                                          robotoBold.copyWith(
                                                        fontSize: 16.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      _lampiran.removeAt(index);
                                                      _deskripsiLampiran
                                                          .removeAt(index);
                                                      _filePath.removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.h),
                                                decoration: BoxDecoration(
                                                  color: ColorsResource.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  'Simpan',
                                                  style: robotoBold.copyWith(
                                                      fontSize: 16.sp,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  List<Map<String, dynamic>>
                                                      terlapor = [];
                                                  List<Map<String, dynamic>>
                                                      lampiran = [];

                                                  for (var i = 0;
                                                      i < _nipTerlapor.length;
                                                      i++) {
                                                    terlapor.add({
                                                      'nip_terlapor[]':
                                                          _nipTerlapor[i].text,
                                                      'nama_terlapor[]':
                                                          _namaTerlapor[i].text,
                                                      'jabatan_terlapor[]':
                                                          _jabatanTerlapor[i]
                                                              .text,
                                                      'unit_kerja[]':
                                                          _unitKerja[i].text,
                                                    });
                                                  }

                                                  for (var i = 0;
                                                      i < _lampiran.length;
                                                      i++) {
                                                    lampiran.add({
                                                      'filename':
                                                          _lampiran[i].text,
                                                      'path': _filePath[i],
                                                      'deskripsi_lampiran':
                                                          _deskripsiLampiran[i]
                                                              .text,
                                                    });
                                                  }

                                                  Map<String, dynamic> data = {
                                                    'judul': _judul.text,
                                                    'tanggal': _tanggal.text,
                                                    'nominal': _nominal.text,
                                                    'tempat': _tempat.text,
                                                    'deskripsi':
                                                        _deskripsi.text,
                                                  };

                                                  print(
                                                      'form data $data , $terlapor , $lampiran');
                                                  await BlocProvider.of<
                                                          LaporanCubit>(context)
                                                      .createdLaporan(
                                                    data: data,
                                                    terlapor: terlapor,
                                                    lampiran: lampiran,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.h),
                                                decoration: BoxDecoration(
                                                  color: ColorsResource.danger,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  'Batal',
                                                  style: robotoBold.copyWith(
                                                      fontSize: 16.sp,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
      }),
    );
  }
}
