import 'package:get/get.dart';
import 'package:me_car_garage/app/modules/personal-information/bindings/personal_information_binding.dart';
import 'package:me_car_garage/app/modules/personal-information/views/personal_information_view.dart';

import '../modules/booking-detail-service/bindings/booking_detail_service_binding.dart';
import '../modules/booking-detail-service/views/booking_detail_service_view.dart';
import '../modules/booking-detail/bindings/booking_detail_binding.dart';
import '../modules/booking-detail/views/booking_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sign-in/bindings/sign_in_binding.dart';
import '../modules/sign-in/views/sign_in_view.dart';
import '../modules/start_app/bindings/startt_app_binding.dart';
import '../modules/start_app/views/start_app_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START_APP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.START_APP,
      page: () => const StartAppView(),
      binding: StartAppBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAIL,
      page: () => const BookingDetailView(),
      binding: BookingDetailBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAIL_SERVICE,
      page: () => const BookingDetailServiceView(),
      binding: BookingDetailServiceBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_VIEW,
      page: () => const PersonalInformationView(),
      binding: PersonalInformationBinding(),
    ),
  ];
}
