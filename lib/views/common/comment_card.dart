import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/views/common/colors.dart';

import 'custom_text.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Container(
      width: width - 60.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: UotcColors.offBlack,
        // borderRadius: BorderRadius.circular(10.sp)
      ),
      child: Row(
        children: [
          // Comment [ User Image ] -- S t a r t --
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70.sp, height: 70.sp,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/png/avatar.jpg', fit: BoxFit.cover,)
                  ),
                ),
              ],
            ),
          ),
          // Comment [ User Image ] -- E n d --
          
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Comment [ User Name & Date Time ] -- S t a r t --
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: FittedBox(
                    child: Row(
                      children: [
                        CustomText.createCustomTajawalText(
                          text: 'حيدر يوسف ',
                          align: TextAlign.start,
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.bold,
                          maxLines: 3
                        ).tr(),
                        CustomText.createCustomTajawalText(
                          text: '. قبل 5 دقائق',
                          align: TextAlign.start,
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.normal,
                          maxLines: 3
                        ).tr(),
                      ],
                    ),
                  ),
                ),
                // Comment [ User Name & Date Time ] -- E n d --

                // Comment Text -- S t a r t --
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: CustomText.createCustomTajawalText(
                    text: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى",
                    align: TextAlign.start,
                    color: Colors.white,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    weight: FontWeight.w400,
                    maxLines: 3
                  ).tr(),
                ),
                // Comment Text -- E n d --

                // Comment Interaction Bar -- S t a r t --
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 5.w),
                      child: CustomText.createCustomTajawalText(
                        text: "الردود  ( 16 )",
                        align: TextAlign.start,
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w400,
                        maxLines: 3
                      ).tr(),
                    ),
                    Row(
                      children: [
                        CustomText.createCustomTajawalText(
                          text: "( 16 )",
                          align: TextAlign.start,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          weight: FontWeight.w400,
                          maxLines: 3
                        ).tr(),
                        Container(
                          height: 18.sp,
                          padding: EdgeInsetsDirectional.only(end: 10.w),
                          child: SvgPicture.asset('assets/svg/heart_solid.svg', color: Colors.red,),
                        ),
                        SizedBox(
                          height: 16.sp,
                          child: SvgPicture.asset('assets/svg/paper-plane.svg', color: Colors.white,),
                        ),
                      ],
                    )
                  ],
                )
                // Comment Interaction Bar -- E n d --
              ],
            )
          ),
        ],
      ),
    );
  }
}