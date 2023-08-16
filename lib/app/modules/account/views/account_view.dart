import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:me_car_garage/app/base/base_view.dart';
import 'package:me_car_garage/app/modules/home/views/home_view.dart';
import 'package:me_car_garage/app/modules/personal-information/views/personal_information_view.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';
import 'package:me_car_garage/app/resources/reponsive_utils.dart';
import 'package:me_car_garage/app/resources/text_style.dart';
import 'package:me_car_garage/app/routes/app_pages.dart';
import '../../qr_code.dart';
import '../controllers/account_controller.dart';

class AccountView extends BaseView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
//
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
                Get.to(HomeView());
              },
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      IconAssets.icCalendarDeActive,
                      height: UtilsReponsive.height(context, 25),
                      width: UtilsReponsive.height(context, 25),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Lịch hẹn',
                      style: TextStyleConstant.black14Roboto,
                    ),
                  )
                ],
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
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: UtilsReponsive.height(context, 30),
                    width: UtilsReponsive.height(context, 30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            IconAssets.icProfileActive,
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tài khoản',
                    style: TextStyleConstant.primary14Roboto,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Material(
        child: Container(
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
                  padding:
                      UtilsReponsive.paddingOnly(context, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tài Khoản Của Bạn",
                        style: TextStyleConstant.black22RobotoBold,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: UtilsReponsive.height(context, 30),
                      ),
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
                      Container(
                        width: UtilsReponsive.width(context, 60),
                        height: UtilsReponsive.height(context, 60),
                        margin: UtilsReponsive.paddingOnly(context, right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: UtilsReponsive.width(context, 200),
                              child: Text(
                                "Nguyễn Huỳnh Vân Anh",
                                style: TextStyleConstant.black16Roboto,
                              )),
                          SizedBox(
                            height: UtilsReponsive.height(context, 10),
                          ),
                          Text(
                            "nhvanh@gmail.com",
                            style: TextStyleConstant.grey14Roboto,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.to(PersonalInformationView());
                        },
                        child: Container(
                          padding:
                              UtilsReponsive.paddingAll(context, padding: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorsManager.primary,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Text("Sửa",
                                  style: TextStyleConstant.primary14Roboto),
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
                              image: AssetImage(ImageAssets.imgPerson),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(
                        width: UtilsReponsive.width(context, 15),
                      ),
                      SizedBox(
                        width: UtilsReponsive.width(context, 200),
                        child: Text(
                          "Danh sách thợ  ",
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
                              image: AssetImage(ImageAssets.imgPerson),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(
                        width: UtilsReponsive.width(context, 15),
                      ),
                      SizedBox(
                        width: UtilsReponsive.width(context, 200),
                        child: Text(
                          "Danh sách thợ  ",
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
                Padding(
                  padding: UtilsReponsive.paddingOnly(context,
                      left: 10, right: 10, top: 30),
                  child: Text("Đăng xuất", style: TextStyleConstant.red16Roboto,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
