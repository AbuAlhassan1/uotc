import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/views/welcome/welcome_to_uot.dart';
import '../../translations/locale_keys.g.dart';
import '../common/custom_text.dart';
import '../common/index_pointer.dart';
import 'package:rive/rive.dart';

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

  final PageController pageViewController = PageController(
    keepPage: true
  );

  double top = 50;
  double rotation = 0;
  int index = 0;

  String text = LocaleKeys.welcomeToUniversityOfTechnology;

  List<Color> colors = [
    Colors.blue.withOpacity(0.5),
    Colors.blueGrey.withOpacity(0.5),
    Colors.brown.withOpacity(0.5),
    Colors.pink.shade200.withOpacity(0.5),
    Colors.deepPurpleAccent.withOpacity(0.5),
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
    super.initState();
    pageViewController.addListener(() {
      if( pageViewController.page != null ){
        top = ((pageViewController.page! * 110) + 50).h ;
        rotation = pageViewController.page! / 15;
        setState(() {
          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Stars -- S t a r t --
          const Opacity(
            opacity: 0.5,
            child: RiveAnimation.asset('assets/rive/stars.riv', fit: BoxFit.cover,)
          ),
          // Stars -- E n d --

          // The Moon -- S t a r t --
          PositionedDirectional(
            bottom: top,
            start: (width/2) - 100.w,
            child: SafeArea(
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOutCubicEmphasized,
                turns: rotation,
                child: Container(
                  color: Colors.transparent,
                  height: 200.w, width: 200.w,
                  child: SvgPicture.asset('assets/svg/moon.svg',)
                ),
              ),
            ),
          ),
          // The Moon -- E n d --

          // Main Content -- S t a r t --
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubicEmphasized,
            color: colors[index],
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

          // Next & Back Button -- S t a r t --
          Align(
            alignment: const Alignment(0, 0.95),
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => pageViewController.previousPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubicEmphasized),
                    child: CustomText.createCustomElMessiriText(
                      text: LocaleKeys.previous,
                      align: TextAlign.center,
                      color: Colors.white,
                      fontSize: 16,
                      overflow: TextOverflow.visible,
                      weight: FontWeight.bold,
                      maxLines: 2
                    ).tr(),
                  ),
                  TextButton(
                    onPressed: () => pageViewController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubicEmphasized),
                    child: CustomText.createCustomElMessiriText(
                      text: index != 4 ? LocaleKeys.next : LocaleKeys.register,
                      align: TextAlign.center,
                      color: Colors.white,
                      fontSize: 16,
                      overflow: TextOverflow.visible,
                      weight: FontWeight.bold,
                      maxLines: 2
                    ).tr(),
                  ),
                ],
              )
            ),
          ),
          // Next & Back Button -- E n d --

          // Index Indecator -- S t a r t --
          Align(
            alignment: const Alignment(0, 0.92),
            child: Container(
              width: width,
              color: Colors.transparent,
              child: sliderIndex(
                index: index,
                indexColor: Colors.white,
                numOfPages: 5,
                otherColor: Colors.grey.withOpacity(0.2),
                size: 5.sp
              ),
            ),
          )
          // Index Indecator -- E n d --
        
        ],
      )
    );
  }
}