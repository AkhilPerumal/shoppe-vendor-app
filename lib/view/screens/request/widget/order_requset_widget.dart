import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/all_service_model.dart';
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

class OrderRequestWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final bool fromDetailsPage;
  final Function onTap;
  OrderRequestWidget(
      {@required this.orderModel,
      @required this.index,
      @required this.onTap,
      this.fromDetailsPage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      ),
      child: GetBuilder<OrderController>(builder: (orderController) {
        return Column(children: [
          Row(children: [
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
                  Text(
                    orderModel.serviceId.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: Theme.of(context).disabledColor),
                  ),
                ])),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 1),
              ),
              child: Column(children: [
                (Get.find<AuthController>().profileModel.earnings != 1)
                    ? Text(
                        PriceConverter.convertPrice(
                            orderModel.grandTotal.toDouble()),
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: Theme.of(context).primaryColor),
                      )
                    : SizedBox(),
                Text(
                  orderModel.mode,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      color: Theme.of(context).primaryColor),
                ),
              ]),
            ),
          ]),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Text(
            'Placed'.tr,
            style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
          ),
          Text(
            DateConverter.timeAgo(
                dateTime: DateTime.parse(orderModel.createdAt),
                numericDates: true),
            style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
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
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
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
                      orderController
                          .acceptOrder(int.tryParse(orderModel.orderId), index,
                              orderModel)
                          .then((isSuccess) {
                        if (isSuccess) {
                          onTap();
                          orderModel.status = (orderModel.status == 'pending' ||
                                  orderModel.status == 'confirmed')
                              ? 'accepted'
                              : orderModel.status;
                          Get.toNamed(
                            RouteHelper.getOrderDetailsRoute(
                                orderModel.orderId),
                            arguments: OrderDetailsScreen(
                              orderModel: orderModel,
                              isRunningOrder: true,
                              orderIndex:
                                  orderController.currentOrderList.length - 1,
                            ),
                          );
                        } else {
                          Get.find<OrderController>().getLatestOrders();
                        }
                      });
                    },
                  ),
                  barrierDismissible: false),
            )),
          ]),
        ]);
      }),
    );
  }
}
