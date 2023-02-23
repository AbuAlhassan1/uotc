import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uotc/controllers/post_controller.dart';
import 'package:uotc/views/common/story_coin.dart';
import 'package:video_player/video_player.dart';
import '../controllers/toast_controller.dart';
import 'common/custom_text.dart';
import 'common/post_0.1.dart';
import 'package:chewie/chewie.dart';

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
  List videos = [1, 2, 3];
  int index = 3;

  @override
  void initState(){
    super.initState();
    if(mounted){
      log("x"*100);
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
      postController.addListener(() {
        if(postController.position.atEdge && postController.offset != 0){
          videos.add(index);
          log("Video Added");
          setState(() {});
          index++;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log(postsController.posts.length.toString());
        },
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
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
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: postController,
                  children: List.generate(
                    videos.length,
                    (index) =>
                      index == 0 ? SizedBox(height: 50.h)
                      : Postt(index: index)
                  )
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
  const Postt({super.key, required this.index});
  final int index;
  @override
  State<Postt> createState() => _PosttState();
}

class _PosttState extends State<Postt> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network("https://player.vimeo.com/external/457605632.sd.mp4?s=b9714bb7474ed44b097c9d5cb6614f07c9e6a6d7&profile_id=164&oauth2_token_id=57447761");
    try{
      controller.initialize().then((value) {
        controller.play();
      });
    }
    catch(error){
      log(error.toString());
    }
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
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
      child: Stack(
        children: [
          VideoPlayer(controller),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: Text(widget.index.toString()),
            ),
          )
        ],
      ),
    );
  }
}