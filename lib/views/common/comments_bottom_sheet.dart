import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/comment_card.dart';
import 'package:uotc/views/common/custom_text.dart';
import 'package:uotc/views/profile.dart';

dynamic buildCommentsAsBottomSheet(BuildContext context){
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp), topRight: Radius.circular(10.sp)),
    ),
    barrierColor: Colors.black.withOpacity(0.9),
    elevation: 1,
    enableDrag: true,
    context: context,
    builder: (context) => Container(
      height: double.infinity, width: double.infinity,
      decoration: BoxDecoration(
        color: UotcColors.blueBold3,
      ),
      child: Column(
        children: [
          // Slide From Area -- S t a r t --
          Container(
            height: 30.h, width: double.infinity,
            decoration: BoxDecoration(
              color: UotcColors.blueBold3,
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                bottomLeft: Radius.circular(5.sp),
                bottomRight: Radius.circular(5.sp),
              )
            ),
            child: Center(
              child: Container(
                height: 5.h, width: 30.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
          // Slide From Area -- E n d --

          // Main Sheet Content -- S t a r t --
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 100,
                itemBuilder: (context, index) =>
                index == 0 ? SizedBox(height: 15.h,) :
                index == 99 ? SizedBox(height: 15.h,) :
                CommentCard(margin: EdgeInsetsDirectional.only(bottom: 10.h)),
              ),
            ),
          ),
          // Main Sheet Content -- E n d --
        ],
      )
    ),
  );
}

dynamic buildSmallProfileBottomSheet(BuildContext context, double screenHeight){
  return showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp), topRight: Radius.circular(10.sp)),
    ),
    isDismissible: true,
    barrierColor: Colors.black.withOpacity(0.9),
    elevation: 1,
    enableDrag: true,
    context: context,
    builder: (context) => Container(
      height: double.infinity, width: double.infinity,
      decoration: BoxDecoration(
        color: UotcColors.blueBold3,
      ),
      child: Column(
        children: [
          // Slide From Area -- S t a r t --
          Container(
            height: 30.h, width: double.infinity,
            decoration: BoxDecoration(
              color: UotcColors.blueBold3,
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                bottomLeft: Radius.circular(5.sp),
                bottomRight: Radius.circular(5.sp),
              )
            ),
            child: Center(
              child: Container(
                height: 5.h, width: 30.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
          // Slide From Area -- E n d --

          // Main Sheet Content -- S t a r t --
          // padding: EdgeInsets.symmetric(horizontal: 15.w),
          Expanded(
            child: Container(
              height: double.infinity, width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  // // Background Profile Image -- S t a r t --
                  // SizedBox(
                  //   width: double.infinity, height: double.infinity,
                  //   child: ImageFade(
                  //   fit: BoxFit.cover,
                  //   image: const AssetImage('assets/jpg/2.jpg'),
                  //   // image: const NetworkImage("https://firebasestorage.googleapis.com/v0/b/uotc-20.appspot.com/o/photo4.jpg?alt=media&token=0a78c44b-ed8d-425a-8df8-baddb6a3a356"),
                  //   loadingBuilder: (context, progress, chunkEvent) => Center(
                  //     child: Padding(
                  //       padding: EdgeInsets.all(20.sp),
                  //       child: const CircularProgressIndicator(color: Colors.grey),
                  //     ),
                  //   ),
                  //   errorBuilder: (context, exception) => const Center(
                  //     child: Text("Something went wrong, Try again"),
                  //   ),
                  //   ),
                  // ),
                  // // Background Profile Image -- E n d --

                  // Background Video -- S t a r t --
                  const MyVideoPlayer(),
                  // Background Video -- E n d --

                  Container(color: Colors.black.withOpacity(0.8)),

                  // User Info -- S t a r t --
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // User Profile Image -- S t a r t --
                        Container(
                          height: 100.w, width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(3.sp),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Image.asset('assets/jpg/2.jpg', fit: BoxFit.cover),
                              ),
                                            
                              // User Role -- S t a r t --
                              Align(
                                alignment: const AlignmentDirectional(1, 1),
                                child: Container(
                                  height: 25.sp, width: 25.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 5,
                                        spreadRadius: -3
                                      )
                                    ]
                                  ),
                                  child: Image.asset('assets/png/check.png'),
                                ),
                              )
                              // User Role -- E n d --
                            ],
                          )
                        ),
                        // User Profile Image -- E n d --

                        SizedBox(height: 5.h),

                        // User Info -- S t a r t --
                        CustomText.createCustomElMessiriText(
                          text: "حيدر يوسف",
                          align: TextAlign.center,
                          color: Colors.white,
                          fontSize: 14,
                          weight: FontWeight.bold,
                          screenHeight: screenHeight
                        ),
                        CustomText.createCustomElMessiriText(
                          text: "haydarnt_8 @",
                          align: TextAlign.center,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          screenHeight: screenHeight
                        ),
                        SizedBox(height: 3.h),
                        CustomText.createCustomTajawalText(
                          text: "Computer Science / Software",
                          align: TextAlign.center,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          screenHeight: screenHeight
                        ),
                        // User Info -- E n d --

                        SizedBox(height: 15.h),

                        // User Info [ Followers Number, Following Number, Posts Number ] -- S t a r t --
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Followers Number -- S t a r t --
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30.sp, width: 30.sp,
                                      child: SvgPicture.asset('assets/svg/followers.svg', color: Colors.white.withOpacity(0.8)),
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomText.createCustomTajawalText(
                                      text: 'المتابِعون',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                    // SizedBox(height: 5.h),
                                    CustomText.createCustomTajawalText(
                                      text: '21k',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                  ],
                                ),
                              ),
                              // Followers Number -- E n d --
  
                              // Following Number -- S t a r t --
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30.sp, width: 30.sp,
                                      child: SvgPicture.asset('assets/svg/following.svg', color: Colors.white.withOpacity(0.8)),
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomText.createCustomTajawalText(
                                      text: 'المتابَعون',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                    // SizedBox(height: 5.h),
                                    CustomText.createCustomTajawalText(
                                      text: '500',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                  ],
                                ),
                              ),
                              // Following Number -- E n d --
  
                              // Posts Number -- S t a r t --
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30.sp, width: 30.sp,
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: SvgPicture.asset('assets/svg/picture.svg', color: Colors.white.withOpacity(0.8)),
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomText.createCustomTajawalText(
                                      text: 'منشوراتي',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                    // SizedBox(height: 5.h),
                                    CustomText.createCustomTajawalText(
                                      text: '122',
                                      color: Colors.white.withOpacity(0.5),
                                      align: TextAlign.center,
                                      fontSize: 12,
                                      screenHeight: screenHeight,
                                    ),
                                  ],
                                ),
                              ),
                              // Posts Number -- E n d --
                            ],
                          ),
                        ),
                        // User Info [ Followers Number, Following Number, Posts Number ] -- E n d --

                      ],
                    ),
                  ),
                  // User Info -- E n d --

                  // Follow & Go To Profile Buttons -- S t a r t --
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(50.sp)
                              ),
                              child: CustomText.createCustomTajawalText(
                                text: 'متابعة',
                                fontSize: 14,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                align: TextAlign.center,
                                screenHeight: screenHeight
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
                              decoration: BoxDecoration(
                                // color: UotcColors.offBlack,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(50.sp)
                              ),
                              child: CustomText.createCustomTajawalText(
                                text: 'الملف الشخصي',
                                fontSize: 14,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                align: TextAlign.center,
                                screenHeight: screenHeight
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  // Follow & Go To Profile Buttons -- E n d --
                ],
              ),
            ),
          ),
          // Main Sheet Content -- E n d --
        ],
      )
    ),
  );
}