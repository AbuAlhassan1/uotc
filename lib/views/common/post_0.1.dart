import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_fade/image_fade.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/comments_bottom_sheet.dart';
import 'comment_card.dart';
import 'custom_text.dart';
import 'index_pointer.dart';
import 'package:optimized_image_loader/optimized_image_loader.dart';

// showModalBottomSheet(context: context, builder: builder);

class PostOne extends StatefulWidget {
  const PostOne({
    super.key,
    required this.postIndex
  });
  final int postIndex;

  @override
  State<PostOne> createState() => _PostOneState();
}

class _PostOneState extends State<PostOne> {

  final PageController imageSliderController = PageController();
  int? imageIndex;
  final FocusNode commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => imageIndex = imageSliderController.page!.round());
    });
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
                  SizedBox(
                    height: 15.sp, width: 15.sp,
                    child: SvgPicture.asset('assets/svg/angle-small-down.svg', color: Colors.white),
                  )
                  // "More" Menu -- E n d --
                ],
              ),
            ),
            // Post Header -- E n d --

            // Images Slider -- S t a r t --
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: imageSliderController,
                    itemCount: 5,
                    onPageChanged: (index) => setState(() => imageIndex = index),
                    itemBuilder: (context, index) {
                      return Container(
                        width: width,
                        clipBehavior: Clip.antiAlias,
                        // margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(color: Colors.black),
                        // child: Image.asset("assets/jpg/${widget.postIndex+1}.jpg", fit: BoxFit.cover),
                        // child: OptimizedImageLoader(
                        //   loadingIndicator: CircularProgressIndicator(color: UotcColors.blueLight1,),
                        //   url: "https://storage.googleapis.com/uotc-20.appspot.com/uotc/images/post/2023-01-20_04-36-05_154.gif",
                        //   imageHeight: 0,
                        //   imageWidth: 0,
                        //   spinnerHeight: 30.sp,
                        //   spinnerWidth: 30.sp,
                        // ),
                        child: ImageFade(
                          fit: BoxFit.cover,
                          // image: AssetImage("assets/jpg/${widget.postIndex+1}.jpg"),
                          image: const NetworkImage("https://images.unsplash.com/photo-1674284623748-e2d3f89241ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                          loadingBuilder: (context, progress, chunkEvent) => Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: const CircularProgressIndicator(color: Colors.grey),
                            ),
                          ),
                          errorBuilder: (context, exception) => const Center(
                            child: Text("Something went wrong, Try again"),
                          ),
                        )
                      );
                    },
                  ),

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
                            numOfPages: 5,
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
            // Images Slider -- E n d --
    
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
}