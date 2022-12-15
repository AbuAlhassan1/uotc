// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/views/common/custom_text.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    required this.hint,
    this.isPassword,
    super.key,
  });
  
  final String hint;
  final bool? isPassword;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  late bool obscureText;
  
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width/1.5,
      child: TextField(
        obscureText: obscureText,
        style: CustomText.createCustomTajawalTextStyle(
          color: Colors.white,
          fontSize: 14,
          overflow: TextOverflow.visible,
          weight: FontWeight.normal
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: CustomText.createCustomTajawalTextStyle(
            color: Colors.white,
            fontSize: 14,
            overflow: TextOverflow.visible,
            weight: FontWeight.normal
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          suffixIcon: widget.isPassword != null && widget.isPassword == true ?
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Container(
              height: 0, width: 0,
              padding: EdgeInsets.all(13.sp),
              child: SvgPicture.asset(
                obscureText ?
                'assets/svg/fi-sr-eye.svg'
                : 'assets/svg/fi-sr-eye-crossed.svg',
                color: Colors.white.withOpacity(0.9),
                width: 20
              ),
            ),
          )
          : const SizedBox()
        ),
      ),
    );
  }
}