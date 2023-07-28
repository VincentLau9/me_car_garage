import 'package:get/get.dart';
import 'package:me_car_garage/app/base/base_bindings.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
