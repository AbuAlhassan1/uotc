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
  final PageController postController = PageController(viewportFraction: 1);
  bool isStoriesHidden = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [
      SystemUiOverlay.bottom
    ]);
    // postController.addListener(() {
    //   if( postController.offset < 30 ){
    //     toastController.showStories(-75.h);
    //   }else{
    //     toastController.hideStories(-75.h);
    //   }
    // });
    log('home init asdasdasd');
    Future.delayed(const Duration(seconds: 1), () => toastController.showStories(-75.h));
    Future.delayed(const Duration(seconds: 1), () => toastController.showHome());
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
            Obx(() => Positioned(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                opacity: toastController.homeOpacity.value,
                child: SizedBox(
                  height: height, width: width,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: postController,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return PostOne(postIndex: index,);
                    },
                  ),
                ),
              ),
            ),),

            // Stories -- S t a r t  --
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubicEmphasized,
                top: toastController.storiesPosition.value,
                child: Container(
                  width: width,
                  color: Colors.black,
                  padding: EdgeInsetsDirectional.only(top: 10.h, end: 0.w),
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
                        onTap: () => toastController.hideShowStories(-75.h),
                        child: Container(
                          width: width, height: 35.h,
                          padding: EdgeInsetsDirectional.only(top: 0.h, start: 10.w),
                          child: Row(
                            children: [
                              Icon(
                                toastController.isStoriesHidden.value ?
                                Icons.arrow_drop_down_rounded
                                : Icons.arrow_drop_up_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: CustomText.createCustomElMessiriText(
                                  text: "اليوميات",
                                  align: TextAlign.start,
                                  color: Colors.white,
                                  fontSize: 16,
                                  overflow: TextOverflow.visible,
                                  weight: FontWeight.bold,
                                  maxLines: 3,
                                  screenHeight: height
                                ).tr(),
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