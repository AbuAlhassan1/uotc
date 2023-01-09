import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText {

  static Text createCustomElMessiriText(
    {
      required String text,
      required Color color,
      required double fontSize,
      required TextOverflow overflow,
      required TextAlign align,
      required FontWeight weight,
      required double screenHeight,
      int? maxLines
    }
  ){
    final maxL = maxLines ?? 1;
    return Text(
      text,
      textAlign: align,
      maxLines: maxL,
      style: GoogleFonts.elMessiri(
        textStyle: TextStyle(
          color: color,
          fontSize: screenHeight < 600 ? fontSize.sp * 0.8 : fontSize.sp,
          overflow: overflow,
          fontWeight: weight
        )
      ),
    );
  }
  
  static Text createCustomTajawalText(
    {
      required String text,
      required double fontSize,
      Color color = Colors.black,
      TextOverflow overflow = TextOverflow.visible,
      TextAlign align = TextAlign.start,
      FontWeight weight = FontWeight.normal,
      required double screenHeight,
      int? maxLines
    }
  ){
    final maxL = maxLines ?? 1;
    return Text(
      text,
      textAlign: align,
      maxLines: maxL,
      style: GoogleFonts.tajawal(
        textStyle: TextStyle(
          color: color,
          fontSize: screenHeight < 600 ? fontSize.sp * 0.8 : fontSize.sp,
          overflow: overflow,
          fontWeight: weight
        )
      ),
    );
  }

  static TextStyle createCustomTajawalTextStyle(
    {
      required double fontSize,
      Color color = Colors.black,
      TextOverflow overflow = TextOverflow.visible,
      FontWeight weight = FontWeight.normal,
    }
  ){

    return GoogleFonts.tajawal(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        overflow: overflow,
        fontWeight: weight
      )
    );
  }

  static TextStyle createCustomElMessiriTextStyle(
    {
      required double fontSize,
      Color color = Colors.black,
      TextOverflow overflow = TextOverflow.visible,
      FontWeight weight = FontWeight.normal,
    }
  ){

    return GoogleFonts.elMessiri(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        overflow: overflow,
        fontWeight: weight
      )
    );
  }

}