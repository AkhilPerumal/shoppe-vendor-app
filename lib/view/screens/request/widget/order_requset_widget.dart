import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderRequestWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  OrderRequestWidget({
    @required this.orderModel,
    @required this.index,
  });

  var lat, long, phone;

  @override
  Widget build(BuildContext context) {
    if (orderModel.address.location != null &&
        orderModel.address.location.length > 0) {
      lat = orderModel.address.location[0];
      long = orderModel.address.location[1];
      phone = orderModel.address.mobile;
    }
    return InkWell(
      onTap: () {
        Get.find<OrderController>().setServiceSelectedOrder(orderModel);
        Get.toNamed(RouteHelper.serviceOrderDetails,
            arguments: {'isRunningOrder': true, 'orderIndex': index});
      },
      child: Card(
        color: orderModel.status == OrderStatus.IN_PROGRESS
            ? Colors.amber[50]
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: GetBuilder<OrderController>(builder: (orderController) {
            return Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: CustomImage(
                      image: orderModel.serviceId.thumbURL[0],
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    )),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        orderModel.orderId,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderModel.serviceId.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Order Location :  ' +
                            (orderModel.address.street != null
                                ? orderModel.address.street.toString()
                                : ''),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Order Placed on : '.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            DateConverter.timeAgo(
                                dateTime: orderModel.createdAt,
                                numericDates: true),
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                    ])),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).disabledColor, width: 1),
                      ),
                      child: Column(children: [
                        Text(
                          PriceConverter.convertPrice(
                              orderModel.grandTotal.toDouble()),
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        ),
                        Text(
                          orderModel.mode,
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        ),
                      ]),
                    ),
                    // TextButton.icon(
                    //   onPressed: (() {
                    //     Get.toNamed(RouteHelper.orderDetails, arguments: {
                    //       'orderModel': orderModel,
                    //       'isRunningOrder': true,
                    //       'orderIndex': index,
                    //       'category': category,
                    //       'fromPage': fromPage
                    //     });
                    //   }),
                    //   icon: Icon(
                    //     Icons.read_more,
                    //     size: 20,
                    //   ),
                    //   label: Text(
                    //     'Details',
                    //     style: robotoRegular.copyWith(
                    //       fontSize: Dimensions.FONT_SIZE_SMALL,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  orderModel.address != null &&
                          orderModel.status != OrderStatus.ACTIVE &&
                          orderModel.status != OrderStatus.REASSIGNED
                      ? Row(children: [
                          TextButton.icon(
                            onPressed: () async {
                              if (await canLaunchUrlString('tel:$phone')) {
                                launchUrlString('tel:$phone',
                                    mode: LaunchMode.externalApplication);
                              } else {
                                showCustomSnackBar(
                                    'invalid_phone_number_found');
                              }
                            },
                            icon: Icon(Icons.call, size: 20),
                            label: Text(
                              'call'.tr,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL),
                            ),
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              String url =
                                  'https://www.google.com/maps/dir/?api=1&destination=$lat,$long&mode=d';
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw '${'could_not_launch'.tr} $url';
                              }
                            },
                            icon: Icon(Icons.directions, size: 20),
                            label: Text(
                              'direction'.tr,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL),
                            ),
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                        ])
                      : SizedBox(),
                  orderModel.status == OrderStatus.ACCEPTED
                      ? Container(
                          child: TextButton.icon(
                            onPressed: (() {
                              if (orderModel.status == OrderStatus.ACCEPTED) {
                                Get.dialog(
                                    ConfirmationDialog(
                                      icon: Images.warning,
                                      title: 'are_you_sure_to_start'.tr,
                                      description:
                                          'order_start_alert_description'.tr,
                                      onYesPressed: () {
                                        orderController
                                            .serviceOrderStatusUpdate(
                                                orderID: orderModel.id,
                                                orderModel: orderModel,
                                                status: OrderStatus.IN_PROGRESS)
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            orderController
                                                    .selectedOrder.status =
                                                OrderStatus.IN_PROGRESS;
                                            orderController
                                                .setServiceSelectedOrder(
                                                    orderController
                                                        .selectedOrder);
                                          } else {
                                            showCustomSnackBar(
                                                'Something went wrong!',
                                                isError: false);
                                          }
                                        });
                                      },
                                    ),
                                    barrierDismissible: false);
                              }
                            }),
                            icon: Icon(Icons.play_circle_fill_rounded),
                            label: Text(
                                orderModel.status == OrderStatus.IN_PROGRESS
                                    ? "Complete Order"
                                    : "Start"),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  orderModel.status == OrderStatus.IN_PROGRESS
                                      ? Theme.of(context).errorColor
                                      : Theme.of(context).primaryColor,
                              textStyle: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              orderModel.status == OrderStatus.IN_PROGRESS
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(
                        //     color: Theme.of(context).disabledColor, width: 1),
                      ),
                      child: Text('Work in progress'),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).disabledColor, width: 1),
                      ),
                      child: orderModel.date != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Scheduled on",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(60, 10),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.centerLeft),
                                        onPressed: () {},
                                        icon: Icon(Icons.edit,
                                            size: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                        label: Text(
                                          "Re-Schedule",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month_rounded,
                                        size: 16,
                                        color: Theme.of(context).disabledColor),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateConverter.isoStringToLocalDateAnTime(
                                          orderModel.date.toIso8601String()),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.timer_rounded,
                                        size: 16,
                                        color: Theme.of(context).disabledColor),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      orderModel.timeSlot,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Scheduled on : ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateConverter.isoStringToLocalDateAnTime(
                                      orderModel.createdAt.toIso8601String()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoBlack.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ],
                            ),
                    ),

              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              SizedBox(
                  height: orderModel.status == OrderStatus.ACTIVE ||
                          orderModel.status == OrderStatus.REASSIGNED
                      ? Dimensions.PADDING_SIZE_SMALL
                      : 0),
              orderModel.status == OrderStatus.ACTIVE ||
                      orderModel.status == OrderStatus.REASSIGNED
                  ? Row(children: [
                      Expanded(
                          child: TextButton(
                        onPressed: () => Get.dialog(
                            ConfirmationDialog(
                              icon: Images.warning,
                              title: 'are_you_sure_to_ignore'.tr,
                              description: 'you_want_to_ignore_this_order'.tr,
                              onYesPressed: () {
                                orderController
                                    .serviceOrderStatusUpdate(
                                        orderID: orderModel.id,
                                        orderModel: orderModel,
                                        status: OrderStatus.REJECTED)
                                    .then((isSuccess) {
                                  if (isSuccess) {
                                    Get.back();
                                    orderModel.status = OrderStatus.REJECTED;
                                    orderController
                                        .setServiceSelectedOrder(orderModel);
                                    showCustomSnackBar('order_ignored'.tr,
                                        isError: false);
                                  } else {
                                    Get.back();
                                    showCustomSnackBar('Something went wrong!',
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
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
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
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
                              description: 'you_want_to_accept_this_order'.tr,
                              onYesPressed: () {
                                orderController
                                    .serviceOrderStatusUpdate(
                                        orderID: orderModel.id,
                                        orderModel: orderModel,
                                        status: orderModel.status ==
                                                    OrderStatus.ACTIVE ||
                                                orderModel.status ==
                                                    OrderStatus.REASSIGNED
                                            ? OrderStatus.ACCEPTED
                                            : OrderStatus.COMPLETED)
                                    .then((isSuccess) {
                                  if (isSuccess) {
                                    orderController
                                        .setServiceSelectedOrder(orderModel);
                                    Get.toNamed(RouteHelper.serviceOrderDetails,
                                        arguments: {
                                          'isRunningOrder': true,
                                          'orderIndex': orderController
                                                  .currentOrderList.length -
                                              1
                                        });
                                  } else {
                                    showCustomSnackBar('Something went wrong!',
                                        isError: false);
                                  }
                                });
                              },
                            ),
                            barrierDismissible: false),
                      )),
                    ])
                  : SizedBox(),
            ]);
          }),
        ),
      ),
    );
  }
}
