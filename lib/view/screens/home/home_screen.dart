import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/notification_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_alert_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/base/order_widget.dart';
import 'package:carclenx_vendor_app/view/base/title_widget.dart';
import 'package:carclenx_vendor_app/view/screens/home/widget/count_card.dart';
import 'package:carclenx_vendor_app/view/screens/home/widget/earning_widget.dart';
import 'package:carclenx_vendor_app/view/screens/order/running_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _loadData() async {
    // await Get.find<AuthController>().getProfile();
    // await Get.find<OrderController>().getCurrentOrders();
    // await Get.find<NotificationController>().getNotificationList();
    Get.find<AuthController>().getWorkerWorkDetails();
    // bool _isBatteryOptimizationDisabled =
    //     await DisableBatteryOptimization.isBatteryOptimizationDisabled;
    // if (!_isBatteryOptimizationDisabled) {
    //   DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        // leading: Padding(
        //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //   child: Image.asset(Images.logo, height: 30, width: 30),
        // ),
        titleSpacing: 0,
        elevation: 0,
        /*title: Text(AppConstants.APP_NAME, maxLines: 1, overflow: TextOverflow.ellipsis, style: robotoMedium.copyWith(
          color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_DEFAULT,
        )),*/
        title: Container(
          margin: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
          child: Image.asset(Images.logo_name, width: 120),
        ),
        actions: [
          IconButton(
            icon: GetBuilder<NotificationController>(
                builder: (notificationController) {
              bool _hasNewNotification = false;
              if (notificationController.notificationList != null) {
                _hasNewNotification =
                    notificationController.notificationList.length !=
                        notificationController.getSeenNotificationCount();
              }
              return Stack(children: [
                Icon(Icons.notifications,
                    size: 25,
                    color: Theme.of(context).textTheme.bodyText1.color),
                _hasNewNotification
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1, color: Theme.of(context).cardColor),
                          ),
                        ))
                    : SizedBox(),
              ]);
            }),
            onPressed: () {
              Get.find<NotificationController>().getNotificationList();
              Get.toNamed(RouteHelper.getNotificationRoute());
            },
          ),
          GetBuilder<AuthController>(builder: (authController) {
            return GetBuilder<OrderController>(builder: (orderController) {
              return (authController.userModel != null)
                  ? FlutterSwitch(
                      width: 75,
                      height: 30,
                      valueFontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      showOnOff: true,
                      activeText: 'online'.tr,
                      inactiveText: 'offline'.tr,
                      activeColor: Theme.of(context).primaryColor,
                      value: authController.userModel.status == 'Active',
                      onToggle: (bool isActive) async {
                        if (!isActive &&
                            orderController.runningOrderList != null &&
                            orderController.runningOrderList.length > 0) {
                          showCustomSnackBar('you_can_not_go_offline_now'.tr);
                        } else {
                          if (!isActive) {
                            Get.dialog(ConfirmationDialog(
                              icon: Images.warning,
                              // description: 'are_you_sure_to_offline'.tr,
                              description:
                                  "Currently you can't go offline, Contact customer care",
                              onYesPressed: () async {
                                Get.back();
                                // authController.updateActiveStatus();
                                if (await canLaunchUrlString(
                                    'tel:+919745401234')) {
                                  launchUrlString('tel:+919745401234',
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  showCustomSnackBar(
                                      'invalid_phone_number_found');
                                }
                              },
                            ));
                          } else {
                            LocationPermission permission =
                                await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied ||
                                permission ==
                                    LocationPermission.deniedForever ||
                                (GetPlatform.isIOS
                                    ? false
                                    : permission ==
                                        LocationPermission.whileInUse)) {
                              if (GetPlatform.isAndroid) {
                                Get.dialog(
                                    ConfirmationDialog(
                                      icon: Images.location_permission,
                                      iconSize: 200,
                                      hasCancel: false,
                                      description:
                                          'this_app_collects_location_data'.tr,
                                      onYesPressed: () {
                                        Get.back();
                                        _checkPermission(() => authController
                                            .updateActiveStatus());
                                      },
                                    ),
                                    barrierDismissible: false);
                              } else {
                                _checkPermission(
                                    () => authController.updateActiveStatus());
                              }
                            } else {
                              authController.updateActiveStatus();
                            }
                          }
                        }
                      },
                    )
                  : SizedBox();
            });
          }),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await _loadData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              GetBuilder<OrderController>(builder: (orderController) {
                bool _hasActiveOrder =
                    orderController.runningOrderList != null &&
                        orderController.runningOrderList.length > 0;
                bool _hasMoreOrder = orderController.runningOrderList != null &&
                    orderController.runningOrderList.length > 1;
                return Column(children: [
                  _hasActiveOrder
                      ? TitleWidget(
                          title: 'active_order'.tr,
                          onTap: _hasMoreOrder
                              ? () {
                                  Get.toNamed(
                                      RouteHelper.getRunningOrderRoute(),
                                      arguments: RunningOrderScreen());
                                }
                              : null,
                        )
                      : SizedBox(),
                  SizedBox(
                      height: _hasActiveOrder
                          ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                          : 0),
                  orderController.runningOrderList == null
                      ? SizedBox()
                      // OrderShimmer(
                      //     isEnabled: orderController.currentOrderList == null,
                      //   )
                      : orderController.runningOrderList.length > 0
                          ? OrderWidget(
                              orderModel: orderController.runningOrderList[0],
                              isRunningOrder: true,
                              orderIndex: 0,
                            )
                          : SizedBox(),
                  SizedBox(
                      height: _hasActiveOrder
                          ? Dimensions.PADDING_SIZE_DEFAULT
                          : 0),
                ]);
              }),
              (authController.userModel != null)
                  ? Column(children: [
                      TitleWidget(title: 'earnings'.tr),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.wallet,
                                    width: 60, height: 60),
                                SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'earned_amount'.tr,
                                        style: robotoMedium.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL,
                                            color: Theme.of(context).cardColor),
                                      ),
                                      SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      authController.userModel != null &&
                                              authController.userModel
                                                      .allServiceWorkDetails !=
                                                  null
                                          ? Text(
                                              PriceConverter.convertPrice((authController.userModel.allServiceWorkDetails.carspa != null && authController.userModel.allServiceWorkDetails.carspa.total != null ? double.tryParse(authController.userModel.allServiceWorkDetails.carspa.total.earning.toString()) : 0.0) +
                                                  (authController.userModel.allServiceWorkDetails.shoppe != null && authController.userModel.allServiceWorkDetails.shoppe.total != null
                                                      ? double.tryParse(authController
                                                          .userModel
                                                          .allServiceWorkDetails
                                                          .shoppe
                                                          .total
                                                          .earning
                                                          .toString())
                                                      : 0.0) +
                                                  (authController.userModel.allServiceWorkDetails.mechanical != null && authController.userModel.allServiceWorkDetails.mechanical.total != null
                                                      ? double.tryParse(
                                                          authController
                                                              .userModel
                                                              .allServiceWorkDetails
                                                              .mechanical
                                                              .total
                                                              .earning
                                                              .toString())
                                                      : 0.0) +
                                                  (authController.userModel.allServiceWorkDetails.quickhelp !=
                                                              null &&
                                                          authController.userModel.allServiceWorkDetails.quickhelp.total != null
                                                      ? double.tryParse(authController.userModel.allServiceWorkDetails.quickhelp.total.earning.toString())
                                                      : 0.0)),
                                              style: robotoBold.copyWith(
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .cardColor),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Container(
                                              height: 30,
                                              width: 60,
                                              color: Colors.white),
                                    ]),
                              ]),
                          SizedBox(height: 30),
                          Row(children: [
                            EarningWidget(
                              title: 'today'.tr,
                              amount: authController.userModel.allServiceWorkDetails != null
                                  ? (authController.userModel.allServiceWorkDetails.carspa != null && authController.userModel.allServiceWorkDetails.carspa.total != null ? double.tryParse(authController.userModel.allServiceWorkDetails.carspa.daily.earning.all.toString()) : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.shoppe != null && authController.userModel.allServiceWorkDetails.shoppe.daily != null
                                          ? double.tryParse(authController
                                              .userModel
                                              .allServiceWorkDetails
                                              .shoppe
                                              .daily
                                              .earning
                                              .all
                                              .toString())
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.mechanical != null && authController.userModel.allServiceWorkDetails.mechanical.daily != null
                                          ? double.tryParse(authController
                                              .userModel
                                              .allServiceWorkDetails
                                              .mechanical
                                              .daily
                                              .earning
                                              .all
                                              .toString())
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.quickhelp != null &&
                                              authController.userModel.allServiceWorkDetails.quickhelp.daily != null
                                          ? double.tryParse(authController.userModel.allServiceWorkDetails.quickhelp.daily.earning.all.toString())
                                          : 0.0)
                                  : 0.0,
                            ),
                            Container(
                                height: 30,
                                width: 1,
                                color: Theme.of(context).cardColor),
                            EarningWidget(
                              title: 'this_week'.tr,
                              amount: authController.userModel.allServiceWorkDetails != null
                                  ? (authController.userModel.allServiceWorkDetails.carspa != null && authController.userModel.allServiceWorkDetails.carspa.weekly != null ? double.tryParse(authController.userModel.allServiceWorkDetails.carspa.weekly.earning.all.toString()) : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.shoppe != null && authController.userModel.allServiceWorkDetails.shoppe.weekly != null
                                          ? double.tryParse(authController
                                              .userModel
                                              .allServiceWorkDetails
                                              .shoppe
                                              .weekly
                                              .earning
                                              .all
                                              .toString())
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.mechanical != null && authController.userModel.allServiceWorkDetails.mechanical.weekly != null
                                          ? double.tryParse(authController
                                              .userModel
                                              .allServiceWorkDetails
                                              .mechanical
                                              .weekly
                                              .earning
                                              .all
                                              .toString())
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.quickhelp != null &&
                                              authController.userModel.allServiceWorkDetails.quickhelp.weekly != null
                                          ? double.tryParse(authController.userModel.allServiceWorkDetails.quickhelp.weekly.earning.all.toString())
                                          : 0.0)
                                  : 0.0,
                            ),
                            Container(
                                height: 30,
                                width: 1,
                                color: Theme.of(context).cardColor),
                            EarningWidget(
                              title: 'this_month'.tr,
                              amount:authController.userModel.allServiceWorkDetails!=null? double.parse(((authController.userModel.allServiceWorkDetails.carspa != null ? (authController.userModel.allServiceWorkDetails.carspa.monthly != null ? (authController.userModel.allServiceWorkDetails.carspa.monthly.earning.cod + authController.userModel.allServiceWorkDetails.carspa.monthly.earning.online) : 0.0) : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.shoppe != null
                                          ? (authController.userModel.allServiceWorkDetails.shoppe.monthly != null
                                              ? (authController.userModel.allServiceWorkDetails.shoppe.monthly.earning.cod +
                                                  authController
                                                      .userModel
                                                      .allServiceWorkDetails
                                                      .shoppe
                                                      .monthly
                                                      .earning
                                                      .online)
                                              : 0.0)
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.mechanical != null
                                          ? (authController.userModel.allServiceWorkDetails.mechanical.monthly != null
                                              ? (authController
                                                      .userModel
                                                      .allServiceWorkDetails
                                                      .mechanical
                                                      .monthly
                                                      .earning
                                                      .cod +
                                                  authController
                                                      .userModel
                                                      .allServiceWorkDetails
                                                      .mechanical
                                                      .monthly
                                                      .earning
                                                      .online)
                                              : 0.0)
                                          : 0.0) +
                                      (authController.userModel.allServiceWorkDetails.quickhelp != null ? (authController.userModel.allServiceWorkDetails.quickhelp.monthly != null ? (authController.userModel.allServiceWorkDetails.quickhelp.monthly.earning.cod + authController.userModel.allServiceWorkDetails.quickhelp.monthly.earning.online) : 0.0) : 0.0))
                                  .toString()):0.0,
                            ),
                          ]),
                        ]),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ])
                  : SizedBox(),
              TitleWidget(title: 'orders'.tr),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              CountCard(
                title: 'todays_orders'.tr,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                height: 160,
                orderCountList: authController.userModel.allServiceWorkDetails,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Row(
                children: [
                  Expanded(
                    child: CountCard(
                      title: 'total_orders_completed'.tr,
                      backgroundColor: Colors.amber,
                      height: 140,
                      orderCountList:
                          authController.userModel.allServiceWorkDetails,
                    ),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Expanded(
                    child: CountCard(
                        title: 'cash_in_your_hand'.tr,
                        backgroundColor: Colors.green,
                        height: 140,
                        orderCountList:
                            authController.userModel.allServiceWorkDetails),
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              TitleWidget(title: 'ratings'.tr),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text('my_ratings'.tr,
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: Colors.white,
                              ))),
                      GetBuilder<AuthController>(builder: (authController) {
                        return Shimmer(
                          duration: Duration(seconds: 2),
                          enabled: authController.userModel == null,
                          color: Colors.grey[500],
                          child: Column(children: [
                            Row(children: [
                              authController.userModel != null
                                  ? Text(authController.userModel
                                          .allServiceWorkDetails!=null?
                                      authController.userModel
                                          .allServiceWorkDetails.average_rating
                                          .toString():"0",
                                      style: robotoBold.copyWith(
                                          fontSize: 30, color: Colors.white),
                                    )
                                  : Container(
                                      height: 25,
                                      width: 40,
                                      color: Colors.white),
                              Icon(Icons.star, color: Colors.white, size: 35),
                            ]),
                            // authController.userModel != null
                            //     ? Text(
                            //         '${authController.userModel.ratingCount} ${'reviews'.tr}',
                            //         style: robotoRegular.copyWith(
                            //             fontSize: Dimensions.FONT_SIZE_SMALL,
                            //             color: Colors.white),
                            //       )
                            //     : Container(
                            //         height: 10, width: 50, color: Colors.white),
                          ]),
                        );
                      }),
                    ]),
              ),
            ]);
          }),
        ),
      ),
    );
  }

  void _checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        (GetPlatform.isIOS
            ? false
            : permission == LocationPermission.whileInUse)) {
      Get.dialog(
          CustomAlertDialog(
              description: 'you_denied'.tr,
              onOkPressed: () async {
                Get.back();
                await Geolocator.requestPermission();
                _checkPermission(callback);
              }),
          barrierDismissible: false);
    } else if (permission == LocationPermission.deniedForever) {
      Get.dialog(
          CustomAlertDialog(
              description: 'you_denied_forever'.tr,
              onOkPressed: () async {
                Get.back();
                await Geolocator.openAppSettings();
                _checkPermission(callback);
              }),
          barrierDismissible: false);
    } else {
      callback();
    }
  }
}
