import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), reverseDuration: const Duration(milliseconds: 300));
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.5, 0)).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));
    sAnimation = Tween<double>(begin: 1, end: 0.9).animate(controller);
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
          color: UotcColors.blueBold3,
          child: Column( crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  setState(() {
                    context.push('/lobby');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("h o m e", style: TextStyle(color: Colors.white),),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    context.push('/settings');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("s e t t i n g s", style: TextStyle(color: Colors.white),),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    context.push('/details');
                    ignoringPointer = false;
                  });
                  controller.reverse();
                },
                child: const Text("d e t a i l s", style: TextStyle(color: Colors.white),),
              ),
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
                      ).tr(),
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