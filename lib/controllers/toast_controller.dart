import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastStateController extends GetxController{
  Map<String, dynamic> types = {
    'success': {
      'color': const LinearGradient(colors: []),
      'icon': ''
    },
    'error': {
      'color': const LinearGradient(colors: []),
      'icon': ''
    },
    'reminder': {
      'color': const LinearGradient(colors: []),
      'icon': ''
    },
  };
  RxString currentType = ''.obs;
  RxString description = ''.obs;
  RxDouble toastAlignment = ((1.5) * (-1)).obs;
  RxBool isToastOnScreen = false.obs;

  void showToast({required String desc}){
    if(!isToastOnScreen.value){
      description.value = desc;
      toastAlignment.value = -1;
      isToastOnScreen.value = true;
      Future.delayed(const Duration(seconds: 3), () {
        toastAlignment.value = -1.5;
        isToastOnScreen.value = false;
        description.value = '';
      });
    }
  }
  void hideToast(){
    toastAlignment.value = -1.5;
  }
}