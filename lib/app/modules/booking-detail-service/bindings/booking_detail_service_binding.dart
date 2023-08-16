import 'dart:developer';

import 'package:get/get.dart';
import 'package:me_car_garage/app/base/base_bindings.dart';

import '../controllers/booking_detail_service_controller.dart';

class BookingDetailServiceBinding extends BaseBindings {
  @override
  void injectService() {
    int idBooking = Get.arguments as int;
     log(idBooking.toString());
    Get.lazyPut<BookingDetailServiceController>(
      () => BookingDetailServiceController(idBooking: idBooking),
    );
  }
}
