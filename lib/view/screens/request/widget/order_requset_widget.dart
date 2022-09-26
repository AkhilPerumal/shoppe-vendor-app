import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/screens/order/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderRequestWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final bool fromDetailsPage;
  OrderRequestWidget(
      {@required this.orderModel,
      @required this.index,
      this.fromDetailsPage = false});

  var lat, long, phone;

  @override
  Widget build(BuildContext context) {
    if (orderModel.address.location != null &&
        orderModel.address.location.length > 0) {
      lat = orderModel.address.location[0];
      long = orderModel.address.location[1];
      phone = orderModel.address.mobile;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<OrderController>(builder: (orderController) {
          return Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    image: orderModel.serviceId.thumbURL[0],
                    imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover),
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
                              dateTime: DateTime.parse(orderModel.createdAt),
                              numericDates: true),
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        ),
                      ],
                    ),
                  ])),
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
                  (Get.find<AuthController>().userModel.earnings != 1)
                      ? Text(
                          PriceConverter.convertPrice(
                              orderModel.grandTotal.toDouble()),
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        )
                      : SizedBox(),
                  Text(
                    orderModel.mode,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: Theme.of(context).disabledColor),
                  ),
                ]),
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Scheduled on",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  color: Theme.of(context).disabledColor),
                            ),
                            TextButton.icon(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(60, 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                onPressed: () {},
                                icon: Icon(Icons.edit,
                                    size: 12,
                                    color: Theme.of(context).primaryColor),
                                label: Text(
                                  "Re-Schedule",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).primaryColor),
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
                              orderModel.date,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  color: Theme.of(context).disabledColor),
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
                                  color: Theme.of(context).disabledColor),
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
                              orderModel.createdAt),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                orderModel.address != null
                    ? Row(children: [
                        TextButton.icon(
                          onPressed: () async {
                            if (await canLaunchUrlString('tel:$phone')) {
                              launchUrlString('tel:$phone',
                                  mode: LaunchMode.externalApplication);
                            } else {
                              showCustomSnackBar('invalid_phone_number_found');
                            }
                          },
                          icon: Icon(Icons.call,
                              color: Theme.of(context).primaryColor, size: 20),
                          label: Text(
                            'call'.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context).primaryColor),
                          ),
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
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                        ),
                      ])
                    : SizedBox(),
                TextButton.icon(
                  onPressed: (() {
                    Get.toNamed(RouteHelper.orderDetails, arguments: {
                      'orderModel': orderModel,
                      'isRunningOrder': true,
                      'orderIndex': index,
                    });
                  }),
                  icon: Icon(
                    Icons.read_more,
                    size: 20,
                  ),
                  label: Text(
                    'Details',
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Row(children: [
              Expanded(
                  child: TextButton(
                onPressed: () => Get.dialog(
                    ConfirmationDialog(
                      icon: Images.warning,
                      title: 'are_you_sure_to_ignore'.tr,
                      description: 'you_want_to_ignore_this_order'.tr,
                      onYesPressed: () {
                        orderController.ignoreOrder(index);
                        Get.back();
                        showCustomSnackBar('order_ignored'.tr, isError: false);
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
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
                child: Text('ignore'.tr,
                    textAlign: TextAlign.center,
                    style: robotoRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyText1.color,
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
                        // orderController
                        //     .acceptOrder(int.tryParse(orderModel.orderId),
                        //         index, orderModel)
                        //     .then((isSuccess) {
                        //   if (isSuccess) {
                        //     onTap();
                        //     orderModel.status =
                        //         (orderModel.status == 'pending' ||
                        //                 orderModel.status == 'confirmed')
                        //             ? 'accepted'
                        //             : orderModel.status;
                        //     Get.toNamed(
                        //       RouteHelper.getOrderDetailsRoute(
                        //           orderModel.orderId),
                        //       arguments: OrderDetailsScreen(
                        //         orderModel: orderModel,
                        //         isRunningOrder: true,
                        //         orderIndex:
                        //             orderController.currentOrderList.length - 1,
                        //       ),
                        //     );
                        //   } else {
                        //     Get.find<OrderController>().getLatestOrders();
                        //   }
                        // });
                        Get.toNamed(RouteHelper.orderDetails, arguments: {
                          'orderModel': orderModel,
                          'isRunningOrder': true,
                          'orderIndex': index,
                        });
                      },
                    ),
                    barrierDismissible: false),
              )),
            ]),
          ]);
        }),
      ),
    );
  }
}
