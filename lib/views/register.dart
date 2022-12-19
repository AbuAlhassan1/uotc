import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import '../constants.dart';
import 'common/custom_text.dart';
import 'common/text_fields_and_buttons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  PageController registerationPageController = PageController(
    keepPage: true
  );
  late Timer interval;
  int colorFactor = 150;
  bool isTyping = false;

  FocusNode usernameFocusNode = FocusNode(debugLabel: 'username');
  FocusNode emailFocusNode = FocusNode(debugLabel: 'email');
  FocusNode passwordFocusNode = FocusNode(debugLabel: 'password');
  FocusNode confirmPasswordFocusNode = FocusNode(debugLabel: 'confirmPassword');
  FocusNode loginEmailFocusNode = FocusNode(debugLabel: 'loginEmail');
  FocusNode loginPasswordFocusNode = FocusNode(debugLabel: 'loginPassword');


  @override
  void initState() {
    super.initState();
    interval = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() => colorFactor = colorFactor == 150 ? 50 : 150);
    });
  }

  @override
  void dispose() {
    interval.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: KeyboardVisibility(
          onChanged: (bool isVisible) {
            setState(() => isTyping = isVisible);
          },
          child: Stack(
            children: [

              // Sparkling Background -- S t a r t --
              Positioned(
                top: 0,
                child: SizedBox(
                  height: height, width: width,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/gif/Motion-graphics-Geya-Shvecova.gif', fit: BoxFit.cover,)
                  ),
                ),
              ),
              // Sparkling Background -- E n d --

              // Uotc Title -- S t a r t --
              !isTyping ?
              Positioned(
                top: 0,
                child: SizedBox(
                  height: height, width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.08),
                          child: CustomText.createCustomTajawalText(
                            text: 'U   O   T   C',
                            align: TextAlign.center,
                            color: Colors.white,
                            fontSize: 40,
                            overflow: TextOverflow.visible,
                            weight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : const SizedBox(),
              // Uotc Title -- E n d --

              // Page Content -- S t a r t --
              Align(
                alignment: const Alignment(0, 1),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  width: width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0x00000000),
                        const Color(0x00000000),
                        const Color.fromRGBO(103, 58, 183, 1).withOpacity(0.6),
                        Color.fromRGBO(33, colorFactor, 243, 1).withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  ),
                  child: PageView(
                    controller: registerationPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildRegisterContent(width, height),
                      buildLoginContent(width, height),
                    ],
                  )
                ),
              ),
              // Page Content -- E n d --

            ],
          ),
        )
      ),
    );
  }

  Widget buildRegisterContent(double width, double height){
    return Column(
      mainAxisAlignment: !isTyping ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
    
        // Header Text -- S t a r t --
        !isTyping ?
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomText.createCustomTajawalText(
            text: 'مرحبا بك في يوتك',
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 25,
            overflow: TextOverflow.visible,
            weight: FontWeight.w300
          ).tr(),
        )
        : SizedBox(height: 40.h,),
    
        !isTyping ?
        CustomText.createCustomTajawalText(
          text: 'انشأ حساب و شارك لحضاتك مع زملائك',
          align: TextAlign.center,
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
          overflow: TextOverflow.visible,
          weight: FontWeight.w300
        ).tr()
        : const SizedBox(),
        // Header Text -- E n d --
    
        MyTextField(
          hint: LocaleKeys.username.tr(),
          focusNode: usernameFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
    
        MyTextField(
          hint: LocaleKeys.email.tr(),
          focusNode: emailFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
    
        MyTextField(
          hint: LocaleKeys.password.tr(),
          focusNode: passwordFocusNode,
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
    
        MyTextField(
          hint: LocaleKeys.confirmPassword.tr(),
          focusNode: confirmPasswordFocusNode,
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
    
        ButtonOne(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          padding: EdgeInsets.symmetric(vertical: 0.h),
          height: 30.h,
          shap: CustomText.createCustomTajawalText(
            text: LocaleKeys.register,
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 18,
            overflow: TextOverflow.visible,
            weight: FontWeight.bold
          ).tr(),
          onTap: () {},
        ),
    
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.createCustomTajawalText(
                text: LocaleKeys.alreadyHaveAnAccount.tr(),
                align: TextAlign.center,
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.normal
              ).tr(),
              SizedBox(width: 5.w,),
              GestureDetector(
                onTap: () => registerationPageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic),
                child: CustomText.createCustomTajawalText(
                  text: LocaleKeys.login_,
                  align: TextAlign.center,
                  color: Colors.white,
                  fontSize: 16,
                  overflow: TextOverflow.visible,
                  weight: FontWeight.bold
                ).tr(),
              ),
            ],
          ),
        )
    
      ],
    );
  }

  Widget buildLoginContent(double width, double height){
    return Column(
      mainAxisAlignment: !isTyping ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // Header Text -- S t a r t --
        !isTyping ?
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomText.createCustomTajawalText(
            text: LocaleKeys.welcome.tr(),
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 25,
            overflow: TextOverflow.visible,
            weight: FontWeight.w300
          ).tr(),
        )
        : SizedBox(height: 40.h,),

        MyTextField(
          hint: LocaleKeys.email.tr(),
          focusNode: loginEmailFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: LocaleKeys.password.tr(),
          focusNode: loginPasswordFocusNode,
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
    
        ButtonOne(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          padding: EdgeInsets.symmetric(vertical: 0.h),
          height: 30.h,
          shap: CustomText.createCustomTajawalText(
            text: LocaleKeys.login,
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 18,
            overflow: TextOverflow.visible,
            weight: FontWeight.bold
          ).tr(),
          onTap: () => NavKeys.mainNavKey.currentState!.pushNamed('/'),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.createCustomTajawalText(
                text: LocaleKeys.dontHaveAnAccount,
                align: TextAlign.center,
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.normal
              ).tr(),
              SizedBox(width: 5.w,),
              GestureDetector(
                onTap: () => registerationPageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic),
                child: CustomText.createCustomTajawalText(
                  text: LocaleKeys.createAccount,
                  align: TextAlign.center,
                  color: Colors.white,
                  fontSize: 16,
                  overflow: TextOverflow.visible,
                  weight: FontWeight.bold
                ).tr(),
              ),
            ],
          ),
        )

      ],
    );
  }

}