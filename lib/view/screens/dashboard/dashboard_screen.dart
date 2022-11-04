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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      if (Get.currentRoute == RouteHelper.shoppeOrderDetails &&
          Get.find<OrderController>().selectedShoppeOrder != null &&
          Get.find<OrderController>().selectedShoppeOrder.id ==
              message.data['_id']) {
        Get.find<OrderController>()
            .getOrderWithId(message.data['_id'], CategoryType.CAR_SHOPPE);
      }
      if (Get.currentRoute == RouteHelper.serviceOrderDetails &&
          Get.find<OrderController>().selectedServiceOrder != null &&
          Get.find<OrderController>().selectedServiceOrder.id ==
              message.data['_id']) {
        if (message.data['assetType'] == "Carspa") {
          Get.find<OrderController>()
              .getOrderWithId(message.data['_id'], CategoryType.CAR_SPA);
        }
        if (message.data['assetType'] == "Mechanical") {
          Get.find<OrderController>()
              .getOrderWithId(message.data['_id'], CategoryType.CAR_MECHANIC);
        }
        if (message.data['assetType'] == "Quickhelp") {
          Get.find<OrderController>()
              .getOrderWithId(message.data['_id'], CategoryType.QUICK_HELP);
        }
      }

      if (_pageIndex == 1) {
        int _tabIndex = Get.find<ActiveOrderTabController>().tabIndex;
        SubTabType _subTabType =
            Get.find<ActiveOrderTabController>().subTabType;
        if (message.data['eventType'] == "order-placed" &&
            _subTabType == SubTabType.NEW) {
          if (_tabIndex == 0 && message.data['assetType'] == "Shoppe") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SHOPPE);
          }
          if (_tabIndex == 1 && message.data['assetType'] == "Carspa") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SPA);
          }
          if (_tabIndex == 2 && message.data['assetType'] == "Mechanical") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_MECHANIC);
          }
          if (_tabIndex == 3 && message.data['assetType'] == "Quickhelp") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.QUICK_HELP);
          }
        }
        if ((message.data['eventType'] == "order-in-progress" ||
                message.data['eventType'] == "order-dispatched" ||
                message.data['eventType'] == "order-return-accepted" ||
                message.data['eventType'] == "order-return-approved" ||
                message.data['eventType'] == "order-refund-processing") &&
            _subTabType == SubTabType.ACTIVE) {
          if (_tabIndex == 0 && message.data['assetType'] == "Shoppe") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SHOPPE);
          }
          if (_tabIndex == 1 && message.data['assetType'] == "Carspa") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SPA);
          }
          if (_tabIndex == 2 && message.data['assetType'] == "Mechanical") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_MECHANIC);
          }
          if (_tabIndex == 3 && message.data['assetType'] == "Quickhelp") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.QUICK_HELP);
          }
        }
      } else if (_pageIndex == 3) {
        int _tabIndex = Get.find<OrderHistoryTabController>().tabIndex;
        SubTabType _subTabType =
            Get.find<OrderHistoryTabController>().subTabType;
        if ((message.data['eventType'] == "order-completed" ||
                message.data['eventType'] == "order-refund-complete") &&
            _subTabType == SubTabType.COMPELTED) {
          if (_tabIndex == 0 && message.data['assetType'] == "Shoppe") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SHOPPE);
          }
          if (_tabIndex == 1 && message.data['assetType'] == "Carspa") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SPA);
          }
          if (_tabIndex == 2 && message.data['assetType'] == "Mechanical") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_MECHANIC);
          }
          if (_tabIndex == 3 && message.data['assetType'] == "Quickhelp") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.QUICK_HELP);
          }
        }
        if ((message.data['eventType'] == "order-rejected" ||
                message.data['eventType'] == "order-cancelled") &&
            _subTabType == SubTabType.CANCELLED) {
          if (_tabIndex == 0 && message.data['assetType'] == "Shoppe") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SHOPPE);
          }
          if (_tabIndex == 1 && message.data['assetType'] == "Carspa") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_SPA);
          }
          if (_tabIndex == 2 && message.data['assetType'] == "Mechanical") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.CAR_MECHANIC);
          }
          if (_tabIndex == 3 && message.data['assetType'] == "Quickhelp") {
            Get.find<OrderController>()
                .setCurrentOrderList(category: CategoryType.QUICK_HELP);
          }
        }
      }
    });

    _screens = [
      HomeScreen(),
      OrderRequestScreen(onTap: () => _setPage(0)),
      ShoppeScreen(),
      OrderHistoryScreen(),
      ProfileScreen(),
    ];
  }

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
            // _channel.invokeMethod('sendToBackground');
            // return false;
            return true;
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
