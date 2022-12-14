import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/view/screens/auth/approval_waiting_screen.dart';
import 'package:carclenx_vendor_app/view/screens/auth/registration_screen.dart';
import 'package:carclenx_vendor_app/view/screens/auth/sign_in_screen.dart';
import 'package:carclenx_vendor_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:carclenx_vendor_app/view/screens/html/html_viewer_screen.dart';
import 'package:carclenx_vendor_app/view/screens/infoPage/infoPage.dart';
import 'package:carclenx_vendor_app/view/screens/language/language_screen.dart';
import 'package:carclenx_vendor_app/view/screens/notification/notification_screen.dart';
import 'package:carclenx_vendor_app/view/screens/order/running_order_screen.dart';
import 'package:carclenx_vendor_app/view/screens/profile/update_profile_screen.dart';
import 'package:carclenx_vendor_app/view/screens/service_order/service_order_details_screen.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_order/shoppe_order_details_screen.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/add_product_screen.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/my_product_details_screen.dart';
import 'package:carclenx_vendor_app/view/screens/splash/splash_screen.dart';
import 'package:carclenx_vendor_app/view/screens/update/update_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String approvalWaiting = '/approval-waiting-screen';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String serviceOrderDetails = '/service-order-details';
  static const String shoppeOrderDetails = '/shoppe-order-details';
  static const String updateProfile = '/update-profile';
  static const String notification = '/notification';
  static const String runningOrder = '/running-order';
  static const String terms = '/terms-and-condition';
  static const String privacy = '/privacy-policy';
  static const String language = '/language';
  static const String update = '/update';
  static const String info = '/info-page';
  static const String addProduct = '/add-new-product';
  static const String myProductDetails = '/my-product-details';
  static const String editProduct = '/edit-product-details';

  static String getInitialRoute() => '$initial';
  static String getSplashRoute() => '$splash';
  static String getSignInRoute() => '$signIn';
  static String getVerificationRoute(String number) =>
      '$verification?number=$number';
  static String getMainRoute(String page) => '$main?page=$page';
  static String getForgotPassRoute() => '$forgotPassword';
  static String getResetPasswordRoute(
          String phone, String token, String page) =>
      '$resetPassword?phone=$phone&token=$token&page=$page';
  static String getOrderDetailsRoute(String id) =>
      '$serviceOrderDetails?id=$id';
  static String getUpdateProfileRoute() => '$updateProfile';
  static String getNotificationRoute() => '$notification';
  static String getRunningOrderRoute() => '$runningOrder';
  static String getTermsRoute() => '$terms';
  static String getPrivacyRoute() => '$privacy';
  static String getLanguageRoute() => '$language';
  static String getUpdateRoute(bool isUpdate) =>
      '$update?update=${isUpdate.toString()}';
  static String getInfoPage(String page) => '$info?page=$page';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          int pageNo = 0;
          if (Get.arguments != null && Get.arguments['pageNo'] != null) {
            pageNo = Get.arguments['pageNo'];
          } else {
            pageNo = 0;
          }
          return DashboardScreen(pageIndex: pageNo);
        }),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(
        name: signUp,
        page: () {
          bool fromSignIn = true;
          if (Get.arguments['fromSignIn'] != null) {
            fromSignIn = Get.arguments['fromSignIn'];
          }
          return RegistrationScreen(
            fromSignIn: fromSignIn,
          );
        }),
    GetPage(name: approvalWaiting, page: () => ApprovalWaitingScreen()),
    GetPage(
        name: main,
        page: () => DashboardScreen(
              pageIndex: Get.parameters['page'] == 'home'
                  ? 0
                  : Get.parameters['page'] == 'order-request'
                      ? 1
                      : Get.parameters['page'] == 'order'
                          ? 2
                          : Get.parameters['page'] == 'profile'
                              ? 3
                              : 0,
            )),
    GetPage(
        name: serviceOrderDetails,
        page: () {
          return ServiceOrderDetailsScreen(
            isRunningOrder: Get.arguments['isRunningOrder'],
          );
        }),
    GetPage(
        name: shoppeOrderDetails,
        page: () {
          return ShoppeOrderDetailsScreen();
        }),
    GetPage(name: updateProfile, page: () => UpdateProfileScreen()),
    GetPage(
        name: notification,
        page: () {
          return NotificationScreen();
        }),
    GetPage(name: runningOrder, page: () => RunningOrderScreen()),
    GetPage(name: terms, page: () => HtmlViewerScreen(isPrivacyPolicy: false)),
    GetPage(name: privacy, page: () => HtmlViewerScreen(isPrivacyPolicy: true)),
    GetPage(name: language, page: () => ChooseLanguageScreen()),
    GetPage(name: addProduct, page: () => AddProductScreen()),
    GetPage(name: myProductDetails, page: () => MyProductDetailsScreen()),
    GetPage(
        name: editProduct,
        page: () => AddProductScreen(
              isEdit: true,
            )),
    GetPage(
        name: update,
        page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(
        name: info,
        page: () => InformationPage(
              title: Get.parameters['page'],
            )),
  ];
}
