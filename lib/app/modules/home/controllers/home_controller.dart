import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_car_garage/app/api/booking_api.dart';
import 'package:me_car_garage/app/base/base_controller.dart';
import 'package:me_car_garage/app/model/booking-overall.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';

class HomeController extends BaseController {
  //TODO: Implement HomeController

  final count = 0.obs;
  Rx<String> weekDay = DateTime.now().day.toString().obs;
  Rx<DateTime> dateChoose = DateTime.now().obs;
  DateFormat dateFormat = DateFormat('EEEE\nMMMM-yyyy', 'vi_VN');
  RxList<BookingOverall> listBooking = <BookingOverall>[].obs;
  Rx<bool> isLoading = true.obs;
  Rx<bool> swapTab = true.obs;
  @override
  Future<void> onInit() async {
    await getBooking(DateFormat('MM/dd/yyyy').format(DateTime.now()));
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

  changeDate(DateTime dateChange) async {
    log(DateFormat('MM/dd/yyyy').format(dateChange).toString());
    dateChoose(dateChange);
    weekDay(dateChange.day.toString());
    await getBooking(DateFormat('MM/dd/yyyy').format(dateChange));
    update();
  }

  swapTabScreen(bool value) {
    swapTab(value);
  }

  getBooking(String date) async {
    try {
      isLoading(true);
      var response = await BookingApi.getAllBookingByDate(date);
      if (response.statusCode == 200) {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone;

        final mapData = listData.cast<Map<String, dynamic>>();
        listBooking.value = mapData.map<BookingOverall>((json) {
          return BookingOverall.fromJson(json);
        }).toList();
      } else {
        listBooking([]);
      }
    } catch (e) {
      log(e.toString());
      listBooking([]);
    } finally {
      isLoading(false);
    }
  }

  Widget statusBooking(
      String status, bool waittingForAccept, BuildContext context) {
    Color color = Colors.amber;
    String text = "";
    if (waittingForAccept) {
      color = Colors.brown;
      text = "Có sự thay đổi";
    } else {
      switch (status) {
        case "Pending":
          color = Colors.amber.shade600;
          text = "Sắp tới";
          break;
        case "Canceled":
          color = ColorsManager.colorCancel;
          text = "Đã huỷ";
          break;
        case "CheckIn":
          color = ColorsManager.colorCheckIn;
          text = "Đang xử lý";
          break;
        case "Completed":
          color = ColorsManager.colorDone;
          text = "Hoàn thành";
          break;
        case "Warranty":
          color = Colors.lime;
          text = "Đang bảo hành";
          break;
        default:
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }

  sortData() {
    listBooking.reversed;
  }

  void increment() => count.value++;
}
