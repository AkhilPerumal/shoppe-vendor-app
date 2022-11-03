import 'package:carclenx_vendor_app/data/model/response/all_service_work_details_model.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountCard extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final AllServiceWorkDetails orderCountList;
  final double height;
  CountCard(
      {@required this.backgroundColor,
      @required this.title,
      @required this.orderCountList,
      @required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        title == 'todays_orders'.tr || title == 'this_week_orders'.tr
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Active Orders",
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "New Orders",
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // height: 80,
                    // width: 22,
                    child: Column(children: [
                      Image.asset(
                        Images.shoppe_icon,
                        height: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title == 'todays_orders'.tr
                            ? orderCountList != null &&
                                    orderCountList.shoppe.daily != null
                                ? orderCountList.shoppe.daily.activeCount
                                    .toString()
                                : "0"
                            : "0",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title == 'todays_orders'.tr
                            ? orderCountList != null &&
                                    orderCountList.shoppe.daily != null
                                ? orderCountList.shoppe.daily.newCount
                                    .toString()
                                : "0"
                            : "0",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: 1,
                        color: Theme.of(context).cardColor),
                  ),
                  Column(children: [
                    Image.asset(
                      Images.car_spa_icon,
                      height: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderCountList != null &&
                              orderCountList.carspa.total != null
                          ? orderCountList.carspa.total.acceptedCount.toString()
                          : "0",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderCountList != null &&
                              orderCountList.carspa.total != null
                          ? orderCountList.carspa.total.activeCount.toString()
                          : "0",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: 1,
                        color: Theme.of(context).cardColor),
                  ),
                  Column(children: [
                    Image.asset(
                      Images.mechanical_icon,
                      height: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderCountList != null &&
                              orderCountList.mechanical.total != null
                          ? orderCountList.mechanical.total.acceptedCount
                              .toString()
                          : "0",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderCountList != null &&
                              orderCountList.mechanical.total != null
                          ? orderCountList.mechanical.total.activeCount
                              .toString()
                          : "0",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: 1,
                        color: Theme.of(context).cardColor),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        Images.quick_help_icon,
                        height: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        orderCountList != null &&
                                orderCountList.quickhelp.total != null
                            ? orderCountList.quickhelp.total.acceptedCount
                                .toString()
                            : "0",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        orderCountList != null &&
                                orderCountList.quickhelp.total != null
                            ? orderCountList.quickhelp.total.activeCount
                                .toString()
                            : "0",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                title == 'total_orders_completed'.tr
                    ? orderCountList != null
                        ? ((orderCountList.carspa.total != null
                                    ? orderCountList.carspa.total.completedCount
                                    : 0.0) +
                                (orderCountList.mechanical.total != null
                                    ? orderCountList
                                        .mechanical.total.completedCount
                                    : 0.0) +
                                (orderCountList.quickhelp.total != null
                                    ? orderCountList
                                        .quickhelp.total.completedCount
                                    : 0.0))
                            .toString()
                        : title == 'cash_in_your_hand'.tr
                            ? "₹ 0"
                            : "0"
                    : "0",
                style: robotoMedium.copyWith(fontSize: 40, color: Colors.white),
                textAlign: TextAlign.center,
              ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        title != 'todays_orders'.tr
            ? Text(
                title,
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )
            : SizedBox(),
      ]),
    );
  }
}
