import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uotc/views/common/colors.dart';
import '../controllers/toast_controller.dart';
import 'common/custom_text.dart';
import 'common/post_0.1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ToastStateController toastController = Get.find();
  final ScrollController postController = ScrollController();
  bool isStoriesHidden = false;
  double homeOpacity = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.bottom]);
    postController.addListener(() {
      if( postController.offset < 10 ){
        toastController.showStories(-80.h);
      }else{
        toastController.hideStories(-80.h);
      }
    });
    Future.delayed(const Duration(milliseconds: 800), () => setState(() => homeOpacity = 1));
    Future.delayed(const Duration(seconds: 1), () => toastController.hideStories(-80.h));
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: UotcColors.blueBold3,
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Home Page Main Content -- S t a r t --
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
              opacity: homeOpacity,
              child: SizedBox(
                height: height, width: width,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: postController,
                  itemCount: 10,
                  itemBuilder: (context, index) => index == 0 ? SizedBox(height: 45.h) : PostOne(postIndex: index),
                ),
              ),
            ),
            // Home Page Main Content -- E n d --

            // Stories -- S t a r t  --
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubicEmphasized,
                top: toastController.storiesPosition.value,
                child: Container(
                  width: width,
                  color: Colors.black,
                  padding: EdgeInsetsDirectional.only(top: 0.h, bottom: 5.h, end: 0.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 70.sp,
                        color: Colors.black,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) => Container(
                            height: 70.sp, width: 70.sp,
                            margin: EdgeInsetsDirectional.only(start: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => toastController.hideShowStories(-85.h),
                        child: Container(
                          width: width,
                          padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.w),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50.sp,
                                child: Icon(
                                  toastController.isStoriesHidden.value ?
                                  Icons.arrow_drop_down_rounded
                                  : Icons.arrow_drop_up_rounded,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                              CustomText.createCustomElMessiriText(
                                text: "اليوميات",
                                align: TextAlign.start,
                                color: Colors.white,
                                fontSize: 16,
                                overflow: TextOverflow.visible,
                                weight: FontWeight.bold,
                                maxLines: 3,
                                screenHeight: height
                              ),
                            ],
                          )
                        ),
                      )
                    ],
                  )
                ),
              ),
            )
            // Stories -- E n d  --
          ],
        ),
      )
    );
  }
}