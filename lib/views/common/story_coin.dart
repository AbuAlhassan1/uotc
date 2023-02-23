import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uotc/views/common/custom_text.dart';

class StoryCoin extends StatelessWidget {
  const StoryCoin({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Container(
      height: 80.sp, width: 70.sp,
      margin: EdgeInsetsDirectional.only(start: 5.w),
      child: Column(
        children: [
          SizedBox(
            height: 55.sp, width: 60.sp,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
                Center(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(2.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Image.asset("assets/png/avatar.jpg"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          CustomText.createCustomTajawalText(
            text: 'ابوالحسن باسم',
            fontSize: 12,
            align: TextAlign.center,
            color: Colors.white.withOpacity(0.8),
            overflow: TextOverflow.ellipsis,
            screenHeight: height
          )
        ],
      ),
    );
  }
}