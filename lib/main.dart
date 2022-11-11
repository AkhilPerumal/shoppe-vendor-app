import 'dart:async';
import 'dart:io';
import 'package:carclenx_vendor_app/controller/localization_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/controller/theme_controller.dart';
import 'package:carclenx_vendor_app/helper/notification_helper.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/theme/dark_theme.dart';
import 'package:carclenx_vendor_app/theme/light_theme.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:carclenx_vendor_app/util/messages.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controller/auth_controller.dart';
import 'helper/get_di.dart' as di;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (!GetPlatform.isWeb) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Map<String, Map<String, String>> _languages = await di.init();

  try {
    if (GetPlatform.isMobile) {
      // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      await NotificationHelper().setupInteractedMessage();
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  MyApp({@required this.languages});

  void _route() {
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<AuthController>().updateToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return GetMaterialApp(
            title: AppConstants.APP_NAME,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            initialRoute: RouteHelper.getSplashRoute(),
            getPages: RouteHelper.routes,
            defaultTransition: Transition.topLevel,
            transitionDuration: Duration(milliseconds: 500),
          );
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
