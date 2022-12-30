import 'dart:developer';

import 'package:get/get.dart';
import 'package:uotc/services/remote.dart';
import 'toast_controller.dart';

class RegisterStateController extends GetxController{
  ToastStateController toastController = Get.find();

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    var response = await Remote.apiCall(
      path: 'user/create-user',
      body: {
        'username': username,
        'email': email,
        'password': password,
      }
    );
    log(response!.body.toString());
    toastController.showToast(desc: response!.body.toString());
  }
}