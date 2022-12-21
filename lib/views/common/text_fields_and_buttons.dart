// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/views/common/custom_text.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    required this.focusNode,
    required this.hint,
    required this.margin,
    this.isPassword,
    super.key,
  });
  
  final FocusNode focusNode;
  final String hint;
  final EdgeInsets margin;
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

    return Container(
      width: width/1.5,
      margin: widget.margin,
      child: TextField(
        focusNode: widget.focusNode,
        autofocus: false,
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

class ButtonOne extends StatefulWidget {
  const ButtonOne({
    super.key,
    required this.onTap,
    required this.margin,
    required this.padding,
    required this.shap,
    required this.color,
    required this.height,
  });

  final void Function() onTap;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget shap;
  final Color color;
  final double height;

  @override
  State<ButtonOne> createState() => _ButtonOneState();
}

class _ButtonOneState extends State<ButtonOne> {

  bool isLoading = false;
  double opacity = 0;


  int x() => 0; 

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async{
        // if( !isLoading ){
        //   isLoading = !isLoading;
        //   opacity = isLoading ? 1 : 0;
        //   setState(() {});
        //   await Future.delayed(const Duration(seconds: 4), () {
        //     isLoading = !isLoading;
        //     opacity = isLoading ? 1 : 0;
        //     setState(() {});
        //   });
        // }
        widget.onTap();
      },
      child: Container(
        width: width/1.5, height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: Colors.white
          ),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: 1 - opacity,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: widget.shap,
                ),
              )
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: double.infinity, width: double.infinity,
                  child: Image.asset('assets/gif/67e437ea72dc17270017806dbfcd9ef92.gif', fit: BoxFit.contain)
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}