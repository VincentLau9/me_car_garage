class BaseLink {
  static const updateInfo =domain+ 'api/user/update-user';
  static const domain = 'https://carserviceappservice.azurewebsites.net/';
  static const login = domain + 'api/authentication/login';
  static const LOADING_BOOKING_DETAIL = domain + 'api/booking/detail-booking-for-staff/';
  static const UPDATE_STATUS = domain + 'api/booking/update-status-booking/';
  static const UPDATE_STATUS_BOOKINGDETAIL = domain + 'api/booking/update-booking-detail-status/';

  static const GET_BOOKING = domain +"api/booking/get-booking-by-date-for-staff?date=";
  static const GET_PROFILE = domain +"api/user/detail-customer/";

  static const REFESH_TOKEN = domain + 'api/authentication/refresh-token-mobile';
  static const GET_BOOKING_SERVICE_DETAIL = domain +"api/booking/get-booking-detail-status-by-booking-staff/";
//
}
