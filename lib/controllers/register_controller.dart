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
        log(response.body.toString());
        toastController.showToast(
          desc: jsonDecode(response.body),
          type: 'success'
        );
      }
      else{
        toastController.showToast(
          desc: {'message': 'Somthing went wrong'},
          type: 'success'
        );
      }
      await Future.delayed(const Duration(seconds: 3));
      isRegisterLoading.value = false;
    }
  }
}