import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/text_fields_and_buttons.dart';
import 'comment_card.dart';
import 'custom_text.dart';
import 'index_pointer.dart';
import 'package:image_fade/image_fade.dart';

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
        key: PageStorageKey<int>(widget.postIndex),
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
                        Container(
                          height: 40.sp, width: 40.sp,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Image.asset('assets/jpg/223138735_4167662076620280_7307821253933789535_n (2).jpg', fit: BoxFit.cover),
                        ),
                        // User Image -- E n d --

                        SizedBox(width: 10.w),

                        // User Name -- S t a r t --
                        CustomText.createCustomElMessiriText(
                          text: "حيدر يوسف",
                          fontSize: 16,
                          screenHeight: height,
                          color: Colors.white,
                          weight: FontWeight.bold
                        )
                        // User Name -- E n d --
                      ],
                    ),
                  ),
                  // User Image & Name -- E n d --

                  // "More" Menu -- S t a r t --
                  SizedBox(
                    height: 20.sp, width: 20.sp,
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
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: imageSliderController,
                itemCount: 5,
                onPageChanged: (index) => setState(() => imageIndex = index),
                itemBuilder: (context, index) {
                  return Container(
                    width: width,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: ImageFade(
                      fit: BoxFit.cover,
                      image: const AssetImage('assets/jpg/275246698_643562353599990_4357863837767632622_n.jpg'),
                      loadingBuilder: (context, progress, chunkEvent) => Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: const CircularProgressIndicator(color: Colors.grey),
                        )
                      ),
                    )
                  );
                },
              ),
            ),
            // Images Slider -- E n d --
    
            // Post Info Section -- S t a r t --
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag[s] Section -- S t a r t --
                  Container(
                    width: width,
                    padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
                    margin: EdgeInsets.only(bottom: 10.h,),
                    decoration: BoxDecoration(
                      border: Border(
                        // top: BorderSide(
                        //   color: UotcColors.blueBold2,
                        //   width: 2.h
                        // ),
                        bottom: BorderSide(
                          color: UotcColors.blueBold2,
                          width: 2.h
                        ),
                      )
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          25,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(1),
                                width: 0.5
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: CustomText.createCustomTajawalText(
                                text: ' $indexسفرة',
                                align: TextAlign.start,
                                color: Colors.white,
                                fontSize: 13,
                                overflow: TextOverflow.visible,
                                weight: FontWeight.w300,
                                maxLines: 2,
                                screenHeight: height
                              ).tr(),
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                  // Tag[s] Section -- E n d --

                  // Accessbility Bar -- S t a r t --
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.w, end: 15.w, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/heart_solid.svg', color: Colors.red),
                            SizedBox(width: 15.w,),
                            SvgPicture.asset('assets/svg/paper-plane.svg', color: Colors.white),
                            SizedBox(width: 15.w,),
                            SvgPicture.asset('assets/svg/comment.svg', color: Colors.white),
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
                    ).tr(),
                  ),
                  // Post Description -- E n d --

                  // Date & Time -- S t a r t --
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        CustomText.createCustomElMessiriText(
                          text: 'قبل ثلاث اسابيع',
                          color: UotcColors.blueLight2,
                          fontSize: 12,
                          screenHeight: height
                        )
                      ],
                    ),
                  )
                  // Date & Time -- E n d --
    
                  // // Post Comments -- S t a r t --
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   physics: const BouncingScrollPhysics(),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: List.generate(
                  //       10,
                  //       (index) => const FittedBox(child: CommentCard())
                  //     ),
                  //   ),
                  // ),
                  // // Post Comments -- E n d --
                ],
              ),
            ),
            // Post Info Section -- E n d --

            // // Add Comment TextField -- S t a r t --
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10.h),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 50,
            //         // color: Color(0xFF1a1a1a),
            //         padding: EdgeInsetsDirectional.only(start: 10.w, bottom: 10.h),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             SvgPicture.asset('assets/svg/heart_solid.svg', color: Colors.red,),
            //             SizedBox(width: 15.w,),
            //             SvgPicture.asset('assets/svg/paper-plane.svg', color: Colors.white,),
            //             SizedBox(width: 15.w,),
            //             SvgPicture.asset('assets/svg/bookmark.svg', color: Colors.white,),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //         child: PostCommentTextField(
            //           focusNode: commentFocusNode,
            //           controller: TextEditingController(),
            //           margin: EdgeInsetsDirectional.only(top: 10.h, end: 10.w, start: 10.w, bottom: 20.h),
            //         ),
            //       )
            //     ],
            //   ),
            // )
            // // Add Comment TextField -- E n d --

            // // Index Pointer -- S t a r t --
            // imageIndex != null ?
            // Positioned(
            //   bottom: 15.h, left: 0, right: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         color: Colors.transparent,
            //         padding: EdgeInsets.symmetric(horizontal: 30.w),
            //         child: sliderIndex(
            //           index: imageIndex!,
            //           indexColor: Colors.white,
            //           otherColor: UotcColors.blueBold1,
            //           numOfPages: 5,
            //           size: 5.sp
            //         ),
            //       ),
            //     ],
            //   ),
            // ) : const SizedBox(),
            // // Index Pointer -- E n d --
          ],
        ),
      ),
    );
  }
}