// ignore_for_file: library_private_types_in_public_api, use_super_parameters, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/cubit/auth/auth_cubit.dart';
import 'package:wbs_app/data/model/base/response_model.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/utill/images.dart';
import 'package:wbs_app/utill/routes.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:wbs_app/view/base/widget/custom_toast_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _txtUsername = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FToast toast = FToast();
  late ResponseModel _responseModel;

  bool _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthProgress) {
            context.loaderOverlay.show();
          }
          if (state is AuthProeses) {
            context.loaderOverlay.hide();
            _responseModel = state.responseModel;
            if (_responseModel.isSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.DASHBOARD,
                (router) => false,
              );
            } else {
              print('login gagal ${_responseModel.message}');
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
          if (state is AuthError) {
            context.loaderOverlay.hide();
            Map<String, dynamic> _message = state.message;
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
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 15.px),
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Images.login_logo,
                          width: 56.w,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Selamat Datang',
                          style: robotoBold.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Log In untuk melanjutkan',
                          style: robotoRegular.copyWith(
                              fontSize: 16.sp, color: const Color(0XFF847E7E)),
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: _txtUsername,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap masukan Username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(
                                color: Color(0XFF847E7E),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(
                                color: ColorsResource.primary,
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(
                                color: ColorsResource.danger,
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(
                                color: ColorsResource.danger,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                right: 3.w, top: 1.h, bottom: 1.h),
                            labelText: 'Username',
                            labelStyle: robotoRegular.copyWith(fontSize: 16.sp),
                            floatingLabelStyle: robotoRegular.copyWith(
                              fontSize: 16.sp,
                              color: ColorsResource.primary,
                            ),
                            hintText: 'Username',
                            filled: true,
                            fillColor: Colors.transparent,
                            isDense: true,
                            hintStyle: robotoRegular.copyWith(
                              fontSize: 16.sp,
                              color: const Color(0xffa5a5a5),
                            ),
                            alignLabelWithHint: true,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: _txtPassword,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap masukan password';
                            }
                            return null;
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                  borderSide: BorderSide(
                                    color: Color(0XFF847E7E),
                                  )),
                              focusedBorder: const UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: ColorsResource.primary,
                                ),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: ColorsResource.danger,
                                ),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: ColorsResource.danger,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                  right: 3.w, top: 1.h, bottom: 1.h),
                              labelText: 'Password',
                              labelStyle:
                                  robotoRegular.copyWith(fontSize: 16.sp),
                              floatingLabelStyle: robotoRegular.copyWith(
                                fontSize: 16.sp,
                                color: ColorsResource.primary,
                              ),
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.transparent,
                              isDense: true,
                              hintStyle: robotoRegular.copyWith(
                                fontSize: 16.sp,
                                color: const Color(0xffa5a5a5),
                              ),
                              alignLabelWithHint: true,
                              suffixIconConstraints:
                                  BoxConstraints(maxHeight: 2.h),
                              suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                constraints: BoxConstraints(maxHeight: 1.5.h),
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.3),
                                  size: 16.sp,
                                ),
                                onPressed: _toggle,
                              )),
                        ),
                        SizedBox(height: 10.h),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            'Lupa Password Anda?',
                            style: robotoRegular.copyWith(
                              fontSize: 16.sp,
                              color: Color(0XFF847E7E),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.h),
                            decoration: BoxDecoration(
                              color: ColorsResource.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Log In',
                              style: robotoBold.copyWith(
                                  fontSize: 16.sp, color: Colors.white),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  'nip ${_txtUsername.text} password ${_txtPassword.text}');
                              BlocProvider.of<AuthCubit>(context).login(
                                nip: _txtUsername.text,
                                password: _txtPassword.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        Images.login_footer,
                        width: 30.w,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
