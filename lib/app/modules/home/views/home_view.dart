import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:me_car_garage/app/base/base_view.dart';
import 'package:me_car_garage/app/modules/account/views/account_view.dart';
import 'package:me_car_garage/app/modules/personal-information/views/personal_information_view.dart';
import 'package:me_car_garage/app/modules/qr_code.dart';
import 'package:me_car_garage/app/modules/start_app/controllers/start_app_controller.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';
import 'package:me_car_garage/app/resources/reponsive_utils.dart';
import 'package:me_car_garage/app/resources/text_style.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: UtilsReponsive.height(context, 60),
            width: UtilsReponsive.height(context, 60),
            child: FloatingActionButton(
                backgroundColor: ColorsManager.primary,
                onPressed: () async {
                  Get.to(QrView());
                  // Get.toNamed(Routes.BOOKING_DETAIL, arguments: "39");
                },
                child: SvgPicture.asset(IconAssets.qr_icon))),
        bottomNavigationBar: Container(
          height: UtilsReponsive.height(context, 64),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.swapTabScreen(true);
                },
                child: Obx(
                  () => Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          color: controller.swapTab.value
                              ? ColorsManager.primary
                              : Colors.black,
                          IconAssets.calendar_icon,
                          height: UtilsReponsive.height(context, 25),
                          width: UtilsReponsive.height(context, 25),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Lịch hẹn',
                          style: controller.swapTab.value
                              ? TextStyleConstant.primary14Roboto
                              : TextStyleConstant.black14Roboto,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: Text(
                      'Quét mã QR',
                      style: TextStyleConstant.black16Roboto,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.swapTabScreen(false);
                },
                child: Obx(() => Column(
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            color: !controller.swapTab.value
                                ? ColorsManager.primary
                                : Colors.black,
                            IconAssets.profile_icon,
                            height: UtilsReponsive.height(context, 30),
                            width: UtilsReponsive.height(context, 30),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Tài khoản',
                            style: !controller.swapTab.value
                                ? TextStyleConstant.primary14Roboto
                                : TextStyleConstant.black14Roboto,
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
        body: Obx(() => controller.swapTab.value
            ? _mainTab(context)
            : _accountTab(context)));
  }

  SafeArea _accountTab(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: UtilsReponsive.height(context, 40),
            ),
            Padding(
              padding: UtilsReponsive.paddingOnly(context, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tài Khoản Của Bạn",
                    style: TextStyleConstant.black22RobotoBold,
                  ),
                  const Spacer(),
                  SizedBox()
                ],
              ),
            ),
            Padding(
              padding: UtilsReponsive.paddingOnly(context,
                  left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(ImageAssets.user),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: UtilsReponsive.width(context, 200),
                          child: Text(
                            Get.find<StartAppController>().name.toString(),
                            style: TextStyleConstant.black16Roboto,
                          )),
                      SizedBox(
                        height: UtilsReponsive.height(context, 10),
                      ),
                      Text(
                        Get.find<StartAppController>().numberPhone.toString(),
                        style: TextStyleConstant.grey14Roboto,
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.PERSONAL_VIEW);
                    },
                    child: Container(
                      padding: UtilsReponsive.paddingAll(context, padding: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorsManager.primary,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Text("Sửa", style: TextStyleConstant.primary14Roboto),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: ColorsManager.primary,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: UtilsReponsive.paddingOnly(context,
                  left: 10, right: 10, top: 30),
              child: Text(
                "Cửa hàng đang làm việc",
                style: TextStyleConstant.black16RobotoBold,
              ),
            ),
            Container(
              margin: UtilsReponsive.paddingOnly(context,
                  left: 10, right: 10, top: 20),
              width: UtilsReponsive.width(context, 375),
              padding: UtilsReponsive.paddingAll(context, padding: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: UtilsReponsive.width(context, 47),
                    height: UtilsReponsive.width(context, 47),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssets.imgStore),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    width: UtilsReponsive.width(context, 15),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: UtilsReponsive.width(context, 200),
                            child: Text(
                              "Chi nhánh quận 6",
                              style: TextStyleConstant.black16Roboto,
                            )),
                        SizedBox(
                          height: UtilsReponsive.height(context, 10),
                        ),
                        Text(
                          "0123456789",
                          style: TextStyleConstant.grey14Roboto,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: UtilsReponsive.paddingOnly(context,
                  left: 10, right: 10, top: 30),
              child: Text(
                "Danh mục",
                style: TextStyleConstant.black16RobotoBold,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Get.find<StartAppController>().logout();
              },
              child: Container(
                margin: UtilsReponsive.paddingOnly(context,
                    left: 10, right: 10, top: 20),
                width: UtilsReponsive.width(context, 375),
                padding: UtilsReponsive.paddingAll(context, padding: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: UtilsReponsive.width(context, 47),
                      height: UtilsReponsive.width(context, 47),
                      child: SvgPicture.asset('assets/images/logout.svg'),
                    ),
                    SizedBox(
                      width: UtilsReponsive.width(context, 15),
                    ),
                    SizedBox(
                      width: UtilsReponsive.width(context, 200),
                      child: Text(
                        "Đăng xuất  ",
                        style: TextStyleConstant.black16Roboto,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      color: ColorsManager.primary,
                      size: UtilsReponsive.width(context, 20),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: UtilsReponsive.paddingOnly(context,
            //       left: 10, right: 10, top: 20),
            //   width: UtilsReponsive.width(context, 375),
            //   padding: UtilsReponsive.paddingAll(context, padding: 15),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 1,
            //       color: Colors.grey.withOpacity(0.2),
            //     ),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Container(
            //         width: UtilsReponsive.width(context, 47),
            //         height: UtilsReponsive.width(context, 47),
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: AssetImage(ImageAssets.imgPerson),
            //               fit: BoxFit.fill),
            //         ),
            //       ),
            //       SizedBox(
            //         width: UtilsReponsive.width(context, 15),
            //       ),
            //       SizedBox(
            //         width: UtilsReponsive.width(context, 200),
            //         child: Text(
            //           "Danh sách thợ  ",
            //           style: TextStyleConstant.black16Roboto,
            //         ),
            //       ),
            //       const Spacer(),
            //       Icon(
            //         Icons.arrow_forward,
            //         color: ColorsManager.primary,
            //         size: UtilsReponsive.width(context, 20),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: UtilsReponsive.paddingOnly(context,
            //       left: 10, right: 10, top: 30),
            //   child: Text(
            //     "Đăng xuất",
            //     style: TextStyleConstant.red16Roboto,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  SafeArea _mainTab(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Obx(() => Row(
                          children: [
                            Text(
                              controller.weekDay.toString(),
                              style: TextStyleConstant.black40RobotoBold,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              controller.dateFormat
                                  .format(controller.dateChoose.value),
                              style: TextStyleConstant.grey16RobotoBold,
                            )
                          ],
                        ))),
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    await controller.changeDate(DateTime.now());
                  },
                  child: Container(
                    height: UtilsReponsive.height(context, 40),
                    width: UtilsReponsive.width(context, 60),
                    decoration: BoxDecoration(
                        color: ColorsManager.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Hôm nay',
                      style: TextStyleConstant.primary16RobotoBold,
                    )),
                  ),
                ))
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                headerProps: EasyHeaderProps(
                  showHeader: false,
                ),
                locale: "vi",
                onDateChange: (selectedDate) async {
                  await controller.changeDate(selectedDate);
                  //[selectedDate] the new date selected.
                },
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  height: UtilsReponsive.height(context, 67),
                  width: UtilsReponsive.width(context, 40),
                  activeDayDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: ColorsManager.primary
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [

                      //   ],
                      // ),
                      ),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Text(
                  'Thời gian',
                  style: TextStyleConstant.grey14Roboto,
                )),
                Expanded(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Mô tả chi tiết',
                          style: TextStyleConstant.grey14Roboto,
                        ))),
                Icon(Icons.sort)
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.listBooking.value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.listBooking[index].hour
                                        .toString(),
                                    style: TextStyleConstant.black16RobotoBold,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      // height: 400,
                                      child: ListView.separated(
                                          primary: false,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index1) {
                                            return Container(
                                              height: UtilsReponsive.height(
                                                  context, 100),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Stack(
                                                children: [
                                                  Card(
                                                    surfaceTintColor:
                                                        ColorsManager.primary,
                                                    shadowColor:
                                                        ColorsManager.primary,
                                                    child: ListTile(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .BOOKING_DETAIL,
                                                            arguments: controller
                                                                .listBooking
                                                                .value[index]
                                                                .bookingListForStaffResponseDtos![
                                                                    index1]
                                                                .bookingId);
                                                      },
                                                      title: Text(
                                                        controller
                                                            .listBooking
                                                            .value[index]
                                                            .bookingListForStaffResponseDtos![
                                                                index1]
                                                            .carName
                                                            .toString(),
                                                        style: TextStyleConstant
                                                            .black16RobotoBold,
                                                      ),
                                                      subtitle: RichText(
                                                        text: new TextSpan(
                                                          children: <TextSpan>[
                                                            new TextSpan(
                                                              text: 'Chủ xe:',
                                                              style: TextStyleConstant
                                                                  .black14RobotoBold,
                                                            ),
                                                            new TextSpan(
                                                              text:
                                                                  '  ${controller.listBooking.value[index].bookingListForStaffResponseDtos![index1].customerName}',
                                                              style: TextStyleConstant
                                                                  .black14Roboto,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 10,
                                                      right: 10,
                                                      child:
                                                          Icon(Icons.more_vert))
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index1) =>
                                              SizedBox(
                                                height: 10,
                                              ),
                                          itemCount: controller
                                              .listBooking
                                              .value[index]
                                              .bookingListForStaffResponseDtos!
                                              .length)),
                                )
                              ],
                            ),
                          );
                        },
                      ),
              )),
        ],
      ),
    );
  }
}
