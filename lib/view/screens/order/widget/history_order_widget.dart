import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryOrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  final bool isRunning;
  final int index;
  HistoryOrderWidget(
      {@required this.orderModel,
      @required this.isRunning,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<OrderController>().setServiceSelectedOrder(orderModel);
        Get.toNamed(
          RouteHelper.serviceOrderDetails,
          arguments: {
            'orderModel': orderModel,
            'isRunningOrder': isRunning,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 700 : 300],
                spreadRadius: 1,
                blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: CustomImage(
              image: orderModel.serviceId.thumbURL[0].toString(),
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('${'order_id'.tr}:',
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  '#${orderModel.orderId}',
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                'status : '.tr +
                    EnumConverter.orderStatusToTitle(orderModel.status)
                        .toString()
                        .toUpperCase(),
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(children: [
                Icon(Icons.access_time, size: 15),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  DateConverter.dateTimeStringToDateTime(
                      orderModel.createdAt.toString()),
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
