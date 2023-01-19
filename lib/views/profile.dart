import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:native_video_player/native_video_player.dart';
// import 'package:rive/rive.dart';
import 'package:uotc/controllers/toast_controller.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/custom_text.dart';
import 'package:video_player/video_player.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ToastStateController toastController = Get.find();
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => toastController.alignNavBtnForProfilePage());
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Scaffold(
      backgroundColor: UotcColors.blueBold3,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverList(delegate: SliverChildListDelegate([
            // Header -- S t a r t --
            Container(
              width: width, height: 600.h,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  // Background Video -- S t a r t --
                  const MyVideoPlayer(),
                  // Background Video -- E n d --
                  
                  // Black Transperant Tent -- S t a r t --
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(height: 700.h, color: UotcColors.blueBold3.withOpacity(0.9)),
                      ],
                    ),
                  ),
                  // Black Transperant Tent -- E n d --

                  // Edit Button -- S t a r t --
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 20.sp, width: 20.sp,
                      margin: EdgeInsets.all(15.sp),
                      child: SvgPicture.asset('assets/svg/edit.svg', color: Colors.white),
                    ),
                  ),
                  // Edit Button -- E n d --

                  // Main Header Content -- S t a r t --
                  SizedBox(
                    height: double.infinity, width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 400.h,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              // User Avatr [ Image ] & Name, Username -- S t a r t --
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // User Image -- S t a r t --
                                    Container(
                                      height: 100.w, width: 100.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Image.asset('assets/png/avatar.jpg', fit: BoxFit.cover),
                                    ),
                                    // User Image -- E n d --

                                    SizedBox(height: 10.h),

                                    // User Name & Username -- S t a r t --
                                    CustomText.createCustomElMessiriText(
                                      text: "ابوالحسن باسم",
                                      color: Colors.white,
                                      fontSize: 14,
                                      weight: FontWeight.bold,
                                      screenHeight: height
                                    ),
                                    SizedBox(height: 0.h),
                                    CustomText.createCustomElMessiriText(
                                      text: "abu_uotc",
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                      screenHeight: height
                                    ),
                                    // User Name & Username -- E n d --
                                  ],
                                ),
                              ),
                              // User Avatr [ Image ] & Name, Username -- E n d --

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
                                            child: SvgPicture.asset('assets/svg/user-add.svg', color: Colors.white),
                                          ),
                                          SizedBox(height: 15.h),
                                          CustomText.createCustomTajawalText(
                                            text: 'Followers',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
                                          ),
                                          SizedBox(height: 5.h),
                                          CustomText.createCustomTajawalText(
                                            text: '21k',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
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
                                            child: SvgPicture.asset('assets/svg/following.svg', color: Colors.white),
                                          ),
                                          SizedBox(height: 15.h),
                                          CustomText.createCustomTajawalText(
                                            text: 'Following',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
                                          ),
                                          SizedBox(height: 5.h),
                                          CustomText.createCustomTajawalText(
                                            text: '500',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
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
                                          SizedBox(
                                            height: 30.sp, width: 30.sp,
                                            child: SvgPicture.asset('assets/svg/picture.svg', color: Colors.white),
                                          ),
                                          SizedBox(height: 15.h),
                                          CustomText.createCustomTajawalText(
                                            text: 'Posts',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
                                          ),
                                          SizedBox(height: 5.h),
                                          CustomText.createCustomTajawalText(
                                            text: '122',
                                            color: Colors.white.withOpacity(0.5),
                                            align: TextAlign.center,
                                            fontSize: 12,
                                            screenHeight: height,
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
                        )
                      ],
                    ),
                  )
                  // Main Header Content -- E n d --
                ],
              )
            ),
            // Header -- E n d --
          ])),
        ],

        body: Column(
          children: [
            Container(
              height: 50.h, width: width,
              color: Colors.black.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                      child: SizedBox(
                        height: 25.sp, width: 25.sp,
                        child: SvgPicture.asset('assets/svg/picture.svg', color: pageIndex == 0 ? Colors.white : Colors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                      child: SizedBox(
                        height: 25.sp, width: 25.sp,
                        child: SvgPicture.asset('assets/svg/hashtag-solid.svg', color: pageIndex == 1 ? Colors.white : Colors.white.withOpacity(0.5))
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                      child: SizedBox(
                        height: 25.sp, width: 25.sp,
                        child: SvgPicture.asset('assets/svg/users-alt.svg', color: pageIndex == 2 ? Colors.white : Colors.white.withOpacity(0.5))
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) => setState(() => pageIndex = index),
                physics: const BouncingScrollPhysics(),
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 3.sp,
                      mainAxisSpacing: 3.sp
                    ),
                    itemBuilder: (context, index) => Container(
                      color: Colors.grey,
                    ),
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      height: 300.h, width: width,
                      color: Colors.grey,
                      margin: EdgeInsets.all(5.sp),
                    ),
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      height: 300.h, width: width,
                      color: Colors.grey,
                      margin: EdgeInsets.all(5.sp),
                    ),
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}


class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => MyVideoStatePlayer();
}

class MyVideoStatePlayer extends State<MyVideoPlayer> {

  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset('assets/videos/uotc1.mp4', videoPlayerOptions: VideoPlayerOptions(
      allowBackgroundPlayback: false,
      mixWithOthers: false
    ),);
    videoController.initialize().then((value) => setState(() {
      videoController.play();
      videoController.setLooping(true);
      videoController.setVolume(0);
    }));
  }

  @override
  void dispose() {
    videoController.dispose();
    log("disssssssssssssssssssss");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return videoController.value.isInitialized ?
      SizedBox(
        width: width,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: videoController.value.size.width,
            height: videoController.value.size.height,
            child: VideoPlayer(videoController)
          ),
        ),
      )
      : const SizedBox();
  }
}