import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_garage/app/api/booking_api.dart';
import 'package:me_car_garage/app/base/base_controller.dart';
import 'package:me_car_garage/app/model/booking-detail.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';

class BookingDetailController extends BaseController {
  //TODO: Implement BookingDetailController
  BookingDetailController({required this.idBooking});
  int idBooking;
  Rx<BookingDetail> bookingDetail = BookingDetail().obs;
  Rx<bool> isLoading = true.obs;
  @override
  Future<void> onInit() async {
    try {
      log(idBooking.toString());
      isLoading(true);
      await loadBookingDetail(idBooking);
      isLoading(false);
    } catch (e) {
      Get.back();
      Get.snackbar("Thông báo", 'Có gì đó không đúng');
    }
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

  loadBookingDetail(int id) async {
    var response = await BookingApi.loadBookingDetail(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      bookingDetail.value = BookingDetail.fromJson(data);
    } else {
      throw Error();
    }
  }

  changeStatus() async {
    var response;
    String status = bookingDetail.value.bookingStatus!;
    int statusSend = 4;
    switch (status) {
      case "Pending":
        statusSend = 2;
        response = await BookingApi.changeStatus(idBooking, statusSend);
        if (response.statusCode == 200) {
          Get.offNamed(Routes.HOME);
          Get.snackbar("Thông báo", "Cập nhật trạng thái thành công",
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white);
        } else if (response.statusCode == 404) {
          Get.snackbar(
              "Thông báo", jsonDecode(response.body)["title"].toString(),
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white);
        } else {
          Get.snackbar("Thông báo", "Có gì đó không đúng",
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white);
        }
        break;
      case "Completed":
        statusSend = -1;
        break;
      case "CheckIn":
          Get.toNamed(Routes.BOOKING_DETAIL_SERVICE,arguments: idBooking);
        break;
      default:
        statusSend = 4;
    }
  }
}
