import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UotcAppBar extends StatelessWidget {
  const UotcAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Positioned(
      top: 0,
      child: Container(
        width: width, height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.black,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.h,
                child: SvgPicture.asset('assets/svg/menu-burger.svg', color: Colors.white,)
              ),
              SizedBox(
                height: 40.h,
                child: Image.asset('assets/png/uotc_logo2.png')
              )
            ],
          ),
        ),
      ),
    );
  }
}