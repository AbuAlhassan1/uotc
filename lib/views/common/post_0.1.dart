import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uotc/controllers/post_controller.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/comments_bottom_sheet.dart';
import 'package:video_player/video_player.dart';
import 'comment_card.dart';
import 'custom_text.dart';
import 'index_pointer.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:optimized_image_loader/optimized_image_loader.dart';

class PostOne extends StatefulWidget {
  const PostOne({
    super.key,
    required this.postData
  });
  final Map postData;

  @override
  State<PostOne> createState() => _PostOneState();
}

class _PostOneState extends State<PostOne> with AutomaticKeepAliveClientMixin {

  PostController postsController = Get.find();
  final PageController imageSliderController = PageController();
  int? imageIndex;
  int videoIndex = 0;
  final FocusNode commentFocusNode = FocusNode();
  bool isVideoLoading = true;
  double videoHeight = 0;
  double videoWidth = 0;
  bool isVideoPlaying = false;
  double playPauseButtonOpacity = 0;

  @override
  void initState() {
    super.initState();
    if(widget.postData["type"][0] == "video"){
      if(mounted){
        for(VideoPlayerController videoController in widget.postData["video"]){
          setState(() {
            videoController.play();
            isVideoPlaying = true;
            isVideoLoading = false;
            videoHeight = videoController.value.size.height;
            videoWidth = videoController.value.size.width;
            playPauseButtonOpacity = 1;
          });
          Future.delayed(const Duration(seconds: 1), () => videoController.play());
          videoController.addListener(() {
            if( !widget.postData["video"][0].value.isPlaying ){
              setState(() => playPauseButtonOpacity = 1);
            }
          });
        }
      }
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => imageIndex = imageSliderController.page!.round());
      });
    }
  }

  @override
  void dispose() {
    if(widget.postData["type"][0] == "video"){
      for(VideoPlayerController videoController in widget.postData["video"]){
        videoController.pause();
        videoController.removeListener(() {});
      }
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        // key: PageStorageKey<int>(widget.postIndex),
        margin: EdgeInsets.only(bottom: 15.h),
        // clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Post Header -- S t a r t --
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User Image & Name -- S t a r t --
                  SizedBox(
                    child: Row(
                      children: [
                        // User Image -- S t a r t --
                        GestureDetector(
                          onTap: () => buildSmallProfileBottomSheet(context, height),
                          child: SizedBox(
                            height: 45.sp, width: 45.sp,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(45)
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 40.sp, width: 40.sp,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Image.asset('assets/jpg/1.jpg', fit: BoxFit.cover),
                                  ),
                                ),
                        
                                // User Role -- S t a r t --
                                Align(
                                  alignment: const AlignmentDirectional(1.2, 1.2),
                                  child: Container(
                                    height: 17.sp, width: 17.sp,
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
                            ),
                          ),
                        ),
                        // User Image -- E n d --

                        SizedBox(width: 10.w),

                        // User Name -- S t a r t --
                        CustomText.createCustomElMessiriText(
                          text: "حيدر يوسف",
                          fontSize: 14,
                          screenHeight: height,
                          color: Colors.white,
                          weight: FontWeight.bold
                        ),
                        // User Name -- E n d --
                      ],
                    ),
                  ),
                  // User Image & Name -- E n d --
                  
                  // "More" Menu -- S t a r t --
                  GestureDetector(
                    onTapDown: (details) => 
                    showMenu(
                      context: context,
                      position: RelativeRect.fromSize(Rect.fromLTWH(-100, details.globalPosition.dy, 0, 200), Size(details.localPosition.dx, details.localPosition.dy)),
                      items: [
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                        PopupMenuItem(child: CustomText.createCustomElMessiriText(color: Colors.white, text: 'One', fontSize: 14, screenHeight: height)),
                      ],
                      constraints: BoxConstraints(
                        maxHeight: 200.h,
                        minWidth: width / 2,
                        maxWidth: width / 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp)
                      ),
                      elevation: 10,
                      color: UotcColors.blueBold2
                    ),
                    child: SizedBox(
                      height: 15.sp, width: 15.sp,
                      child: SvgPicture.asset('assets/svg/angle-small-down.svg', color: Colors.white),
                    ),
                  )
                  // "More" Menu -- E n d --
                ],
              ),
            ),
            // Post Header -- E n d --

            // Images Slider || Video -- S t a r t --
            widget.postData["type"][0] == "video" ?
            GestureDetector(
              onTap: () {
                setState(() => playPauseButtonOpacity = 1);
                Future.delayed(const Duration(seconds: 2), () => setState(() => playPauseButtonOpacity = 0));
              },
              child: SizedBox(
                height: height - 100.h, width: width,
                child: Stack(
                  children: [
                    // Loading Indicator -- S t a r t --
                    Container(
                      color: const Color(0xFF101010),
                      child: Center(
                        child: videoHeight == 0 ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1.sp) : const SizedBox(),
                      ),
                    ),
                    // Loading Indicator -- E n d --

                    // Video Player -- S t a r t --
                    PinchZoom(
                      maxScale: 4,
                      zoomEnabled: true,
                      // child: FittedBox(
                      //             fit: BoxFit.cover,
                      //             child: SizedBox(
                      //               height: videoHeight,
                      //               width: videoWidth,
                      //               child: VideoPlayer(widget.postData["video"][0])
                      //             ),
                      //           ),
                      child: PageView(
                        onPageChanged: (index) => setState(() => videoIndex = index),
                        children: List.generate(widget.postData["video"].length, (index) =>
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                              // opacity: videoHeight == 0 ? 0 : 1,
                              opacity: 1,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                                width: width,
                                height: videoHeight == 0 ? width : videoHeight > height - 100.h ? height - 100.h : videoHeight,
                                decoration: const BoxDecoration(color: Colors.red),
                                child:
                                // videoHeight == 0 ? 
                                // const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1))
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    height: widget.postData["video"][index].value.size.height,
                                    width: widget.postData["video"][index].value.size.width,
                                    child: VideoPlayer(widget.postData["video"][index])
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Video Player -- E n d --
            
                    // Play - Pause Button -- S t a r t --
                    videoHeight == 0 ? const SizedBox() :
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      opacity: playPauseButtonOpacity,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            if(isVideoPlaying){ widget.postData["video"][videoIndex].pause();}
                              else{ 
                              widget.postData["video"][videoIndex].play();
                              await Future.delayed(const Duration(milliseconds: 100), () => widget.postData["video"][videoIndex].play(),);
                            }
                            isVideoPlaying = !isVideoPlaying;
                            await Future.delayed(const Duration(seconds: 2), () => playPauseButtonOpacity = 0);
                            setState((){});
                          },
                          child: Container(
                            height: 50.sp, width: 50.sp,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(50.sp)
                            ),
                            child: Center(
                              child: Icon(widget.postData["video"][videoIndex].value.isPlaying ? Icons.pause_outlined : Icons.play_arrow_rounded, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Play - Pause Button -- E n d --

                    // Mute - Unmute Button -- S t a r t --
                    videoHeight == 0 ? const SizedBox() :
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      opacity: 1,
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if(widget.postData["video"][videoIndex].value.volume == 0){
                                widget.postData["video"][videoIndex].setVolume(1.0);
                              }else if(widget.postData["video"][videoIndex].value.volume == 1){
                                widget.postData["video"][videoIndex].setVolume(0.0);
                              }
                            });
                          },
                          child: Container(
                            height: 30.sp, width: 30.sp,
                            margin: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(50.sp)
                            ),
                            child: Center(
                              child: Icon(widget.postData["video"][videoIndex].value.volume == 1 ? Icons.volume_up_rounded : Icons.volume_off_rounded, color: Colors.white, size: 18.sp,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Mute - Unmute Button -- E n d --

                    // Index Inicator -- S t a r t --
                    Align(
                      alignment: const Alignment(0, 0.95),
                      child: sliderIndex(
                        index: videoIndex,
                        indexColor: Colors.white,
                        otherColor: UotcColors.blueBold1,
                        numOfPages: widget.postData["video"].length,
                        size: 5.sp
                      ),
                    ),
                    // Index Inicator -- E n d --
                  ],
                ),
              ),
            ) :
            SizedBox(
              width: width, height: width,
              child: Stack(
                children: [
                  // Image Viewer -- S t a r t --
                  PinchZoom(
                    maxScale: 4,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: imageSliderController,
                      itemCount: widget.postData["video"].length,
                      onPageChanged: (index) => setState(() => imageIndex = index),
                      itemBuilder: (context, index) {
                        return Container(
                          width: width,
                          // clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(color: Color(0xFF101010)),
                          child: widget.postData["video"][index],
                          // child: OptimizedImageLoader(
                          //   loadingIndicator: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.sp),
                          //   url: widget.postData["data"][index],
                          //   imageHeight: double.infinity,
                          //   imageWidth: double.infinity,
                          //   spinnerHeight: 30.sp,
                          //   spinnerWidth: 30.sp,
                          // ),
                        );
                      },
                    ),
                  ),
                  // Image Viewer -- E n d --
              
                  // Layers Icon -- S t a r t --
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      height: 20.sp, width: 20.sp,
                      margin: EdgeInsets.all(10.sp),
                      child: SvgPicture.asset('assets/svg/layers.svg', color: Colors.white.withOpacity(0.8))
                    ),
                  ),
                  // Layers Icon -- E n d --
              
                  // Index Pointer -- S t a r t --
                  imageIndex != null ?
                  Positioned(
                    bottom: 15.h, left: 0, right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: sliderIndex(
                            index: imageIndex!,
                            indexColor: Colors.white,
                            otherColor: UotcColors.blueBold1,
                            numOfPages: widget.postData["video"].length,
                            size: 5.sp
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox(),
                  // Index Pointer -- E n d --
                ],
              ),
            ),
            // Images Slider || Video -- E n d --
    
            // Post Info Section -- S t a r t --
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // // Tag[s] Section -- S t a r t --
                  // Container(
                  //   width: width,
                  //   padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
                  //   margin: EdgeInsets.only(bottom: 10.h,),
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       bottom: BorderSide(
                  //         color: UotcColors.blueBold2,
                  //         width: 2.h
                  //       ),
                  //     )
                  //   ),
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     physics: const BouncingScrollPhysics(),
                  //     child: Row(
                  //       children: List.generate(
                  //         25,
                  //         (index) => Container(
                  //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //           margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  //           child: Padding(
                  //             padding: EdgeInsets.only(top: 2.h),
                  //             child: CustomText.createCustomElMessiriText(
                  //               text: ' $indexسفرة',
                  //               color: Colors.white,
                  //               fontSize: 13,
                  //               screenHeight: height,
                  //               decoration: TextDecoration.underline
                  //             ),
                  //           ),
                  //         )
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // // Tag[s] Section -- E n d --

                  // Accessbility Bar -- S t a r t --
                  Container(
                    height: 30.h,
                    padding: EdgeInsetsDirectional.only(start: 15.w, end: 15.w, bottom: 10.h,),
                    margin: EdgeInsetsDirectional.only(top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/heart_solid.svg', color: Colors.red),
                            SizedBox(width: 10.w,),
                            SvgPicture.asset('assets/svg/paper-plane.svg', color: Colors.white),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: () => buildCommentsAsBottomSheet(context),
                              child: SvgPicture.asset('assets/svg/comment.svg', color: Colors.white),
                            ),
                          ],
                        ),

                        SvgPicture.asset('assets/svg/bookmark.svg', color: Colors.white),
                      ],
                    ),
                  ),
                  // Accessbility Bar -- E n d --

                  // Post Description -- S t a r t --
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: CustomText.createCustomTajawalText(
                      text: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة",
                      color: Colors.white,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w200,
                      maxLines: 2,
                      screenHeight: height
                    ),
                  ),
                  // Post Description -- E n d --
    
                  // Post Comments -- S t a r t --
                  Container(
                    height: 55.h,
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(
                        10,
                        (index) => FittedBox(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: index == 9 ? 15.w : 0,),
                            child: GestureDetector(
                              onTap: () => buildCommentsAsBottomSheet(context),
                              child: CommentCard(margin: EdgeInsetsDirectional.only(start: 15.w),)
                            ),
                          )
                        )
                      ),
                    ),
                  ),
                  // Post Comments -- E n d --

                  // Date & Time -- S t a r t --
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        CustomText.createCustomElMessiriText(
                          text: 'قبل ثلاث اسابيع',
                          color: UotcColors.blueLight2,
                          fontSize: 10,
                          screenHeight: height
                        ),
                        CustomText.createCustomElMessiriText(
                          text: ' . ',
                          color: UotcColors.blueLight2,
                          fontSize: 12,
                          screenHeight: height
                        ),
                        CustomText.createCustomElMessiriText(
                          text: '2023-3-2',
                          color: UotcColors.blueLight2,
                          fontSize: 10,
                          screenHeight: height
                        ),
                      ],
                    ),
                  ),
                  // Date & Time -- E n d --
                ],
              ),
            ),
            // Post Info Section -- E n d --
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}