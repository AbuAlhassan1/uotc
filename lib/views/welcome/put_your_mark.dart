import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import 'package:uotc/views/common/custom_text.dart';

class PutYourMark extends StatelessWidget {
  const PutYourMark({super.key});

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: CustomText.createCustomElMessiriText(
                text: LocaleKeys.putYourMarkOnTheCampus,
                align: TextAlign.center,
                color: Colors.white,
                fontSize: 30,
                overflow: TextOverflow.visible,
                weight: FontWeight.bold,
                maxLines: 2
              ).tr(),
            ),
            
            CustomText.createCustomTajawalText(
              text: LocaleKeys.putYourMarkOnTheCampusDesc,
              align: TextAlign.center,
              color: Colors.white,
              fontSize: 20,
              overflow: TextOverflow.visible,
              weight: FontWeight.w100,
              maxLines: 2
            ).tr()
          ],
        ),
      ),
    );
  }
}