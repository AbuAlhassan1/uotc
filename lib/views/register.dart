import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:go_router/go_router.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import '../controllers/register_controller.dart';
import '../controllers/toast_controller.dart';
import 'common/custom_text.dart';
import 'common/text_fields_and_buttons.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  RegisterStateController registerStateController = Get.put(RegisterStateController());
  ToastStateController toastController = Get.find();
  PageController registerationPageController = PageController(keepPage: true);
  late Timer interval;
  int colorFactor = 150;
  bool isTyping = false;

  FocusNode usernameFocusNode = FocusNode(debugLabel: 'username');
  TextEditingController usernameController = TextEditingController();
  FocusNode emailFocusNode = FocusNode(debugLabel: 'email');
  TextEditingController emailController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode(debugLabel: 'password');
  TextEditingController passwordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode(debugLabel: 'confirmPassword');
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode loginEmailFocusNode = FocusNode(debugLabel: 'loginEmail');
  TextEditingController loginEmailController = TextEditingController();
  FocusNode loginPasswordFocusNode = FocusNode(debugLabel: 'loginPassword');
  TextEditingController loginPasswordController = TextEditingController();


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

    return WillPopScope(
      onWillPop: () async {
        log('register page');
        return false;
      },
      child: GestureDetector(
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
                      opacity: 0.25,
                      child: Image.asset('assets/gif/Motion-graphics-Geya-Shvecova.gif', fit: BoxFit.cover,)
                    ),
                  ),
                ),
                // Sparkling Background -- E n d --
    
                // Uotc Title -- S t a r t --
                // !isTyping ?
                // Align(
                //   alignment: const Alignment(0, -0.9),
                //   child: SafeArea(
                //     child: CustomText.createCustomTajawalText(
                //       text: 'U      O      T      C',
                //       align: TextAlign.center,
                //       color: Colors.white,
                //       fontSize: 30,
                //       overflow: TextOverflow.visible,
                //       weight: FontWeight.w100,
                //       screenHeight: height
                //     ),
                //   ),
                // )
                // : const SizedBox(),
                // // Uotc Title -- E n d --
    
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
                          Colors.transparent,
                          Colors.transparent,
                          // Colors.transparent,
                          Colors.pink.withOpacity(0.1),
                          Colors.pink.withOpacity(0.4),
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
            weight: FontWeight.w300,
            screenHeight: height
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
          weight: FontWeight.w300,
          screenHeight: height
        ).tr()
        : const SizedBox(),
        // Header Text -- E n d --

        // Username TextField -- S t a r t --
        MyTextField(
          hint: LocaleKeys.username.tr(),
          controller: usernameController,
          focusNode: usernameFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
        // Username TextField -- E n d --

        // Email TextField -- S t a r t --
        MyTextField(
          hint: LocaleKeys.email.tr(),
          controller: emailController,
          focusNode: emailFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
        // Email TextField -- E n d --

        // Password TextField -- S t a r t --
        MyTextField(
          hint: LocaleKeys.password.tr(),
          controller: passwordController,
          focusNode: passwordFocusNode,
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
        // Password TextField -- E n d --

        // Confirm Password TextField -- S t a r t --
        MyTextField(
          hint: LocaleKeys.confirmPassword.tr(),
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),
        // Confirm Password TextField -- E n d --
    
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
            weight: FontWeight.bold,
            screenHeight: height
          ).tr(),
          onTap: () async {
            await registerStateController.register(
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text,
            );
            // toastController.showToast();
          },
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
                weight: FontWeight.normal,
                screenHeight: height
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
                  weight: FontWeight.bold,
                  screenHeight: height
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
            weight: FontWeight.w300,
            screenHeight: height
          ).tr(),
        )
        : SizedBox(height: 40.h,),

        MyTextField(
          hint: LocaleKeys.email.tr(),
          controller: loginEmailController,
          focusNode: loginEmailFocusNode,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: LocaleKeys.password.tr(),
          controller: loginPasswordController,
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
            weight: FontWeight.bold,
            screenHeight: height
          ).tr(),
          onTap: () => context.go('/lobby') // NavKeys.mainNavKey.currentState!.pushReplacementNamed('/lobby'),
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
                weight: FontWeight.normal,
                screenHeight: height
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
                  weight: FontWeight.bold,
                  screenHeight: height
                ).tr(),
              ),
            ],
          ),
        )

      ],
    );
  }

}