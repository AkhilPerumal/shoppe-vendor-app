import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/localization_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/info_card.dart';
import 'package:carclenx_vendor_app/view/base/slider_button.dart';
import 'package:carclenx_vendor_app/view/screens/service_order/widget/verify_check_list_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceOrderDetailsScreen extends StatelessWidget {
  final bool isRunningOrder;

  ServiceOrderDetailsScreen({
    @required this.isRunningOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppBar(title: 'order_details'.tr),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<OrderController>(builder: (orderController) {
          bool _showBottomView = orderController.selectedServiceOrder.status !=
                  OrderStatus.CANCELLED ||
              isRunningOrder;
          bool _showSlider = orderController.selectedServiceOrder.status ==
                  OrderStatus.IN_PROGRESS ||
              orderController.selectedServiceOrder.status ==
                  OrderStatus.ACCEPTED;
          return orderController.selectedServiceOrder != null
              ? Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      Row(children: [
                        Text('${'order_id'.tr}:', style: robotoRegular),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                            orderController.selectedServiceOrder.orderId
                                .toString(),
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
                          EnumConverter.orderStatusToTitle(
                                  orderController.selectedServiceOrder.status)
                              .toString()
                              .toUpperCase(),
                          style: robotoRegular,
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      InfoCard(
                        title: 'customer_contact_details'.tr,
                        addressModel:
                            orderController.selectedServiceOrder.address,
                        isDelivery: true,
                        image: '',
                        name: orderController.selectedServiceOrder.address.name,
                        phone: orderController
                            .selectedServiceOrder.address.mobile
                            .toString(),
                        latitude: orderController
                            .selectedServiceOrder.address.location[0]
                            .toString(),
                        longitude: orderController
                            .selectedServiceOrder.address.location[1]
                            .toString(),
                        showButton:
                            orderController.selectedServiceOrder.status !=
                                    OrderStatus.COMPLETED &&
                                orderController.selectedServiceOrder.status !=
                                    OrderStatus.CANCELLED,
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_SMALL),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    image: orderController.selectedServiceOrder
                                        .serviceId.thumbURL[0],
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    orderController
                                                        .selectedServiceOrder
                                                        .serviceId
                                                        .name,
                                                    style: robotoMedium.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_SMALL),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    PriceConverter.convertPrice(
                                                        orderController
                                                            .selectedServiceOrder
                                                            .grandTotal
                                                            .toDouble()),
                                                    style: robotoMedium,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Addon :',
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .FONT_SIZE_SMALL)),
                                                      Text(
                                                        orderController
                                                            .selectedServiceOrder
                                                            .addOn
                                                            .length
                                                            .toString(),
                                                        style: robotoMedium.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_SMALL,
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      orderController
                                                                  .selectedServiceOrder
                                                                  .paymentStatus ==
                                                              'cod'.tr
                                                          ? 'cod'.tr
                                                          : orderController
                                                                      .selectedServiceOrder
                                                                      .paymentStatus ==
                                                                  'wallet'
                                                              ? 'wallet_payment'
                                                                  .tr
                                                              : 'digitally_paid'
                                                                  .tr,
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_EXTRA_SMALL,
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                      ]),
                                ),
                              ]),
                            ),
                            Divider(height: Dimensions.PADDING_SIZE_LARGE),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orderController
                                    .selectedServiceOrder.addOn.length,
                                itemBuilder: (context, index) {
                                  if (orderController
                                          .selectedServiceOrder.status ==
                                      OrderStatus.IN_PROGRESS) {
                                    return CheckboxListTile(
                                      value: orderController
                                          .selectedServiceOrder
                                          .addOn[index]
                                          .isSelected,
                                      onChanged: ((value) {
                                        orderController.updateAddOnStatus(
                                            selectedIndex: index);
                                      }),
                                      title: Text(orderController
                                          .selectedServiceOrder
                                          .addOn[index]
                                          .name
                                          .toString()),
                                      subtitle: Text(
                                          PriceConverter.convertPrice(
                                              orderController
                                                  .selectedServiceOrder
                                                  .addOn[index]
                                                  .price
                                                  .toDouble())),
                                    );
                                  } else {
                                    return ListTile(
                                      leading: Icon(Icons.radio_button_checked),
                                      title: Text(orderController
                                          .selectedServiceOrder
                                          .addOn[index]
                                          .name
                                          .toString()),
                                      subtitle: Text(
                                          PriceConverter.convertPrice(
                                              orderController
                                                  .selectedServiceOrder
                                                  .addOn[index]
                                                  .price
                                                  .toDouble())),
                                    );
                                  }
                                }),
                          ]),
                    ]),
                  )),
                  _showBottomView
                      ? orderController.selectedServiceOrder.status ==
                                  OrderStatus.ACTIVE ||
                              orderController.selectedServiceOrder.status ==
                                  OrderStatus.REASSIGNED
                          ? Row(children: [
                              Expanded(
                                  child: TextButton(
                                onPressed: () => Get.dialog(
                                    ConfirmationDialog(
                                      icon: Images.warning,
                                      title: 'are_you_sure_to_ignore'.tr,
                                      description:
                                          'you_want_to_ignore_this_order'.tr,
                                      onYesPressed: () {
                                        orderController
                                            .serviceOrderStatusUpdate(
                                                orderID: orderController
                                                    .selectedServiceOrder.id,
                                                orderModel: orderController
                                                    .selectedServiceOrder,
                                                status: OrderStatus.REJECTED)
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            Get.back();
                                            OrderModel order = orderController
                                                .selectedServiceOrder;
                                            order.status = OrderStatus.REJECTED;
                                            orderController
                                                .setServiceSelectedOrder(order);
                                            showCustomSnackBar(
                                                'order_ignored'.tr,
                                                isError: false);
                                          } else {
                                            Get.back();
                                            showCustomSnackBar(
                                                'Something went wrong!',
                                                isError: false);
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
                                child: Text('ignore'.tr,
                                    textAlign: TextAlign.center,
                                    style: robotoRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    )),
                              )),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Expanded(
                                  child: CustomButton(
                                height: 40,
                                buttonText: 'accept'.tr,
                                onPressed: () => Get.dialog(
                                    ConfirmationDialog(
                                      icon: Images.warning,
                                      title: 'are_you_sure_to_accept'.tr,
                                      description:
                                          'you_want_to_accept_this_order'.tr,
                                      onYesPressed: () {
                                        orderController
                                            .serviceOrderStatusUpdate(
                                                orderID: orderController
                                                    .selectedServiceOrder.id,
                                                orderModel: orderController
                                                    .selectedServiceOrder,
                                                status: orderController
                                                                .selectedServiceOrder
                                                                .status ==
                                                            OrderStatus
                                                                .ACTIVE ||
                                                        orderController
                                                                .selectedServiceOrder
                                                                .status ==
                                                            OrderStatus
                                                                .REASSIGNED
                                                    ? OrderStatus.ACCEPTED
                                                    : OrderStatus.COMPLETED)
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            // onTap();
                                            OrderModel order = orderController
                                                .selectedServiceOrder;
                                            orderController.selectedServiceOrder
                                                .status = OrderStatus.ACCEPTED;
                                            orderController
                                                .setServiceSelectedOrder(order);
                                          } else {
                                            showCustomSnackBar(
                                                'Something went wrong!',
                                                isError: false);
                                          }
                                        });
                                      },
                                    ),
                                    barrierDismissible: false),
                              )),
                            ])
                          : _showSlider
                              ? (orderController.selectedServiceOrder.status ==
                                      OrderStatus.ACCEPTED)
                                  ? Container(
                                      height: 40,
                                      width: Get.width * 0.9,
                                      child: CustomButton(
                                        buttonText: 'start'.tr,
                                        height: 40,
                                        onPressed: () {
                                          Get.dialog(
                                              ConfirmationDialog(
                                                  icon: Images.warning,
                                                  title: 'are_you_sure_to_start'
                                                      .tr,
                                                  description:
                                                      'order_start_alert_description'
                                                          .tr,
                                                  onYesPressed: () {
                                                    orderController
                                                        .serviceOrderStatusUpdate(
                                                            orderID: orderController
                                                                .selectedServiceOrder
                                                                .id,
                                                            orderModel:
                                                                orderController
                                                                    .selectedServiceOrder,
                                                            status: OrderStatus
                                                                .IN_PROGRESS)
                                                        .then((isSuccess) {
                                                      if (isSuccess) {
                                                        OrderModel order =
                                                            orderController
                                                                .selectedServiceOrder;
                                                        order.status =
                                                            OrderStatus
                                                                .IN_PROGRESS;
                                                        orderController
                                                            .setServiceSelectedOrder(
                                                                order);
                                                      } else {
                                                        showCustomSnackBar(
                                                            'Something went wrong!',
                                                            isError: false);
                                                      }
                                                    });
                                                  }),
                                              barrierDismissible: false);
                                        },
                                      ),
                                    )
                                  : orderController
                                              .selectedServiceOrder.status ==
                                          OrderStatus.IN_PROGRESS
                                      ? SliderButton(
                                          action: () {
                                            if (Get.find<AuthController>()
                                                .userModel
                                                .isActive) {
                                              Get.bottomSheet(
                                                  VerifyCheckListSheet(),
                                                  isScrollControlled: true);
                                            } else {
                                              showCustomSnackBar(
                                                  'make_yourself_online_first'
                                                      .tr);
                                            }
                                          },
                                          label: Text(
                                            'swipe_to_to_complete_order'.tr,
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE,
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                                            Get.find<LocalizationController>()
                                                    .isLtr
                                                ? Icons.double_arrow_sharp
                                                : Icons.keyboard_arrow_left,
                                            color: Colors.white,
                                            size: 20.0,
                                          )),
                                          isLtr:
                                              Get.find<LocalizationController>()
                                                  .isLtr,
                                          boxShadow: BoxShadow(blurRadius: 0),
                                          buttonColor:
                                              Theme.of(context).primaryColor,
                                          backgroundColor: Color(0xffF4F7FC),
                                          baseColor:
                                              Theme.of(context).primaryColor,
                                        )
                                      : SizedBox()
                              : SizedBox()
                      : SizedBox(),
                ])
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
