import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_car_garage/app/base/base_view.dart';
import 'package:me_car_garage/app/model/booking-overall-detail.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';
import 'package:me_car_garage/app/resources/reponsive_utils.dart';
import 'package:me_car_garage/app/resources/text_style.dart';
import 'package:quickalert/quickalert.dart';

import '../controllers/booking_detail_service_controller.dart';

class BookingDetailServiceView
    extends BaseView<BookingDetailServiceController> {
  const BookingDetailServiceView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: 
      //  Obx(() {
      //     return
           Container(
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
                      backgroundColor:
                          MaterialStateProperty.all(ColorsManager.primary),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    ),
                    child: Text(
                    "Hoàn thành đơn",
                      style: TextStyleConstant.white16Roboto,
                    ),
                    onPressed: () async {
                    await controller.completeBoooking();
                      // await controller.changeStatus();
                    },
                  ))
                  ),
        // }),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          'Chi tiết đơn hàng',
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
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(UtilsReponsive.height(context, 10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.bookingOverallDetail.value.carName
                              .toString(),
                          style: TextStyleConstant.primary30RobotoBold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateFormat('EEEE, dd-MM-yyyy', 'vi_VN').format(
                              DateFormat('dd-MM-yyyy').parse(controller
                                  .bookingOverallDetail.value.bookingDay!)),
                          style: TextStyleConstant.grey14Roboto,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              leading: ClipOval(
                                child: CachedNetworkImage(
                                  height: UtilsReponsive.height(context, 60),
                                  width: UtilsReponsive.height(context, 60),
                                  fit: BoxFit.fill,
                                  imageUrl: controller.bookingOverallDetail
                                      .value.customerImage??"",
                                  errorWidget: (context, url, error) =>
                                      Image.asset(ImageAssets.user),
                                  placeholder: (context, url) =>
                                      Image.asset(ImageAssets.user),
                                ),
                              ),
                              title: RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: 'Chủ xe\n',
                                      style: TextStyleConstant.grey14Roboto,
                                    ),
                                    new TextSpan(
                                      text:
                                          '\n${controller.bookingOverallDetail.value.customerName}',
                                      style:
                                          TextStyleConstant.black14RobotoBold,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Expanded(
                                child: ListTile(
                              leading: CircleAvatar(
                                radius: UtilsReponsive.height(context, 40),
                                backgroundColor:ColorsManager.primary,
                                child: SvgPicture.asset('assets/icons/calendar2.svg',fit: BoxFit.fill,)
                              ),
                              title: RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: 'Thời gian\n',
                                      style: TextStyleConstant.grey14Roboto,
                                    ),
                                    new TextSpan(
                                      text:
                                          '\n${controller.bookingOverallDetail.value.duration}',
                                      style:
                                          TextStyleConstant.black14RobotoBold,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                          Text("Thợ phụ trách",
                              style: TextStyleConstant.black18RobotoBold),
                          SizedBox(
                            height: 15,
                          ),
                          Obx(() => controller.bookingOverallDetail.value.mechanicServiceStatusForStaffDtos!.isEmpty?Text("Đơn hàng chưa được phân bổ cho thợ")
                          :
                          Container(
                              height: UtilsReponsive.height(context, 100),
                              width: double.infinity,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                itemCount: controller.bookingOverallDetail.value.mechanicServiceStatusForStaffDtos!.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          UtilsReponsive.width(context, 15),
                                      vertical:
                                          UtilsReponsive.width(context, 5)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Colors.white, // Màu nền của container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.5), // Màu của đổ bóng
                                        spreadRadius: 0.5, // Độ dài của đổ bóng
                                        blurRadius: 7, // Độ mờ của đổ bóng
                                        offset: Offset(
                                            0, 3), // Độ tịnh tiến của đổ bóng
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          height: UtilsReponsive.height(
                                              context, 50),
                                          width: UtilsReponsive.height(
                                              context, 50),
                                          imageUrl: controller
                                                  .bookingOverallDetail.value.mechanicServiceStatusForStaffDtos![index].mechanicImage ??
                                              "",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(ImageAssets.user),
                                        ),
                                      ),
                                      Text(controller
                                          .bookingOverallDetail.value.mechanicServiceStatusForStaffDtos![index].mechanicName
                                          .toString()),
                                    controller
                                          .bookingOverallDetail.value.mechanicServiceStatusForStaffDtos![index]
                                              .isMainMechanic!
                                          ? Text("(Thợ chính)")
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              )),
                          ),
                            SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Cập nhật dịch vụ",
                          style: TextStyleConstant.black22RobotoBold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => controller.refreshData.value
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: SingleChildScrollView(),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                              physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                itemCount: controller.bookingOverallDetail.value
                                    .serviceStatusForStaffDtos!.length,
                                itemBuilder: (context, index) {
                                  ServiceStatusForStaffDto object = controller
                                      .bookingOverallDetail
                                      .value
                                      .serviceStatusForStaffDtos![index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (object.bookingServiceStatus ==
                                          'NotStart') {
                                        controller.statusChoice.value =
                                            "Đang chờ";
                                        Get.bottomSheet(
                                          StatefulBuilder(
                                            builder: (context, setState) =>
                                                Container(
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListView.separated(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20),
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                      height: 10,
                                                    ),
                                                    itemCount: controller
                                                        .listStatus.length,
                                                    itemBuilder:
                                                        (context, index1) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              controller
                                                                  .chooseStatus(
                                                                      index1);
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  UtilsReponsive
                                                                      .width(
                                                                          context,
                                                                          20),
                                                              vertical:
                                                                  UtilsReponsive
                                                                      .width(
                                                                          context,
                                                                          10)),
                                                          // height: UtilsReponsive.height(context, 60),
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(
                                                                  UtilsReponsive
                                                                      .height(
                                                                          context,
                                                                          25)),
                                                              border: Border.all(
                                                                  color: ColorsManager
                                                                      .primary)),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(controller
                                                                  .getPathStatus(controller
                                                                      .listStatus[
                                                                          index1]
                                                                      .toString())),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                  child: Text(
                                                                controller
                                                                    .listStatus[
                                                                        index1]
                                                                    .toString(),
                                                                style: TextStyleConstant
                                                                    .black16RobotoBold,
                                                                maxLines: 2,
                                                              )),
                                                              Obx(() => Icon(
                                                                    controller.statusChoice.value ==
                                                                            controller.listStatus[
                                                                                index1]
                                                                        ? Icons
                                                                            .radio_button_checked_outlined
                                                                        : Icons
                                                                            .radio_button_off,
                                                                    color: ColorsManager
                                                                        .primary,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 40),
                                                      child: ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints
                                                                .tightFor(
                                                                    width: context
                                                                        .width),
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    ColorsManager
                                                                        .primary),
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all(EdgeInsets
                                                                        .all(
                                                                            14)),
                                                          ),
                                                          child: Text(
                                                            "Cập nhật",
                                                            style: TextStyleConstant
                                                                .white16Roboto,
                                                          ),
                                                          onPressed: () async {
                                                            controller.updateStatusService(
                                                                controller
                                                                    .statusChoice
                                                                    .toString(),
                                                                index);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              UtilsReponsive.width(context, 20),
                                          vertical: UtilsReponsive.width(
                                              context, 10)),
                                      // height: UtilsReponsive.height(context, 60),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              UtilsReponsive.height(
                                                  context, 25)),
                                          border: Border.all(
                                              color: ColorsManager.primary)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              controller.getPathStatus(object
                                                  .bookingServiceStatus
                                                  .toString())),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text(
                                            object.serviceName.toString(),
                                            style: TextStyleConstant
                                                .black16RobotoBold,
                                            maxLines: 2,
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                              SizedBox(height: UtilsReponsive.height(context, 20),)
                      ],
                    ),
                  ),
                ),
        ),
      )
    ])));
  }
}
