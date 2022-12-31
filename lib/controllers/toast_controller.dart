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
      'icon': 'assets/svg/cross-small.svg'
    },
  };
  RxInt toastCount = 0.obs;
  RxString currentType = ''.obs;
  RxMap description = {}.obs;
  RxDouble toastAlignment = ((1.5) * (-1)).obs;
  RxBool isToastOnScreen = false.obs;

  void showToast({
    required Map desc,
    required String type,
  }) async {
    log(isToastOnScreen.value.toString());
    if(!isToastOnScreen.value){
      isToastOnScreen.value = true;
      log(isToastOnScreen.value.toString());
      description.value = desc;
      description.value = desc;
      toastAlignment.value = -1;
      await Future.delayed(const Duration(seconds: 3), () {
        toastAlignment.value = -5;
        isToastOnScreen.value = false;
      });
      await Future.delayed(const Duration(milliseconds: 800), () => description.value = {},);
    }
    log(isToastOnScreen.value.toString());
  }
}