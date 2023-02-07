import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uotc/controllers/post_controller.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/story_coin.dart';
import 'package:video_player/video_player.dart';
import '../controllers/toast_controller.dart';
import 'common/custom_text.dart';
import 'common/post_0.1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PostController postsController = Get.put(PostController());
  ToastStateController toastController = Get.find();
  final ScrollController postController = ScrollController();
  bool isStoriesHidden = false;
  double homeOpacity = 0;
  // late List videos;

  @override
  void initState(){
    super.initState();
    if(mounted){
      log("x"*100);
      postsController.loadInitPosts();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.bottom]);
      postController.addListener(() async {
        if( postController.offset < 10 ){
          toastController.showStories(-90.h);
        }else{
          toastController.hideStories(-90.h);
        }
      });
      Future.delayed(const Duration(milliseconds: 800), () => setState(() => homeOpacity = 1));
      Future.delayed(const Duration(seconds: 1), () => toastController.hideStories(-90.h));
      postsController.loadPostWithScrollEnd(postController);
    }
  }

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     log(postsController.posts.length.toString());
      //   },
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Home Page Main Content -- S t a r t --
            Obx(() =>
              postsController.isLoading.value ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.sp,
                ),
              ) :
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeIn,
                opacity: homeOpacity,
                child: SizedBox(
                  height: height, width: width,
                  child: ListView(
                    // physics: const BouncingScrollPhysics(),
                    controller: postController,
                    children: List.generate(postsController.posts.length + 1, (index) =>
                      index == 0 ? SizedBox(height: 50.h)
                      : PostOne(postData: postsController.posts[index-1]),
                      // : Postt(controller: postsController.posts[index-1],),
                    ) + [
                      postsController.isScrollLoading.value ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: SizedBox(
                            height: 20.sp, width: 20.sp,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.sp,
                            ),
                          ),
                        ),
                      ) : const SizedBox()
                    ],
                  ),
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
                  padding: EdgeInsetsDirectional.only(top: 5.h, bottom: 5.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 80.sp,
                        color: Colors.black,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) => const StoryCoin()
                        ),
                      ),
                      GestureDetector(
                        onTap: () => toastController.hideShowStories(-90.h),
                        child: Container(
                          width: width,
                          padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: 50.sp,
                                child: Icon(
                                  toastController.isStoriesHidden.value ?
                                  Icons.arrow_drop_down_rounded
                                  : Icons.arrow_drop_up_rounded,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
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
                                ),
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


class Postt extends StatefulWidget {
  const Postt({super.key, required this.controller});
  final Map controller;

  @override
  State<Postt> createState() => _PosttState();
}

class _PosttState extends State<Postt> {

  @override
  void initState() {
    super.initState();
    widget.controller["video"].play();
  }
  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Container(
      height: width, width: width,
      color: Colors.red,
      margin: EdgeInsets.only(bottom: 20.h),
      child: VideoPlayer(widget.controller["video"]),
    );
  }
}