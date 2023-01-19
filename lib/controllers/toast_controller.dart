import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ToastStateController extends GetxController{
  Map<String, dynamic> types = {
    'success': {
      'color': const LinearGradient(
        colors: [
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
        ]
      ),
      'text-color': Colors.green,
      'sub-text': 'You are good to go',
      'icon': 'assets/svg/fi-rr-check.svg'
    },
    'error': {
      'color': const LinearGradient(
        colors: [
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
        ]
      ),
      'text-color': Colors.red,
      'sub-text': 'Retry after correcting the error',
      'icon': 'assets/svg/cross-small.svg'
    },
    'reminder': {
      'color': const LinearGradient(
        colors: [
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
        ]
      ),
      'text-color': Colors.yellow,
      'sub-text': 'Retry after correcting the error',
      'icon': 'assets/svg/cross-small.svg'
    },
  };
  RxInt toastCount = 0.obs;
  RxString currentType = 'error'.obs;
  RxString description = ''.obs;
  RxDouble toastAlignment = ((1.5) * (-1)).obs;
  RxBool isToastOnScreen = false.obs;

  // Special -- S t a r t --
  RxDouble storiesPosition = 0.0.obs;
  RxDouble navMenuButtonPosition = 0.0.obs;
  RxBool isStoriesHidden = true.obs;

  RxDouble statusBarPosition = (25.0 * ( -1 )).obs;
  RxDouble homeOpacity = 0.0.obs;
  // Special -- E n d --

  void showToast({ required String desc, required String type, required int seconds }) async {
    if(!isToastOnScreen.value){
      isToastOnScreen.value = true;
      currentType.value = type;
      description.value = desc;
      toastAlignment.value = -1;
      await Future.delayed(Duration(seconds: seconds), () {
        toastAlignment.value = -5;
        isToastOnScreen.value = false;
      });
      await Future.delayed(const Duration(milliseconds: 800), () => description.value = '',);
    }
  }

  void alignNavBtnForProfilePage() => navMenuButtonPosition.value = -3.h;

  void alignNavBtnForHomePage() => navMenuButtonPosition.value = -8.h;

  void hideShowStories(double position){
    if (isStoriesHidden.value){
      storiesPosition.value = 0;
      navMenuButtonPosition.value = (position * (-1)) - 12.h;
      isStoriesHidden.value = !isStoriesHidden.value;
    }else{
      storiesPosition.value = position;
      navMenuButtonPosition.value = -12.h;
      isStoriesHidden.value = !isStoriesHidden.value;
    }
  }

  void hideStories(double position){
    storiesPosition.value = position;
    navMenuButtonPosition.value = -8;
    isStoriesHidden.value = true;
  }

  void showStories(double position){
    storiesPosition.value = 0;
    navMenuButtonPosition.value = (position + 8.h) * (-1) ;
    isStoriesHidden.value = false;
  }

  void showStatusBar() => statusBarPosition.value = 0;

  void showHome() => homeOpacity.value = 1;

}