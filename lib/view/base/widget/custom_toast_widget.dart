import 'package:flutter/material.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/utill/style.dart';
import 'package:sizer/sizer.dart';

class CustomToastWidget extends StatelessWidget {
  final String message;
  final bool isError;
  const CustomToastWidget(
      {super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: (isError) ? ColorsResource.danger : ColorsResource.success,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            (isError) ? Icons.cancel_rounded : Icons.check_circle,
            color: Colors.white,
            size: 16.sp,
          ),
          SizedBox(width: 1.2.h),
          Text(
            message,
            style: robotoMedium.copyWith(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          )
        ],
      ),
    );
  }
}
