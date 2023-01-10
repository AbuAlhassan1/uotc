import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/toast_controller.dart';
import 'custom_text.dart';

class Toast extends StatefulWidget {
  const Toast({
    super.key,
    required this.currentType
  });

  final String currentType;

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> {
  final ToastStateController toastController = Get.find();
  
  List<Widget> buildToast(String langCode, List<Widget> widgets){
    if(langCode == "en"){ return widgets.reversed.toList(); }
    else{ return widgets; }
  }

  @override
  Widget build(BuildContext context) {
    log(context.locale.languageCode);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
  
    return SafeArea(
      child: Container(
        width: width * 0.9,
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 0.5
          ),
          gradient: toastController.types[widget.currentType]['color'],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: buildToast(
            context.locale.languageCode,
            [
              // Toast Message -- S t a r t --
              Expanded(
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: context.locale.languageCode == "ar" ?
                    CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      CustomText.createCustomTajawalText(
                        text: toastController.description.value,
                        align: context.locale.languageCode == "ar" ?
                        TextAlign.end : TextAlign.start,
                        color: toastController.types[widget.currentType]['text-color'],
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.bold,
                        screenHeight: height,
                        maxLines: 5
                      ),
                      CustomText.createCustomTajawalText(
                        text: toastController.types[widget.currentType]['sub-text'],
                        align: context.locale.languageCode == "ar" ?
                        TextAlign.end : TextAlign.start,
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.bold,
                        screenHeight: height,
                        maxLines: 1
                      ).tr(),
                    ],
                  ),
                )
              ),
              // Toast Message -- E n d --

              SizedBox(width: 20.w),

              // Toast Icon -- S t a r t --
              Container(
                height: 30.sp,
                width: 30.sp,
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: toastController.types[widget.currentType]['text-color'],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: SvgPicture.asset(toastController.types[widget.currentType]['icon'], color: Colors.white),
              ),
              // Toast Icon -- E n d --
            ]
          )
          
          ,
        )
      ),
    );
  }
}