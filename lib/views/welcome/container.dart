import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uotc/views/welcome/welcome_to_uot.dart';
import '../../translations/locale_keys.g.dart';
import '../common/custom_text.dart';
import '../common/index_pointer.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import '../common/scroll_behavior.dart';
import 'make_new_friends.dart';
import 'make_unforgettable_memories.dart';
import 'put_your_mark.dart';
import 'share_your_moments.dart';

class WelcomeScreenContainer extends StatefulWidget {
  const WelcomeScreenContainer({super.key});

  @override
  State<WelcomeScreenContainer> createState() => _WelcomeScreenContainerState();
}

class _WelcomeScreenContainerState extends State<WelcomeScreenContainer> {

  final PageController pageViewController = PageController(keepPage: true);
  double screenWidth = (window.physicalSize.shortestSide / window.devicePixelRatio);
  double screenHeight = (window.physicalSize.longestSide / window.devicePixelRatio);
  late double top;
  double skipButtonPosition = 0;
  double rotation = 0;
  int index = 0;
  String text = LocaleKeys.welcomeToUniversityOfTechnology;
  List<Color> colors = [
    Colors.pink.withOpacity(0.05),
    Colors.pink.withOpacity(0.06),
    Colors.pink.withOpacity(0.05),
    Colors.pink.withOpacity(0.06),
    Colors.pink.withOpacity(0.05),
  ];
  List<Widget> pages = [
    const WelcomeToUOT(),
    const MakeNewFriends(),
    const PutYourMark(),
    const MakeUnforgettableMemories(),
    const ShareYourMoments(),
  ];

  @override
  void initState() {

    top = (0.5 / 5) * (screenHeight - 220.w);
    super.initState();
    pageViewController.addListener(() {
      skipButtonPosition = index == 4 ? -100 : 0;
      if( pageViewController.page != null ){
        top = ((pageViewController.page! + 0.5) / 5) * (screenHeight - 220.w);
        rotation = pageViewController.page! / 15;
        setState(() {});
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: ()async{
        log('welcome Screen');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [

            // Stars -- S t a r t --
            Opacity(
              opacity: 0.4,
              child: SizedBox(
                height: height,
                child: Image.asset('assets/gif/a8140c780ed7e3760838073796b5fe6f2.gif', fit: BoxFit.cover,)
              ),
            ),
            // Stars -- E n d --
            
            // Rive Stars Animation -- S t a r t --
            const Opacity(
              opacity: 0.5,
              child: RiveAnimation.asset('assets/rive/stars.riv', fit: BoxFit.cover,)
            ),
            // Rive Stars Animation -- E n d --

            // The Moon -- S t a r t --
            PositionedDirectional(
              bottom: top,
              start: 0, end: 0,
              child: SafeArea(
                child: IgnorePointer(
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOutCubicEmphasized,
                    turns: rotation,
                    child: Container(
                      color: Colors.transparent,
                      height: 200.w, width: 200.w,
                      child: Image.asset(
                        context.locale.languageCode == 'ar' ?
                        'assets/png/moon-ar.png'
                        : 'assets/png/moon-en.png'
                      )
                    ),
                  ),
                ),
              ),
            ),
            // The Moon -- E n d --

            // Main Content -- S t a r t --
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubicEmphasized,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerEnd,
                  end: AlignmentDirectional.centerStart,
                  colors: [
                    colors[index],
                    // Colors.blue.withOpacity(0.5),
                    Colors.transparent
                  ]
                )
              ),
              child: PageView.builder(
                scrollBehavior: MyBehavior(),
                controller: pageViewController,
                itemCount: 5,
                onPageChanged: (i) => setState(() {
                  index = i;
                  text = i % 2 == 0 ? LocaleKeys.welcomeToUniversityOfTechnology : LocaleKeys.enjoyStudyingOnUOTCampus;
                }),
                itemBuilder: (context, i) {
                  return pages[i];
                },
              ),
            ),
            // Main Content -- E n d --

            // Skip Button -- S t a r t --
            AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubicEmphasized,
              top: skipButtonPosition, end: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50.sp),
                      onTap: () => pageViewController.animateToPage(4, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubicEmphasized),
                      child: Container(
                        padding: EdgeInsets.all(15.sp),
                        child: CustomText.createCustomElMessiriText(
                          text: LocaleKeys.skip,
                          align: TextAlign.center,
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.visible,
                          weight: FontWeight.bold,
                          maxLines: 2,
                          screenHeight: height
                        ).tr(),
                      ),
                    )
                  ],
                ),
              )
            ),
            // Skip Button -- E n d --

            // Next & Back Button -- S t a r t --
            Align(
              alignment: const Alignment(0, 1),
              child: Container(
                width: width, height: 60,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                          onTap: () => pageViewController.previousPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubicEmphasized),
                          borderRadius: BorderRadius.circular(100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 20.w),
                                child: CustomText.createCustomElMessiriText(
                                  text: LocaleKeys.previous,
                                  align: TextAlign.center,
                                  color: Colors.white,
                                  fontSize: 20,
                                  overflow: TextOverflow.visible,
                                  weight: FontWeight.bold,
                                  maxLines: 2,
                                  screenHeight: height
                                ).tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: InkWell(
                          onTap: () {
                            index != 4 ?
                            pageViewController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubicEmphasized)
                            // : NavKeys.mainNavKey.currentState!.pushReplacementNamed('/register');
                            : context.go('/register');
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(end: 20.w),
                                child: CustomText.createCustomElMessiriText(
                                  text: index != 4 ? LocaleKeys.next : LocaleKeys.register,
                                  align: TextAlign.center,
                                  color: Colors.white,
                                  fontSize: 20,
                                  overflow: TextOverflow.visible,
                                  weight: FontWeight.bold,
                                  maxLines: 2,
                                  screenHeight: height
                                ).tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            // Next & Back Button -- E n d --

            // Index Indecator -- S t a r t --
            Align(
              alignment: const Alignment(0, 0.8),
              child: Container(
                width: width /3,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: -5
                    )
                  ]
                ),
                child: sliderIndex(
                  index: index,
                  indexColor: Colors.white.withOpacity(0.95),
                  numOfPages: 5,
                  otherColor: Colors.blueGrey.withOpacity(0.8),
                  size: 7.sp
                ),
              ),
            ),
            // Index Indecator -- E n d --
          ],
        )
      ),
    );
  }
}