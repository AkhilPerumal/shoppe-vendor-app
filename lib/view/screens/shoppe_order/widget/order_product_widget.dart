import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/product_order_details.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductWidget extends StatelessWidget {
  ProductOrderDetails orderdetails;
  OrderProductWidget({@required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Get.find<OrderController>().setShoppeSelectedOrder(orderdetails);
        Get.toNamed(RouteHelper.shoppeOrderDetails);
      }),
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          // margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        image:
                            orderdetails.orderDetails.productDetails.thumbUrl !=
                                        null &&
                                    orderdetails.orderDetails.productDetails
                                            .thumbUrl.length >
                                        0
                                ? orderdetails
                                    .orderDetails.productDetails.thumbUrl[0]
                                : "",
                        imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderdetails.orderId,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            orderdetails.orderDetails.productDetails.name,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text('${'quantity'.tr} : ',
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor)),
                              Text(
                                orderdetails.orderDetails.count.toString(),
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        .color,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        ]),
                  ],
                ),
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
                              orderdetails.total.toDouble()),
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        ),
                        Text(
                          orderdetails.paymentType,
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Theme.of(context).disabledColor),
                        ),
                      ]),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
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
                        dateTime: orderdetails.createdAt, numericDates: true),
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: Theme.of(context).disabledColor),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              GetBuilder<OrderController>(builder: (orderController) {
                return orderdetails.status == OrderStatus.PROCESSING
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
                                      .shoppeOrderStatusUpdate(
                                          orderID: orderdetails.id,
                                          orderModel: orderdetails,
                                          status: OrderStatus.REJECTED)
                                      .then((isSuccess) {
                                    if (isSuccess) {
                                      Get.back();
                                      orderdetails.status =
                                          OrderStatus.REJECTED;
                                      orderController
                                          .setShoppeSelectedOrder(orderdetails);
                                      showCustomSnackBar('order_ignored'.tr,
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
                            minimumSize: Size(1170, 30),
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
                          child: Text("Reject",
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
                          height: 30,
                          buttonText: 'accept'.tr,
                          onPressed: () => Get.dialog(
                              ConfirmationDialog(
                                icon: Images.warning,
                                title: 'are_you_sure_to_accept'.tr,
                                description: 'you_want_to_accept_this_order'.tr,
                                onYesPressed: () {
                                  orderController
                                      .shoppeOrderStatusUpdate(
                                          orderID: orderdetails.id,
                                          orderModel: orderdetails,
                                          status: OrderStatus.CONFIRMED)
                                      .then((isSuccess) {
                                    if (isSuccess) {
                                      orderdetails.status =
                                          OrderStatus.CONFIRMED;
                                      orderController
                                          .setShoppeSelectedOrder(orderdetails);
                                      Get.toNamed(
                                          RouteHelper.shoppeOrderDetails);
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
                    : orderdetails.status == OrderStatus.CONFIRMED
                        ? Center(
                            child: Container(
                              width: Get.width * 0.4,
                              child: CustomButton(
                                buttonText: "Dispatch",
                                height: 30,
                                width: Get.width * 0.4,
                                onPressed: () {
                                  Get.dialog(
                                      ConfirmationDialog(
                                        icon: Images.warning,
                                        title: "Are you sure to update status",
                                        description:
                                            "You are about to update order status to Dispatched",
                                        onYesPressed: () {
                                          orderController
                                              .shoppeOrderStatusUpdate(
                                                  orderID: orderdetails.id,
                                                  orderModel: orderdetails,
                                                  status:
                                                      OrderStatus.DISPATCHED)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              orderdetails.status =
                                                  OrderStatus.DISPATCHED;
                                              orderController
                                                  .setShoppeSelectedOrder(
                                                      orderdetails);
                                              Get.toNamed(RouteHelper
                                                  .shoppeOrderDetails);
                                            } else {
                                              showCustomSnackBar(
                                                  'Something went wrong!',
                                                  isError: false);
                                            }
                                          });
                                        },
                                      ),
                                      barrierDismissible: false);
                                },
                              ),
                            ),
                          )
                        : CustomButton(
                            height: 30,
                            buttonText: EnumConverter.orderStatusToTitle(
                                orderdetails.status));
              })
            ],
          ),
        ),
      ),
    );
  }
}
