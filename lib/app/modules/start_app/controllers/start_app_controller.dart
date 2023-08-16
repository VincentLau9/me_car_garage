import 'dart:convert';
import 'dart:developer';

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

  // Rx<UserModel> userModelT = UserModel().obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(
      Duration(seconds: 3),
    );
    await refeshToken();
    // userModelT.value = await getLoginModel();
  }

  @override
  void onReady() {
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
        userId(data["userId"]??0);
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
}
