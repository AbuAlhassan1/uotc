import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';
import 'index_pointer.dart';

class PostOne extends StatefulWidget {
  const PostOne({super.key,});

  @override
  State<PostOne> createState() => _PostOneState();
}

class _PostOneState extends State<PostOne> {
  final PageController ImageSliderController = PageController();

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {

    // Variables -- S t a r t --
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Variables -- E n d --

    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50.sp)
          ),
          child: Column(
            children: [
              // Post Header -- S t a r t --
              Expanded(
                child: Stack(
                  children: [

                    // Images Slider -- S t a r t --
                    SizedBox(
                      child: PageView.builder(
                        controller: ImageSliderController,
                        itemCount: 5,
                        onPageChanged: (index) => setState(() => imageIndex = index),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.sp)
                            ),
                            child: Image.asset('assets/jpg/study_one.jpg', fit: BoxFit.cover,),
                          );
                        },
                      ),
                    ),
                    // Images Slider -- E n d --

                    // Index Pointer -- S t a r t --
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
                                index: imageIndex,
                                indexColor: Colors.blue,
                                otherColor: Colors.black.withOpacity(0.6),
                                numOfPages: 5,
                                size: 7.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Index Pointer -- E n d --
                    
                    // Avatar [ Post Auther Image ] -- S t a r t --
                    Align(
                      alignment: const Alignment(0, 1.2),
                      child: Container(
                        padding: EdgeInsets.all(5.h),
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
                        ),
                      )
                    ),
                    // Avatar [ Post Auther Image ] -- E n d --
                  ],
                )
              ),
              // Post Header -- E n d --

              // Post Description -- S t a r t --
              Expanded(
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.createCustomElMessiriText(
                        text: 'مجرد كتابة لتجربة الشكل',
                        align: TextAlign.start,
                        color: Colors.white,
                        fontSize: 20,
                        overflow: TextOverflow.visible,
                        weight: FontWeight.bold,
                        maxLines: 2
                      ).tr()
                    ],
                  ),
                ),
              ),
              // Post Description -- E n d --
            ],
          ),
        ),
      ],
    );
  }
}