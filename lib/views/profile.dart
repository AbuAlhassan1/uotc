import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:uotc/controllers/toast_controller.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/custom_text.dart';
import 'package:uotc/views/common/post_0.1.dart';
import 'package:uotc/views/common/scroll_behavior.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ToastStateController toastController = Get.find();
  PageController pageController = PageController();
  int pageIndex = 0;
  double pageOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => toastController.alignNavBtnForProfilePage());
    Future.delayed(const Duration(milliseconds: 500), () => setState(() => pageOpacity = 1));
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
      opacity: pageOpacity,
      child: Scaffold(
        // backgroundColor: UotcColors.blueBold3,
        backgroundColor: Colors.black,


        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
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
                                      DragTarget(
                                        onAccept: (data) => log("asdasdasdasdasd"),
                                        builder: (context, candidateData, rejectedData) => Container(
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
                                                child: Image.asset('assets/png/avatar.jpg', fit: BoxFit.cover),
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

                                      CustomText.createCustomElMessiriText(
                                        text: "abu_uotc @",
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        screenHeight: height
                                      ),
                                      // User Name & Username -- E n d --
                                      SizedBox(height: 5.h),
                                      CustomText.createCustomTajawalText(
                                        text: "Computer Science / Software",
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        screenHeight: height
                                      ),
                                    ],
                                  ),
                                ),
                                // User Avatr [ Image ] & Name, Username -- E n d --

                                // Ranjing Info -- S t a r t --
                                Row(
                                  children: [
                                    // Rank -- S t a r t --
                                    Expanded(
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Rank Image -- S t a r t --
                                            SizedBox(
                                              width: 55.sp, height: 55.sp,
                                              child: Image.asset('assets/png/military-rank.png'),
                                            ),
                                            // Rank Image -- E n d --
                                            SizedBox(width: 10.w),
                                            // Points -- S t a r t --
                                            Column(
                                              children: [
                                                SvgPicture.asset('assets/svg/bullet.svg', color: Colors.yellow, width: 40.sp,),
                                                CustomText.createCustomElMessiriText(
                                                  text: '100K',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  weight: FontWeight.bold,
                                                  align: TextAlign.center,
                                                  screenHeight: height,
                                                ),
                                              ],
                                            ),
                                            // Points -- E n d --
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Rank -- E n d --
                                    
                                  ],
                                ),
                                // Ranjing Info -- E n d --

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
                                              screenHeight: height,
                                            ),
                                            // SizedBox(height: 5.h),
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
                                              child: SvgPicture.asset('assets/svg/following.svg', color: Colors.white.withOpacity(0.8)),
                                            ),
                                            SizedBox(height: 15.h),
                                            CustomText.createCustomTajawalText(
                                              text: 'المتابَعون',
                                              color: Colors.white.withOpacity(0.5),
                                              align: TextAlign.center,
                                              fontSize: 12,
                                              screenHeight: height,
                                            ),
                                            // SizedBox(height: 5.h),
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
                                              screenHeight: height,
                                            ),
                                            // SizedBox(height: 5.h),
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
              // Tab Bar -- S t a r t --
              Container(
                height: 50.h, width: width,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: UotcColors.blueBold2,
                      width: 0.1.h
                    ),
                    bottom: BorderSide(
                      color: UotcColors.blueBold2,
                      width: 1.h
                    ),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: pageIndex == 0 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                                width: 2.h
                              ),
                            )
                          ),
                          child: SvgPicture.asset(
                            pageIndex == 0 ? 'assets/svg/grid-solid.svg' : 'assets/svg/grid.svg',
                            color: pageIndex == 0 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: pageIndex == 1 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                                width: 2.h
                              ),
                            )
                          ),
                          child: SvgPicture.asset(
                            pageIndex == 1 ? 'assets/svg/picture-solid.svg' : 'assets/svg/picture.svg',
                            color: pageIndex == 1 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic),
                        child: Container(
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: pageIndex == 2 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                                width: 2.h
                              ),
                            )
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/star-solid.svg',
                            color: pageIndex == 2 ? Colors.yellow.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Tab Bar -- E n d --

              // User Posts -- S t a r t --
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) => setState(() => pageIndex = index),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: GridView.builder(
                        // physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2.sp,
                          mainAxisSpacing: 2.sp
                        ),
                        itemBuilder: (context, index) => 
                        Container(
                          color: Colors.grey,
                          child: ImageFade(
                            fit: BoxFit.cover,
                            // image: const AssetImage("assets/jpg/8.jpg"),
                            image: const NetworkImage("https://images.unsplash.com/photo-1674284623748-e2d3f89241ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                            loadingBuilder: (context, progress, chunkEvent) => Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.sp),
                                child: const CircularProgressIndicator(color: Colors.grey),
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                    ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        // physics: const BouncingScrollPhysics(),
                        itemCount: 11,
                        itemBuilder: (context, index) => index == 0 ? SizedBox(height: 10.h) : const PostOne(postData: {})
                      ),
                    ),
                    ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: GridView.builder(
                          // physics: const BouncingScrollPhysics(),
                          itemCount: 100,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 2.sp,
                            mainAxisSpacing: 2.sp
                          ),
                          itemBuilder: (context, index) {
                            Widget baseStar = DragTarget(
                              onAccept: (int data) => log((data + index).toString()),
                              builder: (context, candidateData, rejectedData) => Container(
                                height: 30.sp, width: 30.sp,
                                margin: EdgeInsetsDirectional.only(end: 5.w),
                                child: SvgPicture.asset('assets/svg/star-solid.svg', color: Colors.yellow,),
                              ),
                            );

                            Widget dragedStar = SizedBox(
                              height: (width/2) - 5.sp, width: (width/2) - 5.sp,
                              child: SvgPicture.asset('assets/svg/star-solid.svg', color: Colors.yellow,),
                            );


                            return LongPressDraggable(
                              data: index,
                              childWhenDragging: Container(
                                height: 30.sp, width: 30.sp,
                                margin: EdgeInsetsDirectional.only(end: 5.w),
                              ),
                              feedback: dragedStar,
                              child: baseStar,
                            );
                          }
                        ),
                      ),
                    ),
                  ],
                )
              ),
              // User Posts -- E n d --
            ],
          )
        ),
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

  double videoOpacity = 0;


  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return
      AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        opacity: videoOpacity,
        child: SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.cover,
          ),
        ),
      );
  }
}