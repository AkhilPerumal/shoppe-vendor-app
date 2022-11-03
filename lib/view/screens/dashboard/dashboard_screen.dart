import 'package:carclenx_vendor_app/controller/active_order_tab_controller.dart';
import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/controller/order_history_tab_controller.dart';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/notification_helper.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/view/base/custom_alert_dialog.dart';
import 'package:carclenx_vendor_app/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:carclenx_vendor_app/view/screens/dashboard/widget/new_request_dialog.dart';
import 'package:carclenx_vendor_app/view/screens/home/home_screen.dart';
import 'package:carclenx_vendor_app/view/screens/order/order_request_screen.dart';
import 'package:carclenx_vendor_app/view/screens/profile/profile_screen.dart';
import 'package:carclenx_vendor_app/view/screens/order/order_history_screen.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/shoppe_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  final _channel = const MethodChannel('com.pexa/app_retain');
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //Timer _timer;
  //int _orderCount;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      OrderRequestScreen(onTap: () => _setPage(0)),
      ShoppeScreen(),
      OrderScreen(),
      ProfileScreen(),
    ];

    // var androidInitialize = AndroidInitializationSettings('notification_icon');
    // var iOSInitialize = IOSInitializationSettings();
    // var initializationsSettings =
    //     InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // if(Get.find<OrderController>().latestOrderList != null) {
    //   //   _orderCount = Get.find<OrderController>().latestOrderList.length;
    //   // }
    //   print("onMessage: ${message.data}");
    //   String _type = message.notification.bodyLocKey;
    //   String _orderID = message.notification.titleLocKey;
    //   if (_type != 'assign' && _type != 'new_order') {
    //     NotificationHelper.showNotification(
    //         message, flutterLocalNotificationsPlugin, false);
    //   }
    //   if (_type == 'new_order') {
    //     //_orderCount = _orderCount + 1;
    //     Get.dialog(NewRequestDialog(
    //         isRequest: true, onTap: () => _navigateRequestPage()));
    //   } else if (_type == 'assign' && _orderID != null && _orderID.isNotEmpty) {
    //     Get.dialog(
    //         NewRequestDialog(isRequest: false, onTap: () => _setPage(0)));
    //   } else if (_type == 'block') {
    //     Get.find<AuthController>().clearSharedData();
    //     Get.find<AuthController>().stopLocationRecord();
    //     Get.offAllNamed(RouteHelper.getSignInRoute());
    //   }
    // });

    // _timer = Timer.periodic(Duration(seconds: 30), (timer) async {
    //   await Get.find<OrderController>().getLatestOrders();
    //   int _count = Get.find<OrderController>().latestOrderList.length;
    //   if(_orderCount != null && _orderCount < _count) {
    //     Get.dialog(NewRequestDialog(isRequest: true, onTap: () => _navigateRequestPage()));
    //   }else {
    //     _orderCount = Get.find<OrderController>().latestOrderList.length;
    //   }
    // });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer?.cancel();
  // }

  void _navigateRequestPage() {
    if (Get.find<AuthController>().isLoggedIn() &&
        Get.find<OrderController>().runningOrderList != null &&
        Get.find<OrderController>().runningOrderList.length < 1) {
      Get.dialog(CustomAlertDialog(
          description: 'you_have_running_order'.tr,
          onOkPressed: () => Get.back()));
    } else {
      if (Get.find<AuthController>().userModel == null ||
          Get.find<AuthController>().userModel.isActive == false) {
        Get.dialog(CustomAlertDialog(
            description: 'you_are_offline_now'.tr,
            onOkPressed: () => Get.back()));
      } else {
        _setPage(1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (GetPlatform.isAndroid &&
              Get.find<AuthController>().userModel.isActive == true) {
            _channel.invokeMethod('sendToBackground');
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        floatingActionButton: !GetPlatform.isMobile
            ? null
            : FloatingActionButton(
                elevation: 5,
                backgroundColor: _pageIndex == 2
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                onPressed: () {
                  Get.find<ShoppeController>().getMyProducts("1");
                  _setPage(2);
                },
                child: Icon(
                  Icons.add_business_rounded,
                  size: 20,
                  color: _pageIndex == 2
                      ? Theme.of(context).cardColor
                      : Theme.of(context).disabledColor,
                ),
              ),
        floatingActionButtonLocation: !GetPlatform.isMobile
            ? null
            : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(children: [
              BottomNavItem(
                  iconData: Icons.home,
                  isSelected: _pageIndex == 0,
                  onTap: () => _setPage(0)),
              BottomNavItem(
                  iconData: Icons.list_alt_rounded,
                  isSelected: _pageIndex == 1,
                  onTap: () {
                    Get.find<ActiveOrderTabController>()
                        .setTabIndex(index: 0, subTabType: SubTabType.NEW);
                    _setPage(1);
                    // _navigateRequestPage();
                  }),
              Expanded(child: SizedBox()),
              BottomNavItem(
                  iconData: Icons.history,
                  isSelected: _pageIndex == 3,
                  onTap: () {
                    Get.find<OrderHistoryTabController>().setTabIndex(
                        index: 0, subTabType: SubTabType.COMPELTED);

                    _setPage(3);
                  }),
              BottomNavItem(
                  iconData: Icons.person,
                  isSelected: _pageIndex == 4,
                  onTap: () => _setPage(4)),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
