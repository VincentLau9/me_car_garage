import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:me_car_garage/app/base/base_view.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';
import 'package:me_car_garage/app/resources/reponsive_utils.dart';
import 'package:me_car_garage/app/resources/text_style.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/booking_detail_controller.dart';

class BookingDetailView extends BaseView<BookingDetailController> {
  const BookingDetailView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() {
          String status =
              controller.bookingDetail.value.bookingStatus ?? "Pending";
          bool waitForAccept =
              controller.bookingDetail.value.waitForAccept ?? false;
          if (controller.isLoading.value) {
            return SizedBox();
          }
          return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: UtilsReponsive.width(context, 50),
                  vertical: UtilsReponsive.width(context, 10)),
              child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: context.width),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          waitForAccept ? Colors.brown : ColorsManager.primary),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    ),
                    child: Text(
                      waitForAccept
                          ? "Có sự thay đổi"
                          : status == 'Pending'
                              ? "Check In"
                              : status == 'CheckIn' || status == "Warranty"
                                  ? "Tiến trình"
                                  : "Đã hoàn thành",
                      style: TextStyleConstant.white16Roboto,
                    ),
                    onPressed: () async {
                      if (!waitForAccept) {
                        await controller.changeStatus();
                      }
                    },
                  )));
        }),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: UtilsReponsive.height(context, 120),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                  child: Text(
                                'Xác nhận đơn hàng',
                                style: TextStyleConstant.black22RobotoBold,
                              )),
                            ),
                            Expanded(child: SizedBox())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 9,
                child: Obx(() => controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'THÔNG TIN KHÁCH HÀNG',
                                style: TextStyleConstant.black16RobotoBold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                controller.bookingDetail.value.customerName
                                    .toString(),
                                style: TextStyleConstant.black16RobotoBold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller.bookingDetail.value.customerPhone
                                        .toString(),
                                    style:
                                        TextStyleConstant.primary16RobotoBold,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        _launchDialPhone(controller
                                            .bookingDetail.value.customerPhone!
                                            .toString());
                                      },
                                      icon: Icon(Icons.phone_in_talk))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'CHI TIẾT XE',
                                style: TextStyleConstant.black16RobotoBold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Thương hiệu xe'),
                                  Text(
                                    controller.bookingDetail.value
                                        .carBookingDetailForStaffDto!.carName
                                        .toString(),
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Biển số xe'),
                                  Text(
                                    controller
                                        .bookingDetail
                                        .value
                                        .carBookingDetailForStaffDto!
                                        .carLicensePlate!,
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              controller.bookingDetail.value.warrantyReason ==
                                      ""
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          height: 2,
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Đơn bảo hành '),
                                        Text(
                                          controller.bookingDetail.value
                                              .warrantyReason!,
                                          style: TextStyleConstant
                                              .black16RobotoBold,
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              controller.bookingDetail.value.warrantyReason ==
                                      ""
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          height: 2,
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Lý do bảo hành: '),
                                        Text(
                                          controller.bookingDetail.value
                                              .warrantyReason!,
                                          style: TextStyleConstant
                                              .black16RobotoBold,
                                        ),
                                      ],
                                    ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text('Thời gian nhận xe'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          controller
                                              .bookingDetail.value.pickUpTime!,
                                          style: TextStyleConstant
                                              .grey16RobotoBold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Thời gian giao xe'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          controller
                                              .bookingDetail.value.deliveryTime
                                              .toString(),
                                          style: TextStyleConstant
                                              .grey16RobotoBold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'NHỮNG GÓI DỊCH VỤ ĐÃ ĐẶT',
                                style: TextStyleConstant.black16RobotoBold,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.bookingDetail.value
                                    .groupServiceBookingDetailDtos!.length,
                                separatorBuilder: (context, index) => SizedBox(
                                    height: UtilsReponsive.height(context, 10)),
                                itemBuilder: (context, index) => Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .bookingDetail
                                            .value
                                            .groupServiceBookingDetailDtos![
                                                index]
                                            .serviceGroup!,
                                        style:
                                            TextStyleConstant.black14RobotoBold,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListView.separated(
                                          separatorBuilder: (context, index1) =>
                                              SizedBox(
                                                height: 5,
                                              ),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .bookingDetail
                                              .value
                                              .groupServiceBookingDetailDtos![
                                                  index]
                                              .serviceListBookingDetailDtos!
                                              .length,
                                          itemBuilder: (context, index1) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      controller
                                                          .bookingDetail
                                                          .value
                                                          .groupServiceBookingDetailDtos![
                                                              index]
                                                          .serviceListBookingDetailDtos![
                                                              index1]
                                                          .serviceName!,
                                                      style: TextStyle(
                                                          decoration: controller
                                                                  .bookingDetail
                                                                  .value
                                                                  .groupServiceBookingDetailDtos![
                                                                      index]
                                                                  .serviceListBookingDetailDtos![
                                                                      index1]
                                                                  .isNew!
                                                              ? TextDecoration
                                                                  .none
                                                              : TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.black54)),
                                                ),
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      controller
                                                          .bookingDetail
                                                          .value
                                                          .groupServiceBookingDetailDtos![
                                                              index]
                                                          .serviceListBookingDetailDtos![
                                                              index1]
                                                          .servicePrice!
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          decoration: controller
                                                                  .bookingDetail
                                                                  .value
                                                                  .groupServiceBookingDetailDtos![
                                                                      index]
                                                                  .serviceListBookingDetailDtos![
                                                                      index1]
                                                                  .isNew!
                                                              ? TextDecoration
                                                                  .none
                                                              : TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.black54)),
                                                ))
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'CHI TIẾT GIÁ TIỀN',
                                style: TextStyleConstant.black16RobotoBold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tổng tiền'),
                                  Text(
                                    controller.bookingDetail.value.totalPrice
                                        .toString(),
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                              controller.bookingDetail.value.discountPrice ==
                                      '0.000 VND'
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Giảm giá'),
                                        Text(
                                          controller
                                              .bookingDetail.value.discountPrice
                                              .toString(),
                                          style: TextStyleConstant
                                              .black16RobotoBold,
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số tiền tạm tính',
                                    style: TextStyleConstant.black16Roboto,
                                  ),
                                  Text(
                                    controller.bookingDetail.value.finalPrice
                                        .toString(),
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )))
          ],
        )));
  }

  void _launchDialPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
