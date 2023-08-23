import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_garage/app/api/user_api.dart';
import 'package:me_car_garage/app/base/base_controller.dart';
import 'package:me_car_garage/app/data/database_local.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';

class StartAppController extends BaseController {
  //TODO: Implement StartAppController

  Rx<String> token = ''.obs;
  String accessToken = '';
  Rx<String> name = ''.obs;
  Rx<String> numberPhone = ''.obs;
  Rx<int> idGarage = 0.obs;
  Rx<int> userId = 0.obs;
  Rx<String> email = ''.obs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Rx<UserModel> userModelT = UserModel().obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(
      Duration(seconds: 3),
    );
    await refeshToken();
    _firebaseMessaging.requestPermission();
    String? deviceToken = await _firebaseMessaging.getToken();
    print('Device Token: $deviceToken');

    // userModelT.value = await getLoginModel();
  }

  @override
  Future<void> onReady() async {
    // await _firebaseMessaging.subscribeToTopic('topic_name');
    // await _firebaseMessaging.sendMessage(
    //     to: 'dTOwlSztSAqoL4WrlBF3v1:APA91bFbG-drb3BsHREHXRuGSZ84WGIx4BNm1JVV6OX4jZlpgwTtgun0-Bzz4eOYRw2TZ3_jkvJ8k11gCAtcv4HrrMzrj9q2N1ZV9LT0HcTvYL3q2FTlCRRzyDROK_1OzOd51B755Rlk',
    //     data: {"title": "DATA"},
    //     collapseKey: "HEHE");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  refeshToken() async {
    // Obtain shared preferences.
    String? refeshToken = await DatabaseLocal.instance.getRefeshToken();
    log(refeshToken.toString());
    if (refeshToken == null) {
      Get.offAllNamed(Routes.SIGN_IN);
    } else {
      //Goi refeshtokenapu
      dynamic response = await UserApi.refeshToken(refeshToken);
      log(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        accessToken = data["userToken"];
        String refeshToken = data["refreshToken"];
        name(data["userFullName"] ?? "");
        numberPhone(data["userPhone"] ?? "");
        userId(data["userId"] ?? 0);
        email(data["userEmail"]??"");
        log(data["userFullName"]);
        await DatabaseLocal.instance.saveRefeshToken(refeshToken);

        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.SIGN_IN);
      }
    }
  }

  logout() async {
    await DatabaseLocal.instance.removeJwtToken();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  sendNotify()async{
    //  final message =<String,dynamic> {
    //   'notification': {
    //     'title': 'Notification Title',
    //     'body': 'Notification Body'
    //   },
    //   'to': 'dTOwlSztSAqoL4WrlBF3v1:APA91bFbG-drb3BsHREHXRuGSZ84WGIx4BNm1JVV6OX4jZlpgwTtgun0-Bzz4eOYRw2TZ3_jkvJ8k11gCAtcv4HrrMzrj9q2N1ZV9LT0HcTvYL3q2FTlCRRzyDROK_1OzOd51B755Rlk'
    // };

    // final response = await _firebaseMessaging.sendMessage(
    //   to: 
    //   'dTOwlSztSAqoL4WrlBF3v1:APA91bFbG-drb3BsHREHXRuGSZ84WGIx4BNm1JVV6OX4jZlpgwTtgun0-Bzz4eOYRw2TZ3_jkvJ8k11gCAtcv4HrrMzrj9q2N1ZV9LT0HcTvYL3q2FTlCRRzyDROK_1OzOd51B755Rlk',
    //   data:   message,
    // );
  }
}
