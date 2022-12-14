import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sliderIndex({
  required int index,
  required int numOfPages,
  required double size,
  required Color indexColor,
  required Color otherColor
}){

  List<Widget> dots = [];

  for( int i = 0; i < numOfPages; i++ ){
    dots.add(
      Container(
        height: size, width: size, margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: index == i ? indexColor: otherColor, borderRadius: BorderRadius.circular(50)
        ),
      )
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: dots,
  );
}