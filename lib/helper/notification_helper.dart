import 'dart:convert';
import 'dart:io';

import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/body/notification_payload_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // navigateTo(Payload.fromJson(message.data));
    });
    enableIOSNotifications();
    await registerNotificationListeners();
  }

  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('notification_icon');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      // onDidReceiveNotificationResponse: (NotificationResponse details) {
      //   print(details.payload.toString());
      // },
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   print(details.payload.toString());
      // },
    );
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // homeController.getHomeData(
      //   withLoading: false,
      // );
      print('firebase_message' + message.toString());
      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        // flutterLocalNotificationsPlugin.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       channelDescription: channel.description,
        //       playSound: true,
        //       importance: Importance.high,
        //       priority: Priority.high,
        //       color: Theme.of(Get.context).primaryColor,
        //       sound: RawResourceAndroidNotificationSound('notification'),
        //     ),
        //   ),
        // );
        showNotification(message, flutterLocalNotificationsPlugin, false);
      }
    });
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'pexa_partner', // id
        'pexapartner', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification'),
      );

  Future<void> showNotification(RemoteMessage message,
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

  Future<void> showTextNotification(String title, String body, String payload,
      FlutterLocalNotificationsPlugin fln) async {
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

  Future<void> showBigTextNotification(String title, String body,
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

  Future<void> showBigPictureNotificationHiddenLargeIcon(
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

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void onDidReceiveLocalNotification(
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

  void navigateTo(Payload payload) {
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
  void notificationTapBackground(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      navigateTo(Payload.fromJson(json.decode(notificationResponse.payload)));
    }
  }
}

enableIOSNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

androidNotificationChannel() => AndroidNotificationChannel(
      'pexa_partner', // id
      'pexapartner', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
}
