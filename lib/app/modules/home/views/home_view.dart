import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:me_car_garage/app/base/base_view.dart';
import 'package:me_car_garage/app/modules/qr_code.dart';
import 'package:me_car_garage/app/resources/assets_manager.dart';
import 'package:me_car_garage/app/resources/color_manager.dart';
import 'package:me_car_garage/app/resources/reponsive_utils.dart';
import 'package:me_car_garage/app/resources/text_style.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          height: UtilsReponsive.height(context, 60),
          width: UtilsReponsive.height(context, 60),
          child: FloatingActionButton(
              backgroundColor: ColorsManager.primary,
              onPressed: () async {
                Get.to(QrView());
              },
              child: SvgPicture.asset(IconAssets.qr_icon))),
      bottomNavigationBar: Container(
        height: UtilsReponsive.height(context, 64),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    IconAssets.calendar_icon,
                    height: UtilsReponsive.height(context, 25),
                    width: UtilsReponsive.height(context, 25),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Lịch hẹn',
                    style: TextStyleConstant.primary14Roboto,
                  ),
                )
              ],
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
                  child: SvgPicture.asset(
                    IconAssets.profile_icon,
                    height: UtilsReponsive.height(context, 30),
                    width: UtilsReponsive.height(context, 30),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tài khoản',
                    style: TextStyleConstant.black14Roboto,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
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
                      child: Row(
                        children: [
                          Text(
                            '24',
                            style: TextStyleConstant.black40RobotoBold,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              children: <TextSpan>[
                                new TextSpan(text: 'Thứ 4\n'),
                                new TextSpan(
                                  text: 'Tháng 5, 2023',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Expanded(
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
                  ))
                ],
              ),
            )),
            Expanded(
              child: EasyDateTimeLine(
                headerProps: EasyHeaderProps(
                  showHeader: false,
                ),
                locale: "vi",
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,),
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '10:00',
                              style: TextStyleConstant.black16RobotoBold,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                // height: 400,
                                child: ListView.separated(
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: UtilsReponsive.height(context, 100),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Stack(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                'AUDI A5 2015',
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
                                                      text: '  Nguyễn Văn A',
                                                      style: TextStyleConstant
                                                          .black14Roboto,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Icon(Icons.more_vert))
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: 3)),
                          )
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
