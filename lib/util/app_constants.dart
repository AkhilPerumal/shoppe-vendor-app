import 'package:carclenx_vendor_app/data/model/response/language_model.dart';
import 'package:carclenx_vendor_app/util/images.dart';

class AppConstants {
  static const String APP_NAME = 'Pexa Partner App';
  static const String APP_VERSION = '2.0.0';

  // static const String BASE_URL = 'https://stagingshoppe.carclenx.com/v1.0';
  static const String BASE_URL = 'https://shoppe.carclenx.com/v1.0';
  static const String CONFIG_URI = '/api/v1/config';
  static const String FORGET_PASSWORD_URI =
      '/api/v1/auth/delivery-man/forgot-password';
  static const String VERIFY_TOKEN_URI =
      '/api/v1/auth/delivery-man/verify-token';
  static const String RESET_PASSWORD_URI =
      '/api/v1/auth/delivery-man/reset-password';

  // Auth
  static const String LOGIN_URI = '/auth/sign-in';
  static const String SIGNUP_URI = '/partner/partner-registration';
  static const String STATE_DISTRICT =
      '/partner/partner-registration/states-data';
  static const String UPDATE_DOCUMENTATION =
      '/partner/partner-registration/id/';
  static const String UPLOAD_REG_DOC_IMAGE =
      '/partner/partner-registration/upload';
  static const String PROFILE_URI = '/partner/user/id/';

  // Initial
  static const String TOKEN_URI = '/notification';
  static const String ALL_ORDERS_URI = '/partner/franchise/all';
  static const String WORKER_WORK_DETAILS =
      '/partner/mechanical-order/franchise/all-data-combined';

//shoppe manage
  static const String ALL_CATEGORY_LIST =
      '/partner/consolidated/makes-models-cats-subcats';
  static const String MY_PRODUCT_LIST = '/partner/product/vendor/';
  static const String SINGLE_PRODUCT = '/partner/product/id/';
  static const String UPDATE_PRODUCT_QUANTITY = '/partner/product/id/';
  static const String UPDATE_PRODUCT = '/partner/product/id/';
  static const String CREATE_PRODUCT = '/partner/product/';
  static const String UPLOAD_PRODUCT_IMAGE = '/partner/product/upload';

  // Order
  static const String CARSPA_ORDER_STATUS_UPDATE_URI =
      '/partner/carspa-order/status/';
  static const String MECHANICS_ORDER_STATUS_UPDATE_URI =
      '/partner/mechanical-order/status/';
  static const String QUICKHELP_ORDER_STATUS_UPDATE_URI =
      '/partner/quickhelp-order/status/';
  static const String SHOPPE_ORDER_STATUS_UPDATE_URI = '/partner/order/id/';
  static const String CARSPA_SINGLE_ORDER_DETAILS = '/partner/carspa-order/id/';
  static const String MECHANICAL_SINGLE_ORDER_DETAILS =
      '/partner/mechanical-order/id/';
  static const String QUICKHELP_SINGLE_ORDER_DETAILS =
      '/partner/quickhelp-order/id/';
  static const String SHOPPE_SINGLE_ORDER_DETAILS = '/partner/order/id/';

  // Notification
  static const String NOTIFICATION_URI = '/notification/user/all?type=';

  static const String CURRENT_ORDERS_URI =
      '/api/v1/delivery-man/current-orders?token=';
  static const String LATEST_ORDERS_URI =
      '/api/v1/delivery-man/latest-orders?token=';
  static const String RECORD_LOCATION_URI =
      '/api/v1/delivery-man/record-location-data';
  static const String UPDATE_ORDER_STATUS_URI =
      '/api/v1/delivery-man/update-order-status';
  static const String UPDATE_PAYMENT_STATUS_URI =
      '/api/v1/delivery-man/update-payment-status';
  static const String ORDER_DETAILS_URI =
      '/api/v1/delivery-man/order-details?token=';
  static const String ACCEPT_ORDER_URI = '/api/v1/delivery-man/accept-order';
  static const String ACTIVE_STATUS_URI =
      '/api/v1/delivery-man/update-active-status';
  static const String UPDATE_PROFILE_URI =
      '/api/v1/delivery-man/update-profile';
  static const String DRIVER_REMOVE =
      '/api/v1/delivery-man/remove-account?token=';
  static const String CURRENT_ORDER_URI = '/api/v1/delivery-man/order?token=';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'carclenx_vendor_app_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String LOGIN_USER_PASSWORD = 'login_user_password';
  static const String LOGIN_USER_NAME = 'login_user_name';
  static const String USER_NAME = 'user_name';
  static const String USER_ID = 'user_id';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_EMAIL = 'user_email';
  static const String PROVIDES = 'provides';
  static const String ROLES = 'roles';
  static const String IS_ACTIVE = 'is_active';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String IGNORE_LIST = 'ignore_list';
  static const String TOPIC = 'all_zone_delivery_man';
  static const String ZONE_TOPIC = 'zone_topic';
  static const String LOCALIZATION_KEY = 'X-localization';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
