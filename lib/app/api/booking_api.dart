import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_garage/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_garage/app/resources/base_link.dart';

class BookingApi {
  

  static Future<dynamic> loadBookingDetail(int idBooking) async {
    log(idBooking.toString());
    var url = Uri.parse(BaseLink.LOADING_BOOKING_DETAIL + '${idBooking}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('loadBookingDetail: ${response.statusCode} ${response.body}');

    return response;
  }
  static Future<dynamic> changeStatus(int idBooking,int status) async {
    log(status.toString());
    var url = Uri.parse(BaseLink.UPDATE_STATUS + '${idBooking}&${status}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('changeStatus: ${response.statusCode} ${response.body}');

    return response;
  }

    static Future<dynamic> updateBookingStatus(int bookingDetailId,int status) async {
    var url = Uri.parse(BaseLink.UPDATE_STATUS_BOOKINGDETAIL + '${bookingDetailId}&${status}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('updateBookingStatus: ${response.statusCode} ${response.body}');

    return response;
  }

  static Future<dynamic> getAllBookingByDate (String date) async{
 var url = Uri.parse(BaseLink.GET_BOOKING + '${date}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getAllBookingByDate: ${response.statusCode} ${response.body}');

    return response;
  }
    static Future<dynamic> getBookingServiceDetail (int idBooking) async{
 var url = Uri.parse(BaseLink.GET_BOOKING_SERVICE_DETAIL + '${idBooking}');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ${Get.find<StartAppController>().accessToken}'
      },
    );
    log('getBookingServiceDetail: ${response.body} ${response.body}');

    return response;
  }
  
  //changeStatus
}
