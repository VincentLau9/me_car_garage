import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_garage/app/api/booking_api.dart';
import 'package:me_car_garage/app/base/base_controller.dart';
import 'package:me_car_garage/app/model/booking-overall-detail.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';

class BookingDetailServiceController extends BaseController {
  //TODO: Implement BookingDetailServiceController
  BookingDetailServiceController({required this.idBooking});
  int idBooking;
  Rx<bool> isLoading = true.obs;
  Rx<BookingOverallDetail> bookingOverallDetail = BookingOverallDetail().obs;
  List<String> listStatus = ["Đang chờ", "Chưa Hoàn Thành", "Đã Hoàn Thành"];
  Rx<String> statusChoice = "Đang chờ".obs;
  Rx<bool> refreshData = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading(true);
      log(idBooking.toString());
      await getBookingDetailService(idBooking);
      isLoading(false);
    } catch (e) {
      log(e.toString());
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getBookingDetailService(int idBooking) async {
    final response = await BookingApi.getBookingServiceDetail(
      idBooking,
    );
    if (response.statusCode == 200) {
      bookingOverallDetail.value =
          BookingOverallDetail.fromJson(jsonDecode(response.body));
    } else {
      Get.back();
    }
  }

  String getPathStatus(String status) {
    switch (status) {
    case "NotStart":
        return IconAssets.notyet_icon;
      case "Done":
        return IconAssets.done_icon;
      case "Error":
        return IconAssets.fail_icon;
      case "Đang chờ":
        return IconAssets.notyet_icon;
      case "Chưa Hoàn Thành":
        return IconAssets.fail_icon;
      case "Đã Hoàn Thành":
        return IconAssets.done_icon;
      default:
        return IconAssets.notyet_icon;
    }
  }

  chooseStatus(int indexInArray) {
    statusChoice.value = listStatus.elementAt(indexInArray);
    log(statusChoice.value);
  }

  updateStatusService(String status, int indexBookingDetail) async {
    int indexCode;
    switch (status) {
      case "Đang chờ":
        indexCode = 0;
        break;
      case "Đã Hoàn Thành":
        indexCode = 1;
        break;
      case "Chưa Hoàn Thành":
        indexCode = 2;
        break;

      default:
        indexCode = 0;
    }
    int idBookingDetail = bookingOverallDetail.value.serviceStatusForStaffDtos!
        .elementAt(indexBookingDetail)
        .bookingDetailId!;
    final response =
        await BookingApi.updateBookingStatus(idBookingDetail, indexCode);
    if (response.statusCode == 200) {
      statusChoice("Đang chờ");
      bookingOverallDetail.value.serviceStatusForStaffDtos!
          .elementAt(indexBookingDetail)
          .bookingServiceStatus = status;
      Get.back();
         Get.snackbar("Thông báo", "Cập nhật trạng thái thành công",
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white);
      refreshData(true);
      await Future.delayed(Duration(milliseconds: 500));
      refreshData(false);
    } else {}
  }
  completeBoooking() async{
    bool check = true;
    for (var i = 0; i < bookingOverallDetail.value.serviceStatusForStaffDtos!.length; i++) {
      if(bookingOverallDetail.value.serviceStatusForStaffDtos![i].bookingServiceStatus=='NotStart'){
        check = false;
        break;
      }
    }
    if(check){
    final  response = await BookingApi.changeStatus(idBooking, 4);
        if (response.statusCode == 200) {
          Get.offAllNamed(Routes.HOME);
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
    }
    else{
 Get.snackbar("Thông báo", "Bàn cần cập nhật hết trạng thái các nhiệm vụ",
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white);
    }
  }
}
