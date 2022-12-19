import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uotc/views/common/colors.dart';

class UotcBottomNavigationBar extends StatelessWidget {
  const UotcBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Positioned(
      bottom: 0,
      child: Container(
        width: width, height: 60,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        color: UotcColors.offBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => Container(
              height: 30.h, width: 30.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ), 
            )
          ),
        ),
      ),
    );
  }
}