import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uotc/services/remote.dart';
import 'package:uotc/services/secure_storage.dart';
import 'toast_controller.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class RegisterStateController extends GetxController{
  ToastStateController toastController = Get.find();
  RxBool isRegisterLoading = false.obs;
  RxString userIdToken = "".obs;

  Future<void> registerAsGuest({ required String username, required String email, required String password }) async {
    List<String> messages = [];
    if(!isRegisterLoading.value){
      if(username.isEmpty){ messages.add('Username is required'); }
      if(email.isEmpty){ messages.add('Email is required'); }
      if(password.isEmpty){ messages.add('Password is required'); }
      // if(messages.length > 0){ toastController.showToast(desc: desc, type: type, seconds: seconds); }

      isRegisterLoading.value = true;
      var response = await Remote.apiCall(
        path: 'user/signup-guest',
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

  Future<bool> getGoogleUserIdToken() async {

    final GoogleSignInAccount? googleUser;
    try{googleUser = await GoogleSignIn().signIn();}
    catch(e){ return false; }
    
    final GoogleSignInAuthentication? googleAuth;
    try{googleAuth = await googleUser?.authentication;}
    catch(e){ return false; }
    
    final OAuthCredential credential;
    try{
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    }catch(e){
      return false;
    }

    final UserCredential user;
    try{user = await FirebaseAuth.instance.signInWithCredential(credential);}
    catch(e){return false;}

    String idToken;
    try{idToken = await user.user!.getIdToken();}
    catch(e){return false;}

    // log(idToken);
    userIdToken.value = idToken;
    // log(userIdToken.value);

    await GoogleSignIn().signOut();
    return true;
  }

  Future<void> registerWithGoogle() async {

    // Triger The Google Sign in Flow -- S t a r t --
    bool isOk = await getGoogleUserIdToken();

    if( isOk ){
      var response = await Remote.apiCall(
        path: 'user/signup-google?id_token=${userIdToken.value}',
      );

      if( response == null){
        toastController.showToast(
          desc: "?????? ?????? ????, ?????? ????????????????",
          type: 'error',
          seconds: 4
        );
      }else if(response.statusCode == 409){
        toastController.showToast(
          desc: "?????? ???????? ???????? ???????????? ?????????? ???????? ???????????? ??????????????????",
          type: 'error',
          seconds: 4
        );
      }else if(response.statusCode == 201){
        toastController.showToast(
          desc: "???? ?????????? ?????????? ??????????",
          type: 'success',
          seconds: 4
        );

        Map body = jsonDecode(response.body);
        log(body["access-token"]);
        SecureStorage.storeMap(
          key: "tokens",
          map: body
        );
      }
    }
    else{
      toastController.showToast(
        desc: "?????? ???? ?????????? ???????? ?????????????? ????????????????",
        type: 'reminder',
        seconds: 4
      );
    }
  }

  Future<void> loginAsGuest({required emailOrUsername, required password}) async {
    if( !isRegisterLoading.value ){

      isRegisterLoading.value = true;

      var response = await Remote.apiCall(
        path: "user/login-guest",
        body: {
          "email_or_username": emailOrUsername,
          "password": password
        }
      );

      if( response != null ){
        log(response.body);
        if(response.statusCode == 200){
          await SecureStorage.storeMap(
            key: "tokens",
            map: jsonDecode(response.body)
          );
          toastController.showToast(
            desc: "?????????? ???? ???? ????????",
            type: 'success',
            seconds: 4
          );
        }else if(response.statusCode == 400){
          toastController.showToast(
            desc: "?????? ???????????????? ???? ???????????? ?? ???????? ???????????? ????????????????",
            type: 'error',
            seconds: 4
          );
        }else if(response.statusCode == 403){
          toastController.showToast(
            desc: "?????? ???????????????? ???? ???????????? ?? ???????? ????????????, ???????????? ????????",
            type: 'error',
            seconds: 4
          );
        }else if(response.statusCode == 500){
          toastController.showToast(
            desc: "?????? ?????? ????, ?????? ????????????????",
            type: 'error',
            seconds: 4
          );
        }
      }else{
        toastController.showToast(
          desc: "?????? ?????? ????, ?????? ????????????????",
          type: 'error',
          seconds: 4
        );
      }
      isRegisterLoading.value = false;
    }
  }

  test(){
    String myToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzMzOTE1NzcuMTk2MDA0LCJpZCI6Ijg2NTEwNWI1LTVmYzktNDFhZS1hYWRmLTRlOGZiMGYyMDliMSJ9.1BQHQewvq37BNClZTRiQYJw8HojeXAS_qM7561_eGE4";
    Map tokenInfo = JwtDecoder.decode(myToken);
    log(tokenInfo.toString());
    double exp = tokenInfo['exp'];
    var date = DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000);
    log(date.toString());
  }
}