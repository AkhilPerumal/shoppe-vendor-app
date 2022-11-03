import 'package:carclenx_vendor_app/controller/active_order_tab_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/controller/order_history_tab_controller.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/screens/order/order_history_tab_page.dart';
import 'package:carclenx_vendor_app/view/screens/order/widget/history_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  final OrderHistoryTabController _tabx =
      Get.put(OrderHistoryTabController(length: 4));
  double tabHeight = 0;
  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    tabHeight = width * 0.2;
    return GetBuilder<OrderHistoryTabController>(builder: (_tbx) {
      return Scaffold(
        appBar: AppBar(
          title: Text('order_history'.tr,
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: Theme.of(context).textTheme.bodyText1.color)),
          centerTitle: true,
          // backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(100, tabHeight),
            child: Container(
              height: tabHeight,
              child: TabBar(
                  isScrollable: false,
                  controller: _tabx.tabController,
                  indicatorColor: Theme.of(context).cardColor,
                  indicatorWeight: 3,
                  indicator: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  tabs: [
                    Container(
                      height: tabHeight,
                      child: Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  Images.shoppe_icon,
                                  width: _tabx.tabIndex == 0 ? 25 : 40,
                                ),
                              ),
                              _tabx.tabIndex == 0
                                  ? Text('car_shoppe'.tr,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color))
                                  : SizedBox()
                            ]),
                      ),
                    ),
                    Container(
                      height: tabHeight,
                      child: Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  Images.car_spa_icon,
                                  width: _tabx.tabIndex == 1 ? 25 : 40,
                                ),
                              ),
                              _tabx.tabIndex == 1
                                  ? Text('car_spa'.tr,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color))
                                  : SizedBox()
                            ]),
                      ),
                    ),
                    Container(
                      height: tabHeight,
                      child: Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  Images.mechanical_icon,
                                  width: _tabx.tabIndex == 2 ? 25 : 40,
                                ),
                              ),
                              _tabx.tabIndex == 2
                                  ? Text('car_mechanical'.tr,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color))
                                  : SizedBox()
                            ]),
                      ),
                    ),
                    Container(
                      height: tabHeight,
                      child: Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  Images.quick_help_icon,
                                  width: _tabx.tabIndex == 3 ? 25 : 40,
                                ),
                              ),
                              _tabx.tabIndex == 3
                                  ? Text('quick_help'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color))
                                  : SizedBox()
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabx.tabController,
          children: [
            OrderHistoryTabPage(category: CategoryType.CAR_SHOPPE),
            OrderHistoryTabPage(category: CategoryType.CAR_SPA),
            OrderHistoryTabPage(category: CategoryType.CAR_MECHANIC),
            OrderHistoryTabPage(category: CategoryType.QUICK_HELP)
          ],
        ),
      );
    });
  }

  // GetBuilder<OrderController> body(ScrollController scrollController) {
  //   return GetBuilder<OrderController>(builder: (orderController) {
  //     scrollController?.addListener(() {
  //       if (scrollController.position.pixels ==
  //               scrollController.position.maxScrollExtent &&
  //           // orderController.completedOrderList != null &&
  //           !Get.find<OrderController>().paginate) {
  //         int pageSize = (Get.find<OrderController>().pageSize / 10).ceil();
  //         if (Get.find<OrderController>().offset < pageSize) {
  //           Get.find<OrderController>()
  //               .setOffset(Get.find<OrderController>().offset + 1);
  //           print('end of the page');
  //           Get.find<OrderController>().showBottomLoader();
  //           // Get.find<OrderController>()
  //           //     .getCompletedOrders(Get.find<OrderController>().offset);
  //         }
  //       }
  //     });

  //     return orderController.completedOrderList != null
  //         ? orderController.completedOrderList.length > 0
  //             ? RefreshIndicator(
  //                 onRefresh: () async {
  //                   // await orderController.getCompletedOrders(1);
  //                 },
  //                 child: Scrollbar(
  //                     child: SingleChildScrollView(
  //                   controller: scrollController,
  //                   physics: AlwaysScrollableScrollPhysics(),
  //                   child: Center(
  //                       child: SizedBox(
  //                     width: 1170,
  //                     child: Column(children: [
  //                       ListView.builder(
  //                         padding:
  //                             EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
  //                         itemCount: orderController.completedOrderList.length,
  //                         physics: NeverScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return HistoryOrderWidget(
  //                               orderModel:
  //                                   orderController.completedOrderList[index],
  //                               isRunning: false,
  //                               index: index);
  //                         },
  //                       ),
  //                       orderController.paginate
  //                           ? Center(
  //                               child: Padding(
  //                               padding: EdgeInsets.all(
  //                                   Dimensions.PADDING_SIZE_SMALL),
  //                               child: CircularProgressIndicator(),
  //                             ))
  //                           : SizedBox(),
  //                     ]),
  //                   )),
  //                 )),
  //               )
  //             : Center(child: Text('no_order_found'.tr))
  //         : Center(child: CircularProgressIndicator());
  //   });
  // }
}
