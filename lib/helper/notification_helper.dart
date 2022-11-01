import 'dart:convert';
import 'dart:io';

import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/body/notification_payload_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var iOSInitialize = new DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

// when app is closed
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      navigateTo(
          Payload.fromJson(jsonDecode(details.notificationResponse.payload)));
    }

    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null &&
            notificationResponse.payload != '') {
          navigateTo(
              Payload.fromJson(jsonDecode(notificationResponse.payload)));
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final bool result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'pexa_partner', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max, enableVibration: true, playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigateTo(Payload.fromJson(message.data));
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String _title;
      String _body;
      String _payload;
      String _image;
      if (data) {
        _title = message.notification.title;
        _body = message.data['description'];
        _payload = json.encode(message.data);
        _image = (message.data['image'] != null &&
                message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http')
                ? message.data['image']
                : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}'
            : null;
      } else {
        _title = message.notification.title;
        _body = message.notification.body;
        _payload = json.encode(message.data);
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
              _title, _body, _payload, _image, fln);
        } catch (e) {
          await showBigTextNotification(_title, _body, _payload, fln);
        }
      } else {
        await showBigTextNotification(_title, _body, _payload, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body,
      String payload, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexa_partner',
      'pexapartner',
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
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
      'pexa_partner',
      'pexapartner',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
      color: Theme.of(Get.context).primaryColor,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String payload,
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
      'pexa_partner',
      'pexapartner',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.high,
      color: Theme.of(Get.context).primaryColor,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
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

  static void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    showDialog(
      context: Get.context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  static void navigateTo(Payload payload) {
    if (payload.assetType == CategoryType.CAR_SHOPPE) {
      Get.find<OrderController>()
          .getOrderWithId(payload.id, payload.assetType)
          .then((value) => Get.toNamed(RouteHelper.shoppeOrderDetails));
    } else if (payload.assetType == CategoryType.CAR_SPA ||
        payload.assetType == CategoryType.CAR_MECHANIC ||
        payload.assetType == CategoryType.QUICK_HELP) {
      Get.find<OrderController>()
          .getOrderWithId(payload.id, payload.assetType)
          .then((value) => Get.toNamed(RouteHelper.serviceOrderDetails,
              arguments: {'isRunningOrder': true}));
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      navigateTo(Payload.fromJson(json.decode(notificationResponse.payload)));
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
}
