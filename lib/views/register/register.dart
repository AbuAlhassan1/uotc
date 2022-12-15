import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import '../common/custom_text.dart';
import '../common/text_fields.dart';
import 'package:animate_gradient/animate_gradient.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    context.setLocale(const Locale('ar'));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: width, height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/jpg/study_one.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  // Header Text -- S t a r t --
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: CustomText.createCustomTajawalText(
                      text: LocaleKeys.login,
                      align: TextAlign.center,
                      color: Colors.white,
                      fontSize: 30,
                      overflow: TextOverflow.visible,
                      weight: FontWeight.bold,
                      maxLines: 2,
                    ).tr(),
                  ),
                  // Header Text -- E n d --
              
                  // Email Text Field -- S t a r t --
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: MyTextField(
                      hint: LocaleKeys.email.tr(),
                    ),
                  ),
                  // Email Text Field -- E n d --
                  
                  // Password Text Field -- S t a r t --
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: MyTextField(
                      hint: LocaleKeys.password.tr(),
                      isPassword: true,
                    ),
                  ),
                  // Password Text Field -- E n d --
              
                  // Login Button -- S t a r t --
                  Container(
                    width: width/1.5,
                    margin: EdgeInsets.only(bottom: 25.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CustomText.createCustomElMessiriText(
                        text: LocaleKeys.login,
                        align: TextAlign.center,
                        color: Colors.black,
                        fontSize: 16,
                        overflow: TextOverflow.visible,
                        weight: FontWeight.normal,
                        maxLines: 2
                      ).tr(),
                    ),
                  ),
                  // Login Button -- E n d --
              
                  // Divider -- S t a r t --
                  Container(
                    width: width/1.5,
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                            height: 1.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: CustomText.createCustomElMessiriText(
                            text: LocaleKeys.or,
                            align: TextAlign.center,
                            color: Colors.white,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                            weight: FontWeight.normal,
                            maxLines: 2
                          ).tr(),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider -- S t a r t --
              
                  // Login With Google -- S t a r t --
                  Container(
                    width: width/1.5,
                    margin: EdgeInsets.only(bottom: 25.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.circular(5.sp),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15,
                          spreadRadius: -5,
                          offset: Offset(0,5)
                        )
                      ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CustomText.createCustomElMessiriText(
                        text: 'Google',
                        align: TextAlign.center,
                        color: Colors.white,
                        fontSize: 16,
                        overflow: TextOverflow.visible,
                        weight: FontWeight.normal,
                        maxLines: 2
                      ).tr(),
                    ),
                  ),
                  // Login With Google -- E n d --
              
                  // Login With FaceBook -- S t a r t --
                  Container(
                    width: width/1.5,
                    margin: EdgeInsets.only(bottom: 25.h),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.blue
                      ),
                      borderRadius: BorderRadius.circular(5.sp),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15,
                          spreadRadius: -5,
                          offset: Offset(0,5)
                        )
                      ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CustomText.createCustomElMessiriText(
                        text: 'Facebook',
                        align: TextAlign.center,
                        color: Colors.white,
                        fontSize: 16,
                        overflow: TextOverflow.visible,
                        weight: FontWeight.normal,
                        maxLines: 2
                      ).tr(),
                    ),
                  ),
                  // Login With FaceBook -- E n d --
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}