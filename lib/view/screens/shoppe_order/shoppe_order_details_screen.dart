import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/product_order_details.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppeOrderDetailsScreen extends StatelessWidget {
  const ShoppeOrderDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Order Details"),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(children: [
                        Text('${'order_id'.tr}:', style: robotoRegular),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                            orderController.selectedShoppeOrder.orderId
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
                                  orderController.selectedShoppeOrder.status)
                              .toString()
                              .toUpperCase(),
                          style: robotoRegular,
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.grey[Get.isDarkMode ? 800 : 200],
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_SMALL),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    image: orderController
                                                    .selectedShoppeOrder
                                                    .orderDetails
                                                    .productDetails
                                                    .thumbUrl !=
                                                null &&
                                            orderController
                                                    .selectedShoppeOrder
                                                    .orderDetails
                                                    .productDetails
                                                    .thumbUrl
                                                    .length >
                                                0
                                        ? orderController
                                            .selectedShoppeOrder
                                            .orderDetails
                                            .productDetails
                                            .thumbUrl[0]
                                        : "",
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
                                        Row(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderController
                                                    .selectedShoppeOrder
                                                    .orderDetails
                                                    .productDetails
                                                    .name,
                                                style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text("Price : ",
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor)),
                                                  Text(
                                                    PriceConverter.convertPrice(
                                                        orderController
                                                            .selectedShoppeOrder
                                                            .orderDetails
                                                            .productDetails
                                                            .offerPrice
                                                            .toDouble()),
                                                    style: robotoMedium,
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                  ),
                                                  Icon(
                                                    Icons.close,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Text('Quantity : ',
                                                            style: robotoRegular
                                                                .copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .FONT_SIZE_SMALL)),
                                                        Text(
                                                          orderController
                                                              .selectedShoppeOrder
                                                              .orderDetails
                                                              .count
                                                              .toString(),
                                                          style: robotoMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  .color,
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_LARGE),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Grand Total : ",
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor)),
                                                  Text(
                                                    PriceConverter.convertPrice(
                                                        orderController
                                                            .selectedShoppeOrder
                                                            .total
                                                            .toDouble()),
                                                    style: robotoMedium,
                                                  ),
                                                ],
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
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      InfoCard(
                        title: 'customer_contact_details'.tr,
                        addressModel:
                            orderController.selectedShoppeOrder.address,
                        isDelivery: true,
                        image: '',
                        name: orderController.selectedShoppeOrder.address.name,
                        phone: orderController
                            .selectedShoppeOrder.address.mobile
                            .toString(),
                        latitude: orderController
                            .selectedShoppeOrder.address.location[0]
                            .toString(),
                        longitude: orderController
                            .selectedShoppeOrder.address.location[1]
                            .toString(),
                        showButton: false,
                      ),
                    ],
                  ),
                ),
              ),
              orderController.selectedShoppeOrder.status !=
                      OrderStatus.COMPLETED
                  ? Row(children: [
                      orderController.selectedShoppeOrder.status ==
                              OrderStatus.PROCESSING
                          ? Expanded(
                              child: TextButton(
                              onPressed: () => Get.dialog(
                                  ConfirmationDialog(
                                    icon: Images.warning,
                                    title: 'are_you_sure_to_ignore'.tr,
                                    description:
                                        'you_want_to_ignore_this_order'.tr,
                                    onYesPressed: () {
                                      if (!orderController.isLoading &&
                                          orderController
                                                  .selectedShoppeOrder.status ==
                                              OrderStatus.PROCESSING) {
                                        orderController
                                            .shoppeOrderStatusUpdate(
                                                orderID: orderController
                                                    .selectedShoppeOrder.id,
                                                orderModel: orderController
                                                    .selectedShoppeOrder,
                                                status: OrderStatus.REJECTED)
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            Get.back();
                                            orderController.selectedShoppeOrder
                                                .status = OrderStatus.REJECTED;
                                            orderController
                                                .setShoppeSelectedOrder(
                                                    orderController
                                                        .selectedShoppeOrder);
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
                                      } else {
                                        Get.back();
                                      }
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
                              child: Text("Reject",
                                  textAlign: TextAlign.center,
                                  style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                  )),
                            ))
                          : SizedBox(),
                      SizedBox(
                          width: orderController.selectedShoppeOrder.status ==
                                  OrderStatus.PROCESSING
                              ? Dimensions.PADDING_SIZE_SMALL
                              : 0),
                      orderController.selectedShoppeOrder.status ==
                                  OrderStatus.CONFIRMED ||
                              orderController.selectedShoppeOrder.status ==
                                  OrderStatus.PROCESSING
                          ? Expanded(
                              child: CustomButton(
                              height: 40,
                              buttonText:
                                  orderController.selectedShoppeOrder.status ==
                                          OrderStatus.PROCESSING
                                      ? 'accept'.tr
                                      : orderController
                                                  .selectedShoppeOrder.status ==
                                              OrderStatus.CONFIRMED
                                          ? "Dispatch"
                                          : "Submit",
                              onPressed: () => Get.dialog(
                                  ConfirmationDialog(
                                    icon: Images.warning,
                                    title: orderController
                                                .selectedShoppeOrder.status ==
                                            OrderStatus.PROCESSING
                                        ? 'are_you_sure_to_accept'.tr
                                        : orderController.selectedShoppeOrder
                                                    .status ==
                                                OrderStatus.CONFIRMED
                                            ? "Are you sure to update status"
                                            : "",
                                    description: orderController
                                                .selectedShoppeOrder.status ==
                                            OrderStatus.PROCESSING
                                        ? 'you_want_to_accept_this_order'.tr
                                        : orderController.selectedShoppeOrder
                                                    .status ==
                                                OrderStatus.CONFIRMED
                                            ? "You are about to update order status to Dispatched"
                                            : "",
                                    onYesPressed: () {
                                      if (!orderController.isLoading &&
                                          (orderController.selectedShoppeOrder
                                                      .status ==
                                                  OrderStatus.PROCESSING ||
                                              orderController
                                                      .selectedShoppeOrder
                                                      .status ==
                                                  OrderStatus.CONFIRMED)) {
                                        orderController
                                            .shoppeOrderStatusUpdate(
                                                orderID: orderController
                                                    .selectedShoppeOrder.id,
                                                orderModel: orderController
                                                    .selectedShoppeOrder,
                                                status: orderController
                                                            .selectedShoppeOrder
                                                            .status ==
                                                        OrderStatus.PROCESSING
                                                    ? OrderStatus.CONFIRMED
                                                    : OrderStatus.DISPATCHED)
                                            .then((isSuccess) {
                                          if (isSuccess) {
                                            ProductOrderDetails orderDetails =
                                                orderController
                                                    .selectedShoppeOrder;
                                            orderDetails.status =
                                                orderController
                                                            .selectedShoppeOrder
                                                            .status ==
                                                        OrderStatus.PROCESSING
                                                    ? OrderStatus.CONFIRMED
                                                    : OrderStatus.DISPATCHED;
                                            orderController
                                                .setShoppeSelectedOrder(
                                                    orderDetails);
                                          } else {
                                            showCustomSnackBar(
                                                'Something went wrong!',
                                                isError: false);
                                          }
                                        });
                                      } else {
                                        Get.back();
                                      }
                                    },
                                  ),
                                  barrierDismissible: false),
                            ))
                          : SizedBox(),
                    ])
                  : SizedBox()
            ],
          ),
        );
      }),
    );
  }
}
