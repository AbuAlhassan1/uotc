import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Stack(
      key: PageStorageKey<int>(widget.postIndex),
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: height,
            padding: EdgeInsets.only(bottom: 0.h),
            decoration: BoxDecoration(
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
                      Padding(
                        padding: EdgeInsets.only(bottom: 40.sp, top: 35.h),
                        child: SizedBox(
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
                                  borderRadius: BorderRadius.circular(5.sp)
                                ),
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
                      ),
                      // Images Slider -- E n d --
        
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
                                size: 7.sp
                              ),
                            ),
                          ],
                        ),
                      ) : const SizedBox(),
                      // Index Pointer -- E n d --
                      
                      // Avatar [ Post Auther Image ] -- S t a r t --
                      PositionedDirectional(
                        bottom: 0, start: 20.w,
                        child: GestureDetector(
                          onTap: () => context.go('/lobby/details'),
                          child: Container(
                            padding: EdgeInsets.all(5.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [ BoxShadow(color: UotcColors.blueBold3) ]
                            ),
                            child: CircleAvatar(
                              radius: 40.sp,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset('assets/jpg/223138735_4167662076620280_7307821253933789535_n (2).jpg', fit: BoxFit.cover,)
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
                Container(
                  width: width,
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                      // Post Description -- S t a r t --
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: CustomText.createCustomTajawalText(
                          text: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة",
                          align: TextAlign.start,
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.visible,
                          weight: FontWeight.w200,
                          maxLines: 3,
                          screenHeight: height
                        ).tr(),
                      ),
                      // Post Description -- E n d --
                      
                      // Tag[s] Section -- S t a r t --
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        color: Colors.transparent,
                        child: Wrap(
                          children: List.generate(
                            5,
                            (index) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
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
                      // Tag[s] Section -- E n d --
        
                      // Post Comments -- S t a r t --
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                            10,
                            (index) => const FittedBox(child: CommentCard())
                          ),
                        ),
                      ),
                      // Post Comments -- E n d --
                    ],
                  ),
                ),
                // Post Info Section -- E n d --

                // Add Comment TextField -- S t a r t --
                PostCommentTextField(
                  focusNode: commentFocusNode,
                  controller: TextEditingController(),
                  margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 20.h),
                ),
                // Add Comment TextField -- E n d --
              ],
            ),
          ),
        ),
      ],
    );
  }
}