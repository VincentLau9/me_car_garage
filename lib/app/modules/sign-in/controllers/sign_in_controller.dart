import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_garage/app/api/user_api.dart';
import 'package:me_car_garage/app/base/base_controller.dart';
import 'package:me_car_garage/app/data/database_local.dart';
import 'package:me_car_garage/app/model/user.dart';
import 'package:me_car_garage/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';

class SignInController extends BaseController {
  //TODO: Implement SignInController

  final count = 0.obs;
  RxBool checkpassword = true.obs;
  RxBool enableButton = false.obs;
  RxString errorEmailInput = "".obs;
  RxString errorPasswordInput = "".obs;
  RxString phone = "".obs;
  RxString passowrd = "".obs;
  RxBool lockButton = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setValuePhone(String value) {
    phone(value);
    // if (!GetUtils.isPhoneNumber(value) && value.length!=10) {
    //   errorEmailInput('Số điện thoại không hợp lệ');
    // } else {
    errorEmailInput("");
    // }
    checkEnableButton();
  }

  checkEnableButton() {
    if (errorEmailInput.isEmpty &&
        errorPasswordInput.isEmpty &&
        phone.trim().isNotEmpty &&
        passowrd.isNotEmpty) {
      enableButton(true);
    } else {
      enableButton(false);
    }
  }

  setValuePassword(String value) {
    passowrd(value);
    if (passowrd.isEmpty) {
      errorPasswordInput('Mật khẩu không được để trống');
    } else {
      errorPasswordInput('');
    }
    checkEnableButton();
  }

  login() async {
    try {
      lockButton(true);
      UserModel userLogin = await UserApi.login(phone.value, passowrd.value);
      Get.find<StartAppController>().accessToken = userLogin.userToken!;
      Get.find<StartAppController>().name.value = userLogin.userFullName!;
      Get.find<StartAppController>().numberPhone.value = userLogin.userPhone!;
      Get.find<StartAppController>().userId.value = userLogin.userId!;

      
      String refeshToken = userLogin.refreshToken ?? "";
      await DatabaseLocal.instance.saveRefeshToken(refeshToken);
      Get.snackbar('Thông báo', 'Đăng nhập thành công',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
      Get.offAllNamed(Routes.HOME);
      lockButton(false);
    } catch (e) {
      log(e.toString());
      Get.snackbar('Thông báo', 'Đăng nhập thất bại',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
      lockButton(false);
    }
  }
}
