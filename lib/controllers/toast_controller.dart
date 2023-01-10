import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastStateController extends GetxController{
  Map<String, dynamic> types = {
    'success': {
      'color': LinearGradient(
        colors: [
          Colors.green.withOpacity(0.2),
          Colors.green.withOpacity(0.1),
          Colors.transparent,
          Colors.transparent,
        ]
      ),
      'text-color': Colors.green,
      'sub-text': 'You are good to go',
      'icon': 'assets/svg/fi-rr-check.svg'
    },
    'error': {
      'color': LinearGradient(
        colors: [
          Colors.red.withOpacity(0.2),
          Colors.red.withOpacity(0.1),
          Colors.transparent,
          Colors.transparent,
        ]
      ),
      'text-color': Colors.red,
      'sub-text': 'Retry after correcting the error',
      'icon': 'assets/svg/cross-small.svg'
    },
    'reminder': {
      'color': LinearGradient(
        colors: [
          Colors.yellow.withOpacity(0.2),
          Colors.yellow.withOpacity(0.1),
          Colors.transparent,
          Colors.transparent,
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
  RxBool isStoriesHidden = false.obs;
  // Special -- E n d --

  @override
  void onInit() {
    super.onInit();
    storiesPosition.value = -140;
    navMenuButtonPosition.value = -140;
  }

  void showToast({
    required String desc,
    required String type,
    required int seconds,
  }) async {
    if(!isToastOnScreen.value){
      isToastOnScreen.value = true;
      description.value = desc;
      toastAlignment.value = -1;
      await Future.delayed(Duration(seconds: seconds), () {
        toastAlignment.value = -5;
        isToastOnScreen.value = false;
      });
      await Future.delayed(const Duration(milliseconds: 800), () => description.value = '',);
    }
  }

  alignNavBtn(double position){
    navMenuButtonPosition.value = position;
  }

  void hideShowStories(double position){
    log('clicked');
    if (isStoriesHidden.value){
      storiesPosition.value = 0;
      navMenuButtonPosition.value = position * (-1);
      isStoriesHidden.value = !isStoriesHidden.value;
    }else{
      storiesPosition.value = position;
      navMenuButtonPosition.value = 0;
      isStoriesHidden.value = !isStoriesHidden.value;
    }
    log(storiesPosition.value.toString());
  }

  void hideStories(double position){
    storiesPosition.value = position;
    navMenuButtonPosition.value = 0;
    isStoriesHidden.value = true;
  }

  void showStories(double position){
    storiesPosition.value = 0;
    navMenuButtonPosition.value = position * (-1);
    isStoriesHidden.value = false;
  }
}