import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:uotc/services/remote.dart';
import 'toast_controller.dart';

class RegisterStateController extends GetxController{
  ToastStateController toastController = Get.find();
  RxBool isRegisterLoading = false.obs;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    if(!isRegisterLoading.value){
      isRegisterLoading.value = true;
      var response = await Remote.apiCall(
        path: 'user/create-user',
        body: {
          'username': username,
          'email': email,
          'password': password,
        }
      );
      if(response != null){
        if(response.statusCode == 201){
          toastController.showToast(
            desc: jsonDecode(response.body)['message'],
            type: 'success',
            seconds: 5
          );
        }else{
          String text = '';
          int count = 1;
          Map<dynamic, dynamic> map = jsonDecode(response.body);
          map.forEach((key, value) {
            text += count > 1 ? '\n$value' : value;
            count++;
          });
          toastController.showToast(
            desc: text,
            type: 'error',
            seconds: 5
          );
        }
      }
      else{
        toastController.showToast(
          desc: 'Somthing went wrong',
          type: 'error',
          seconds: 5
        );
      }
      await Future.delayed(const Duration(seconds: 3));
      isRegisterLoading.value = false;
    }
  }
}