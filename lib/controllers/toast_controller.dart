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
    // log(isToastOnScreen.value.toString());
  }
}