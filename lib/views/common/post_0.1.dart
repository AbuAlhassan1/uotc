import 'dart:developer';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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

    return Stack(
      key: PageStorageKey<int>(widget.postIndex),
      children: [
        Container(
          height: height,
          padding: EdgeInsets.only(bottom: 20.h),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(0.sp)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Post Header -- S t a r t --
              Expanded(
                child: Stack(
                  children: [

                    // Images Slider -- S t a r t --
                    SizedBox(
                      child: PageView.builder(
                        controller: imageSliderController,
                        itemCount: 5,
                        onPageChanged: (index) => setState(() => imageIndex = index),
                        itemBuilder: (context, index) {

                          return Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.sp)
                            ),
                            child: ImageFade(
                              fit: BoxFit.cover,
                              image: const AssetImage('assets/jpg/study_one.jpg'),
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

                    // Index Pointer -- S t a r t --
                    imageIndex != null ?
                    Align(
                      alignment: const Alignment(0, 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: SizedBox(
                              width: 100.w,
                              child: sliderIndex(
                                index: imageIndex!,
                                indexColor: Colors.blue,
                                otherColor: Colors.black.withOpacity(0.6),
                                numOfPages: 5,
                                size: 7.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : const SizedBox(),
                    // Index Pointer -- E n d --
                    
                    // Avatar [ Post Auther Image ] -- S t a r t --
                    Align(
                      alignment: const Alignment(0, 1.2),
                      child: GestureDetector(
                        onTap: () => context.go('/lobby/profile'),
                        child: Container(
                          padding: EdgeInsets.all(5.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black
                              )
                            ]
                          ),
                          child: CircleAvatar(
                            radius: 30.sp,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('assets/png/avatar.jpg', fit: BoxFit.cover,)
                            ),
                          ),
                        ),
                      )
                    ),
                    // Avatar [ Post Auther Image ] -- E n d --
                  ],
                )
              ),
              // Post Header -- E n d --

              // Post Info Section -- S t a r t --
              Expanded(
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Title -- S t a r t --
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                        child: CustomText.createCustomElMessiriText(
                          text: 'مجرد كتابة لتجربة الشكل',
                          align: TextAlign.start,
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.visible,
                          weight: FontWeight.bold,
                          maxLines: 2
                        ).tr(),
                      ),
                      // Post Title -- E n d --

                      // Post Description -- S t a r t --
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                        child: CustomText.createCustomTajawalText(
                          text: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة",
                          align: TextAlign.start,
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.visible,
                          weight: FontWeight.w300,
                          maxLines: 3
                        ).tr(),
                      ),
                      // Post Description -- E n d --

                      // Post Comments -- S t a r t --
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                            10,
                            (index) => const CommentCard()
                          ),
                        ),
                      ),
                      // Post Comments -- E n d --
                    ],
                  ),
                ),
              ),
              // Post Info Section -- E n d --

              // Post Interaction Bar -- S t a r t --
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 35.sp, width: 35.sp,
                      color: Colors.transparent,
                      child: SvgPicture.asset('assets/svg/heart_solid.svg', color: Colors.red,),
                    ),
                    SizedBox(width: 5.w,),
                    CustomText.createCustomTajawalText(
                      text: "( 16 )",
                      align: TextAlign.start,
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w400,
                      maxLines: 3
                    ).tr(),
                    SizedBox(width: 15.w,),
                    Container(
                      height: 30.sp, width: 30.sp,
                      color: Colors.transparent,
                      child: SvgPicture.asset('assets/svg/paper-plane.svg', color: Colors.white,),
                    ),

                    // Expanded(
                    //   child: AvoidKeyboard(
                    //     child: MyTextField(
                    //       focusNode: commentFocusNode,
                    //       hint: 'تعليق',
                    //       isPassword: false,
                    //       margin: EdgeInsets.symmetric(horizontal: 10.w),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
              // Post Interaction Bar -- E n d --
            ],
          ),
        ),
      ],
    );
  }
}