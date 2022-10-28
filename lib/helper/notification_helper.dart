import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        new AndroidInitializationSettings('notification_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'pexapartner', // id
        'High Importance Notifications', // title
        description: 'For recieving order',
        enableLights: true,
        enableVibration: true,
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification'),
        showBadge: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      // String _type = message.notification.bodyLocKey;
      // String _orderID = message.notification.titleLocKey;
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      // if (_type == 'new_order') {
      //   //_orderCount = _orderCount + 1;
      //   Get.dialog(NewRequestDialog(
      //       isRequest: true, onTap: () => _navigateRequestPage()));
      // } else if (_type == 'assign' && _orderID != null && _orderID.isNotEmpty) {
      //   Get.dialog(
      //       NewRequestDialog(isRequest: false, onTap: () => _setPage(0)));
      // } else if (_type == 'block') {
      //   Get.find<AuthController>().clearSharedData();
      //   Get.find<AuthController>().stopLocationRecord();
      //   Get.offAllNamed(RouteHelper.getSignInRoute());
      // }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String _title;
      String _body;
      String _orderID;
      String _image;
      if (data) {
        _title = message.data['title'];
        _body = message.data['body'];
        _orderID = message.data['order_id'];
        _image = (message.data['image'] != null &&
                message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http')
                ? message.data['image']
                : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}'
            : null;
      } else {
        _title = message.notification.title;
        _body = message.notification.body;
        _orderID = message.notification.titleLocKey;
        if (GetPlatform.isAndroid) {
          _image = (message.notification.android.imageUrl != null &&
                  message.notification.android.imageUrl.isNotEmpty)
              ? message.notification.android.imageUrl.startsWith('http')
                  ? message.notification.android.imageUrl
                  : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.android.imageUrl}'
              : null;
        } else if (GetPlatform.isIOS) {
          _image = (message.notification.apple.imageUrl != null &&
                  message.notification.apple.imageUrl.isNotEmpty)
              ? message.notification.apple.imageUrl.startsWith('http')
                  ? message.notification.apple.imageUrl
                  : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.apple.imageUrl}'
              : null;
        }
      }

      if (_image != null && _image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              _title, _body, _orderID, _image, fln);
        } catch (e) {
          await showBigTextNotification(_title, _body, _orderID, fln);
        }
      } else {
        await showBigTextNotification(_title, _body, _orderID, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexapartner',
      'pexapartner',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexapartner',
      'pexapartner',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String orderID,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexapartner',
      'pexapartner',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
  // var androidInitialize =
  //     new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(
  //     android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(
  //     message, flutterLocalNotificationsPlugin, true);
}
