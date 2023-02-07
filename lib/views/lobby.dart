import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import 'package:uotc/views/common/colors.dart';
import '../controllers/toast_controller.dart';
import 'common/custom_text.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key, required this.myChild}) : super(key: key);
  final Widget? myChild;

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> with TickerProviderStateMixin {

  ToastStateController toastController = Get.find();
  PageController pageController = PageController(initialPage: 0);

  // Animation Stuff -- S t a r t --
  late AnimationController controller;
  late Animation<Offset> animation;
  late Animation<double> sAnimation;
  late Animation<double> borderRadiusAnimation;
  late Animation<double> testAnimation;
  // Animation Stuff -- E n d --

  bool ignoringPointer = false;
  double statusBarPosition = -15.h;

  // Navigation Stuff -- S t a r t --
  bool isPageHome = true;
  bool isPageProfile = false;
  bool isPageSettings = false;
  // Navigation Stuff -- E n d --

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), reverseDuration: const Duration(milliseconds: 300));
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.5, 0)).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));
    sAnimation = Tween<double>(begin: 1, end: 0.98).animate(controller);
    borderRadiusAnimation = Tween<double>(begin: 5, end: 20).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    // Preparing Home Page -- S t a r t --
    Future.delayed(const Duration(seconds: 1), () => toastController.showStatusBar());
    toastController.navMenuButtonPosition.value = -12.h;
    toastController.storiesPosition.value = -80.h;
    // Preparing Home Page -- E n d --
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      children: [
        // Drawer -- S t a r t --
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                UotcColors.blueBold1.withOpacity(0.2),
                UotcColors.blueBold2.withOpacity(0.2),
              ]
            )
          ),
          child: Stack(
            children: [

              // Drawer Content -- S t a r t --
              Positioned(
                left: 0,
                child: SizedBox(
                  width: width / 2, height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Home Navigation Button -- S t a r t --
                      GestureDetector(
                        onTap: (){
                          if( !isPageHome ){
                            context.push('/lobby');
                          }
                          setState(() {
                            ignoringPointer = false;
                            isPageHome = true;
                            isPageProfile = false;
                            isPageSettings = false;
                          });
                          controller.reverse();
                        },
                        child: Container(
                          width: width/2,
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                      
                              SizedBox(
                                height: 20.sp, width: 20.sp,
                                child: SvgPicture.asset(isPageHome ? 'assets/svg/house-blank-solid.svg' : 'assets/svg/house-blank.svg', color: Colors.white)
                              ),
                      
                              SizedBox(width: 10.w),
                              
                              CustomText.createCustomElMessiriText(
                                text: LocaleKeys.home,
                                color: Colors.white,
                                align: TextAlign.center,
                                fontSize: 16,
                                screenHeight: height,
                              ).tr(),
                            ],
                          )
                        ),
                      ),
                      // Home Navigation Button -- E n d --
                      
                      // Profile Navigation Button -- S t a r t --
                      GestureDetector(
                        onTap: (){
                          if( !isPageProfile ){
                            context.push('/profile');
                          }
                          setState(() {
                            ignoringPointer = false;
                            isPageHome = false;
                            isPageProfile = true;
                            isPageSettings = false;
                          });
                          controller.reverse();
                        },
                        child: Container(
                          width: width/2,
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                      
                              SizedBox(
                                height: 20.sp, width: 20.sp,
                                child: SvgPicture.asset(isPageProfile ? 'assets/svg/user-solid.svg' : 'assets/svg/user.svg', color: Colors.white)
                              ),
                      
                              SizedBox(width: 10.w),
                              
                              CustomText.createCustomElMessiriText(
                                text: LocaleKeys.profile,
                                color: Colors.white,
                                align: TextAlign.center,
                                fontSize: 16,
                                screenHeight: height,
                              ).tr(),
                            ],
                          )
                        ),
                      ),
                      // Profile Navigation Button -- E n d --

                      // Setting Navigation Button -- S t a r t --
                      GestureDetector(
                        onTap: (){
                          if( !isPageSettings ){
                            context.push('/settings');
                          }
                          setState(() {
                            ignoringPointer = false;
                            isPageHome = false;
                            isPageProfile = false;
                            isPageSettings = true;
                          });
                          controller.reverse();
                        },
                        child: Container(
                          width: width/2,
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                      
                              SizedBox(
                                height: 20.sp, width: 20.sp,
                                child: SvgPicture.asset(isPageSettings ? 'assets/svg/settings-sliders-solid.svg' : 'assets/svg/settings-sliders.svg', color: Colors.white)
                              ),
                      
                              SizedBox(width: 10.w),
                              
                              CustomText.createCustomElMessiriText(
                                text: LocaleKeys.settings,
                                color: Colors.white,
                                align: TextAlign.center,
                                fontSize: 16,
                                screenHeight: height,
                              ).tr(),
                            ],
                          )
                        ),
                      ),
                      // Setting Navigation Button -- E n d --
                    ],
                  ),
                ),
              ),
              // Drawer Content -- E n d --
            ],
          ),
        ),
        // Drawer -- E n d --

        // Main Content -- S t a r t --
        ScaleTransition(
          scale: sAnimation,
          child: SlideTransition(
            position: animation,
            child: Container( height: height, width: width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow( color: Colors.black, blurRadius: 30, spreadRadius: -20 )
                ]
              ),
              child: AnimatedBuilder( 
                animation: controller,
                builder: (context, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusAnimation.value),
                  child: GestureDetector(
                    onTap: () {
                      controller.reverse();
                      setState(() => ignoringPointer = false);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.black.withOpacity(1),
                      body: Stack(
                        children: [
                          // Main Lobby Page -- S t a r t --
                          IgnorePointer(
                            ignoring: ignoringPointer,
                            child: widget.myChild
                          ),
                          // Main Lobby Page -- E n d --

                          // Show Drawer Button -- S t a r t --
                          Obx(() => AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubicEmphasized,
                            top: toastController.navMenuButtonPosition.value,
                            child: SizedBox(
                              width: width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.forward();
                                      setState(() => ignoringPointer = true);
                                    },
                                    icon: const Icon(Icons.menu_rounded, color: Colors.white)
                                  ),
                                ],
                              ),
                            ),
                          )),
                          // Show Drawer Button -- E n d --
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Main Content -- E n d --

        // User Status Bar -- S t a r t --
        Obx(() => AnimatedPositioned(
          duration: const Duration(milliseconds: 2800),
          curve: Curves.easeInOutCubicEmphasized,
          bottom: toastController.statusBarPosition.value,
          child: FittedBox(
            child: Container(
              height: 15.h, width: width,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Messages -- S t a r t --
                  SizedBox(child: Row(children: [
                    SvgPicture.asset('assets/svg/envelope.svg', color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: CustomText.createCustomTajawalText(
                        text: "AbuAlhassan (2)",
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.bold,
                        screenHeight: height
                      ),
                    ),
                  ])),
                  // Messages -- E n d --

                  SizedBox(width: 10.w,),

                  // Followers -- S t a r t --
                  SizedBox(child: Row(children: [
                    SvgPicture.asset('assets/svg/user.svg', color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: CustomText.createCustomTajawalText(
                        text: "21K",
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.bold,
                        screenHeight: height
                      ),
                    ),
                  ])),
                  // Followers -- E n d --

                  SizedBox(width: 10.w,),

                  // Posts -- S t a r t --
                  SizedBox(child: Row(children: [
                    SvgPicture.asset('assets/svg/picture.svg', color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: CustomText.createCustomTajawalText(
                        text: "21K",
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.bold,
                        screenHeight: height
                      ),
                    ),
                  ])),
                  // Posts -- E n d --
                  
                  SizedBox(width: 10.w,),

                  // Rates -- S t a r t --
                  SizedBox(child: Row(children: [
                    SvgPicture.asset('assets/svg/angle-small-down.svg', color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: CustomText.createCustomTajawalText(
                        text: "3K",
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.bold,
                        screenHeight: height
                      ),
                    ),
                    
                    SvgPicture.asset('assets/svg/angle-small-up.svg', color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: CustomText.createCustomTajawalText(
                        text: "500",
                        color: Colors.white,
                        fontSize: 12,
                        weight: FontWeight.bold,
                        screenHeight: height
                      ),
                    ),
                  ])),
                  // Rates -- E n d --
                ],
              ),
            ),
          ),
        ),)
        // User Status Bar -- E n d --
      ],
    );
  }
}