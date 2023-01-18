// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import 'package:uotc/views/common/colors.dart';
import 'package:uotc/views/common/custom_text.dart';

class RegisterTextField extends StatefulWidget {
  const RegisterTextField({
    required this.focusNode,
    required this.controller,
    required this.hint,
    required this.margin,
    this.isPassword,
    super.key,
  });
  
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hint;
  final EdgeInsets margin;
  final bool? isPassword;

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}
class _RegisterTextFieldState extends State<RegisterTextField> {

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
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
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
      ),
    );
  }
}

class ButtonOne extends StatefulWidget {
  ButtonOne({
    super.key,
    this.margin = const EdgeInsets.symmetric(),
    this.padding = const EdgeInsets.symmetric(),
    this.color = Colors.transparent,
    this.borderColor = Colors.white,
    required this.onTap,
    required this.shap,
    required this.height,
  });

  EdgeInsets? margin;
  EdgeInsets? padding;
  Color color;
  Color borderColor;
  final Widget shap;
  final Future<void> Function() onTap;
  final double height;

  @override
  State<ButtonOne> createState() => _ButtonOneState();
}
class _ButtonOneState extends State<ButtonOne> {

  bool isLoading = false;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {

    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async{
        if( !isLoading ){
          isLoading = !isLoading;
          opacity = isLoading ? 1 : 0;
          setState(() {});
          log('before');
          CancelableOperation operation = CancelableOperation.fromFuture(
            widget.onTap(),
            onCancel: () => log('canceled'),
          );
          // await widget.onTap();
          try{
            await operation.value;
          }catch(e){
            log('error: $e');
          }
          Future.delayed(
            const Duration(seconds: 3),
            () => operation.cancel(),
          );
          log('after');
          isLoading = !isLoading;
          opacity = isLoading ? 1 : 0;
          setState(() {});
        }
      },
      child: Container(
        width: width/1.5, height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.borderColor
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

class PostCommentTextField extends StatelessWidget {
  const PostCommentTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.margin = const EdgeInsetsDirectional.all(0)
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final EdgeInsetsDirectional margin;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      decoration: BoxDecoration(
        color: UotcColors.offBlack,
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 0.5
        ),
        borderRadius: BorderRadius.circular(5.sp),
        // borderRadius: BorderRadiusDirectional.only(
        //   topStart: Radius.circular(10.sp),
        //   bottomStart: Radius.circular(10.sp),
        // )
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: CustomText.createCustomTajawalTextStyle(
            fontSize: 14,
            color: Colors.white,
            weight: FontWeight.w300
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: CustomText.createCustomElMessiriTextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
              weight: FontWeight.w300
            ),
            hintText: LocaleKeys.writeAComment.tr(),
          ),
        ),
      ),
    );
  }
}