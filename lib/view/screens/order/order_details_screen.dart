import 'dart:async';

import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/localization_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/all_service_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/order_product_widget.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/verify_delivery_sheet.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/info_card.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel orderModel;
  final bool isRunningOrder;
  final int orderIndex;
  OrderDetailsScreen(
      {@required this.orderModel,
      @required this.isRunningOrder,
      @required this.orderIndex});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    Get.find<OrderController>().setOrder(widget.orderModel);
    Get.find<OrderController>()
        .getOrderDetails(Get.find<OrderController>().orderModel.orderId);

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      Get.find<OrderController>()
          .getOrderWithId(Get.find<OrderController>().orderModel.orderId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool _cancelPermission =
        Get.find<SplashController>().configModel.canceledByDeliveryman;
    bool _selfDelivery =
        Get.find<AuthController>().profileModel.type != 'zone_wise';

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(title: 'order_details'.tr),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<OrderController>(builder: (orderController) {
          OrderModel controllerOrderModel = orderController.orderModel;

          bool _restConfModel =
              Get.find<SplashController>().configModel.orderConfirmationModel !=
                  'deliveryman';
          bool _showBottomView = controllerOrderModel.status == 'accepted' ||
              controllerOrderModel.status == 'confirmed' ||
              controllerOrderModel.status == 'processing' ||
              controllerOrderModel.status == 'handover' ||
              controllerOrderModel.status == 'picked_up' ||
              widget.isRunningOrder;
          bool _showSlider = (controllerOrderModel.mode == 'cash_on_delivery' &&
                  controllerOrderModel.status == 'accepted' &&
                  !_restConfModel &&
                  !_selfDelivery) ||
              controllerOrderModel.status == 'handover' ||
              controllerOrderModel.status == 'picked_up';
          return orderController.orderDetailsModel != null
              ? Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      DateConverter.isBeforeTime(controllerOrderModel.timeSlot)
                          ? (controllerOrderModel.status != 'delivered' &&
                                  controllerOrderModel.status != 'failed' &&
                                  controllerOrderModel.status != 'canceled')
                              ? Column(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                          Images.animate_delivery_man,
                                          fit: BoxFit.contain)),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT),
                                  Text('food_need_to_deliver_within'.tr,
                                      style: robotoRegular.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color:
                                              Theme.of(context).disabledColor)),
                                  SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  // Center(
                                  //   child: Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       children: [
                                  //         Text(
                                  //           DateConverter.differenceInMinute(
                                  //                       controllerOrderModel
                                  //                           .restaurantDeliveryTime,
                                  //                       controllerOrderModel
                                  //                           .createdAt,
                                  //                       controllerOrderModel
                                  //                           .processingTime,
                                  //                       controllerOrderModel
                                  //                           .scheduleAt) <
                                  //                   5
                                  //               ? '1 - 5'
                                  //               : '${DateConverter.differenceInMinute(controllerOrderModel.restaurantDeliveryTime, controllerOrderModel.createdAt, controllerOrderModel.processingTime, controllerOrderModel.scheduleAt) - 5} '
                                  //                   '- ${DateConverter.differenceInMinute(controllerOrderModel.restaurantDeliveryTime, controllerOrderModel.createdAt, controllerOrderModel.processingTime, controllerOrderModel.scheduleAt)}',
                                  //           style: robotoBold.copyWith(
                                  //               fontSize: Dimensions
                                  //                   .FONT_SIZE_EXTRA_LARGE),
                                  //         ),
                                  //         SizedBox(
                                  //             width: Dimensions
                                  //                 .PADDING_SIZE_EXTRA_SMALL),
                                  //         Text('min'.tr,
                                  //             style: robotoMedium.copyWith(
                                  //                 fontSize: Dimensions
                                  //                     .FONT_SIZE_LARGE,
                                  //                 color: Theme.of(context)
                                  //                     .primaryColor)),
                                  //       ]),
                                  // ),
                                  SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                ])
                              : SizedBox()
                          : SizedBox(),
                      Row(children: [
                        Text('${'order_id'.tr}:', style: robotoRegular),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(controllerOrderModel.orderId.toString(),
                            style: robotoMedium),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Expanded(child: SizedBox()),
                        Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green)),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          controllerOrderModel.status.tr,
                          style: robotoRegular,
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      InfoCard(
                        title: 'restaurant_details'.tr,
                        addressModel: controllerOrderModel.address,
                        image: Images.logo,
                        name: 'franchise name',
                        phone: 'franchise number',
                        latitude: 'franchise lat',
                        longitude: 'franchise long',
                        showButton: controllerOrderModel.status != 'delivered',
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      InfoCard(
                        title: 'customer_contact_details'.tr,
                        addressModel: controllerOrderModel.address,
                        isDelivery: true,
                        image: '',
                        name: controllerOrderModel.address.name,
                        phone: controllerOrderModel.address.mobile.toString(),
                        latitude:
                            controllerOrderModel.address.location[0].toString(),
                        longitude:
                            controllerOrderModel.address.location[1].toString(),
                        showButton: controllerOrderModel.status != 'delivered',
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Row(children: [
                                Text('${'item'.tr}:', style: robotoRegular),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  orderController.orderDetailsModel.length
                                      .toString(),
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Expanded(child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                                      vertical:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    controllerOrderModel.paymentStatus ==
                                            'cash_on_delivery'
                                        ? 'cod'.tr
                                        : controllerOrderModel.paymentStatus ==
                                                'wallet'
                                            ? 'wallet_payment'.tr
                                            : 'digitally_paid'.tr,
                                    style: robotoRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        color: Theme.of(context).cardColor),
                                  ),
                                ),
                              ]),
                            ),
                            Divider(height: Dimensions.PADDING_SIZE_LARGE),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  orderController.orderDetailsModel.length,
                              itemBuilder: (context, index) {
                                return OrderProductWidget(
                                    order: controllerOrderModel,
                                    orderDetails: orderController
                                        .orderDetailsModel[index]);
                              },
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('additional_note'.tr,
                                      style: robotoRegular),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  Container(
                                    width: 1170,
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    child: Text(
                                      "Description note",
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),
                                ]),
                          ]),
                    ]),
                  )),
                  _showBottomView
                      ? ((controllerOrderModel.status == 'accepted' &&
                                  (controllerOrderModel.paymentStatus !=
                                          'cash_on_delivery' ||
                                      _restConfModel ||
                                      _selfDelivery)) ||
                              controllerOrderModel.status == 'processing' ||
                              controllerOrderModel.status == 'confirmed')
                          ? Container(
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                border: Border.all(width: 1),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                controllerOrderModel.status == 'processing'
                                    ? 'food_is_preparing'.tr
                                    : 'food_waiting_for_cook'.tr,
                                style: robotoMedium,
                              ),
                            )
                          : _showSlider
                              ? (controllerOrderModel.paymentStatus ==
                                          'cash_on_delivery' &&
                                      controllerOrderModel.status ==
                                          'accepted' &&
                                      !_restConfModel &&
                                      _cancelPermission &&
                                      !_selfDelivery)
                                  ? Row(children: [
                                      Expanded(
                                          child: TextButton(
                                        onPressed: () => Get.dialog(
                                            ConfirmationDialog(
                                              icon: Images.warning,
                                              title:
                                                  'are_you_sure_to_cancel'.tr,
                                              description:
                                                  'you_want_to_cancel_this_order'
                                                      .tr,
                                              onYesPressed: () {
                                                orderController
                                                    .updateOrderStatus(
                                                        widget.orderIndex,
                                                        'canceled',
                                                        back: true)
                                                    .then((success) {
                                                  if (success) {
                                                    Get.find<AuthController>()
                                                        .getProfile();
                                                    Get.find<OrderController>()
                                                        .getCurrentOrders();
                                                  }
                                                });
                                              },
                                            ),
                                            barrierDismissible: false),
                                        style: TextButton.styleFrom(
                                          minimumSize: Size(1170, 40),
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            side: BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color),
                                          ),
                                        ),
                                        child: Text('cancel'.tr,
                                            textAlign: TextAlign.center,
                                            style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE,
                                            )),
                                      )),
                                      SizedBox(
                                          width: Dimensions.PADDING_SIZE_SMALL),
                                      Expanded(
                                          child: CustomButton(
                                        buttonText: 'confirm'.tr,
                                        height: 40,
                                        onPressed: () {
                                          Get.dialog(
                                              ConfirmationDialog(
                                                icon: Images.warning,
                                                title: 'are_you_sure_to_confirm'
                                                    .tr,
                                                description:
                                                    'you_want_to_confirm_this_order'
                                                        .tr,
                                                onYesPressed: () {
                                                  orderController
                                                      .updateOrderStatus(
                                                          widget.orderIndex,
                                                          'confirmed',
                                                          back: true)
                                                      .then((success) {
                                                    if (success) {
                                                      Get.find<AuthController>()
                                                          .getProfile();
                                                      Get.find<
                                                              OrderController>()
                                                          .getCurrentOrders();
                                                    }
                                                  });
                                                },
                                              ),
                                              barrierDismissible: false);
                                        },
                                      )),
                                    ])
                                  : SliderButton(
                                      action: () {
                                        if (controllerOrderModel
                                                    .paymentStatus ==
                                                'cash_on_delivery' &&
                                            controllerOrderModel.status ==
                                                'accepted' &&
                                            !_restConfModel &&
                                            !_selfDelivery) {
                                          Get.dialog(
                                              ConfirmationDialog(
                                                icon: Images.warning,
                                                title: 'are_you_sure_to_confirm'
                                                    .tr,
                                                description:
                                                    'you_want_to_confirm_this_order'
                                                        .tr,
                                                onYesPressed: () {
                                                  orderController
                                                      .updateOrderStatus(
                                                          widget.orderIndex,
                                                          'confirmed',
                                                          back: true)
                                                      .then((success) {
                                                    if (success) {
                                                      Get.find<AuthController>()
                                                          .getProfile();
                                                      Get.find<
                                                              OrderController>()
                                                          .getCurrentOrders();
                                                    }
                                                  });
                                                },
                                              ),
                                              barrierDismissible: false);
                                        } else if (controllerOrderModel
                                                .status ==
                                            'picked_up') {
                                          if (Get.find<SplashController>()
                                                  .configModel
                                                  .orderDeliveryVerification ||
                                              controllerOrderModel
                                                      .paymentStatus ==
                                                  'cash_on_delivery') {
                                            Get.bottomSheet(
                                                VerifyDeliverySheet(
                                                  orderIndex: widget.orderIndex,
                                                  verify: Get.find<
                                                          SplashController>()
                                                      .configModel
                                                      .orderDeliveryVerification,
                                                  orderAmount:
                                                      controllerOrderModel
                                                          .grandTotal
                                                          .toDouble(),
                                                  cod: controllerOrderModel
                                                          .paymentStatus ==
                                                      'cash_on_delivery',
                                                ),
                                                isScrollControlled: true);
                                          } else {
                                            Get.find<OrderController>()
                                                .updateOrderStatus(
                                                    widget.orderIndex,
                                                    'delivered')
                                                .then((success) {
                                              if (success) {
                                                Get.find<AuthController>()
                                                    .getProfile();
                                                Get.find<OrderController>()
                                                    .getCurrentOrders();
                                              }
                                            });
                                          }
                                        } else if (controllerOrderModel
                                                .status ==
                                            'handover') {
                                          if (Get.find<AuthController>()
                                                  .profileModel
                                                  .active ==
                                              1) {
                                            Get.find<OrderController>()
                                                .updateOrderStatus(
                                                    widget.orderIndex,
                                                    'picked_up')
                                                .then((success) {
                                              if (success) {
                                                Get.find<AuthController>()
                                                    .getProfile();
                                                Get.find<OrderController>()
                                                    .getCurrentOrders();
                                              }
                                            });
                                          } else {
                                            showCustomSnackBar(
                                                'make_yourself_online_first'
                                                    .tr);
                                          }
                                        }
                                      },
                                      label: Text(
                                        (controllerOrderModel.paymentStatus ==
                                                    'cash_on_delivery' &&
                                                controllerOrderModel.status ==
                                                    'accepted' &&
                                                !_restConfModel &&
                                                !_selfDelivery)
                                            ? 'swipe_to_confirm_order'.tr
                                            : controllerOrderModel.status ==
                                                    'picked_up'
                                                ? 'swipe_to_deliver_order'.tr
                                                : controllerOrderModel.status ==
                                                        'handover'
                                                    ? 'swipe_to_pick_up_order'
                                                        .tr
                                                    : '',
                                        style: robotoMedium.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      dismissThresholds: 0.5,
                                      dismissible: false,
                                      shimmer: true,
                                      width: 1170,
                                      height: 60,
                                      buttonSize: 50,
                                      radius: 10,
                                      icon: Center(
                                          child: Icon(
                                        Get.find<LocalizationController>().isLtr
                                            ? Icons.double_arrow_sharp
                                            : Icons.keyboard_arrow_left,
                                        color: Colors.white,
                                        size: 20.0,
                                      )),
                                      isLtr: Get.find<LocalizationController>()
                                          .isLtr,
                                      boxShadow: BoxShadow(blurRadius: 0),
                                      buttonColor:
                                          Theme.of(context).primaryColor,
                                      backgroundColor: Color(0xffF4F7FC),
                                      baseColor: Theme.of(context).primaryColor,
                                    )
                              : SizedBox()
                      : SizedBox(),
                ])
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
