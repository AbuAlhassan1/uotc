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
          fontSize: fontSize.sp,
          overflow: overflow,
          fontWeight: weight
        )
      ),
    );
  }
  
  static Text createCustomTajawalText(
    {
      required String text,
      required Color color,
      required double fontSize,
      required TextOverflow overflow,
      required TextAlign align,
      required FontWeight weight,
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
          fontSize: fontSize.sp,
          overflow: overflow,
          fontWeight: weight
        )
      ),
    );
  }

  static TextStyle createCustomTajawalTextStyle(
    {
      required Color color,
      required double fontSize,
      required TextOverflow overflow,
      required FontWeight weight,
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
      required Color color,
      required double fontSize,
      required TextOverflow overflow,
      required FontWeight weight,
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