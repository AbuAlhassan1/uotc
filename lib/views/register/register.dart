import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uotc/translations/locale_keys.g.dart';
import '../common/custom_text.dart';
import '../common/text_fields_and_buttons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  int colorFactor = 150;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() => colorFactor = colorFactor == 150 ? 50 : 150);
    });
  }

  @override
  Widget build(BuildContext context) {

    context.setLocale(const Locale('ar'));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF575664),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                color: Colors.transparent,
                height: height, width: width,
                child: Image.asset('assets/gif/Motion-graphics-Geya-Shvecova.gif', fit: BoxFit.cover,),
              ),
            ),
            
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
            ),
          
            Align(
              alignment: const Alignment(0, 1),
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                width: width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x00000000),
                      Color(0x00000000),
                      Color.fromRGBO(103, 58, 183, 1).withOpacity(0.6),
                      Color.fromRGBO(33, colorFactor, 243, 1).withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
                child: PageView(
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildRegisterContent(width, height),
                    buildLoginContent(width, height),
                  ],
                )
              ),
            )
          ],
        )
      ),
    );
  }

  Widget buildRegisterContent(double width, double height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

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
        ),

        CustomText.createCustomTajawalText(
          text: 'انشأ حساب و شارك لحضاتك مع زملائك',
          align: TextAlign.center,
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
          overflow: TextOverflow.visible,
          weight: FontWeight.w300
        ).tr(),

        MyTextField(
          hint: 'اسم المستخدم',
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: LocaleKeys.email.tr(),
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: LocaleKeys.password.tr(),
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: 'تأكيد كلمة المرور',
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        ButtonOne(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          padding: EdgeInsets.symmetric(vertical: 0.h),
          height: 45,
          shap: CustomText.createCustomTajawalText(
            text: LocaleKeys.register,
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 20,
            overflow: TextOverflow.visible,
            weight: FontWeight.bold
          ).tr(),
          onTap: (){},
        ),

        Padding(
          padding: EdgeInsets.only(bottom: height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.createCustomTajawalText(
                text: 'لديك حساب بالفعل ؟',
                align: TextAlign.center,
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.normal
              ).tr(),
              SizedBox(width: 5.w,),
              CustomText.createCustomTajawalText(
                text: 'تسجيل الدخول',
                align: TextAlign.center,
                color: Colors.white,
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.bold
              ).tr(),
            ],
          ),
        )

      ],
    );
  }

  Widget buildLoginContent(double width, double height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomText.createCustomTajawalText(
            text: 'مرحبا بك',
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 25,
            overflow: TextOverflow.visible,
            weight: FontWeight.w300
          ).tr(),
        ),

        CustomText.createCustomTajawalText(
          text: 'انشأ حساب و شارك لحضاتك مع زملائك',
          align: TextAlign.center,
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
          overflow: TextOverflow.visible,
          weight: FontWeight.w300
        ).tr(),

        MyTextField(
          hint: LocaleKeys.email.tr(),
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        MyTextField(
          hint: LocaleKeys.password.tr(),
          isPassword: true,
          margin: EdgeInsets.symmetric(vertical: 10.h),
        ),

        ButtonOne(
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          padding: EdgeInsets.symmetric(vertical: 0.h),
          height: 45,
          shap: CustomText.createCustomTajawalText(
            text: LocaleKeys.login,
            align: TextAlign.center,
            color: Colors.white,
            fontSize: 20,
            overflow: TextOverflow.visible,
            weight: FontWeight.bold
          ).tr(),
          onTap: (){},
        ),

        Padding(
          padding: EdgeInsets.only(bottom: height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.createCustomTajawalText(
                text: 'ليس لديك حساب ؟',
                align: TextAlign.center,
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.normal
              ).tr(),
              SizedBox(width: 5.w,),
              CustomText.createCustomTajawalText(
                text: 'انشاء حساب',
                align: TextAlign.center,
                color: Colors.white,
                fontSize: 16,
                overflow: TextOverflow.visible,
                weight: FontWeight.bold
              ).tr(),
            ],
          ),
        )

      ],
    );
  }
}