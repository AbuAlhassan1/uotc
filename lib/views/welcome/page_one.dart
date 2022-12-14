import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import 'package:uotc/views/common/custom_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: height/3,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 2,
            //         child: SvgPicture.asset('assets/svg/boo.svg'),
            //       ),
            //       SizedBox(width: 15.w,),
            //       Expanded(
            //         flex: 3,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(bottom: 10.h),
            //               child: CustomText.createCustomElMessiriText(
            //                 text: LocaleKeys.welcomeToUniversityOfTechnology,
            //                 align: TextAlign.start,
            //                 color: Colors.white,
            //                 fontSize: 25,
            //                 overflow: TextOverflow.visible,
            //                 weight: FontWeight.bold,
            //                 maxLines: 2
            //               ).tr(),
            //             ),
            //             CustomText.createCustomTajawalText(
            //               text: LocaleKeys.enjoyStudyingOnUOTCampus,
            //               align: TextAlign.start,
            //               color: Colors.white,
            //               fontSize: 20,
            //               overflow: TextOverflow.visible,
            //               weight: FontWeight.w100,
            //               maxLines: 2
            //             ).tr()
            //           ],
            //         )
            //       ),
            //       // Container(
            //       //   height: 100, width: 100,
            //       //   // padding: EdgeInsets.symmetric(vertical: 20.h),
            //       //   // margin: EdgeInsets.symmetric(vertical: 20.h),
            //       //   child: SvgPicture.asset('assets/svg/boo.svg'),
            //       // ),
            //     ],
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: CustomText.createCustomElMessiriText(
                text: LocaleKeys.welcomeToUniversityOfTechnology,
                align: TextAlign.center,
                color: Colors.white,
                fontSize: 30,
                overflow: TextOverflow.visible,
                weight: FontWeight.bold,
                maxLines: 2
              ).tr(),
            ),
            
            CustomText.createCustomTajawalText(
              text: LocaleKeys.enjoyStudyingOnUOTCampus,
              align: TextAlign.center,
              color: Colors.white,
              fontSize: 20,
              overflow: TextOverflow.visible,
              weight: FontWeight.w100
            ).tr()
          ],
        ),
      ),
    );
  }
}