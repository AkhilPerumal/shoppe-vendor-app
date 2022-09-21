import 'dart:async';

import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/screens/request/widget/order_requset_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRequestScreen extends StatelessWidget {
  final Function onTap;
  OrderRequestScreen({@required this.onTap});

  Timer _timer;
  final ScrollController _scrollController = ScrollController();
  TabController _tabController;

  // @override
  // initState() {
  //   super.initState();
  //   _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  //   _tabController.addListener(() {
  //     Get.find<OrderController>().setTabIndex(_tabController.index);
  //   });
  //   Get.find<OrderController>().getLatestOrders(
  //       pageNo: "1", status: "all", category: 'car_shoppe'.tr);
  //   _timer = Timer.periodic(Duration(seconds: 10), (timer) {
  //     // Get.find<OrderController>().getLatestOrders();
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  //   _timer?.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('order_request'.tr,
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: Theme.of(context).textTheme.bodyText1.color)),
          centerTitle: true,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              unselectedLabelStyle: robotoRegular.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.FONT_SIZE_SMALL),
              labelStyle: robotoBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Theme.of(context).primaryColor),
              tabs: [
                Tab(text: 'car_shoppe'.tr),
                Tab(text: 'car_spa'.tr),
                Tab(text: 'car_mechanical'.tr),
                Tab(text: 'quick_help'.tr),
              ]),
        ),
        body: TabBarView(
          children: [
            TabPage(onTap: onTap, category: 'car_shoppe'.tr),
            TabPage(onTap: onTap, category: 'car_spa'.tr),
            TabPage(onTap: onTap, category: 'car_mechanical'.tr),
            TabPage(onTap: onTap, category: 'quick_help'.tr)
          ],
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  const TabPage({
    Key key,
    @required this.onTap,
    this.category,
  }) : super(key: key);

  final Function onTap;
  final String category;

  @override
  Widget build(BuildContext context) {
    if (category == 'car_spa'.tr) {
      Get.find<OrderController>()
          .getLatestOrders(category: 'car_spa'.tr, pageNo: "1", status: "all");
    } else if (category == 'car_mechanical'.tr) {
      Get.find<OrderController>().getLatestOrders(
          category: 'car_mechanical'.tr, pageNo: "1", status: "all");
    } else if (category == 'quick_help'.tr) {
      Get.find<OrderController>().getLatestOrders(
          category: 'quick_help'.tr, pageNo: "1", status: "all");
    } else {
      Get.find<OrderController>().getLatestOrders(
          category: 'car_shoppe'.tr, pageNo: "1", status: "all");
    }
    return GetBuilder<OrderController>(builder: (orderController) {
      return orderController.allServiceModel != null
          ? orderController.allServiceModel.length > 0
              ? RefreshIndicator(
                  onRefresh: () async {
                    if (category == 'car_spa'.tr) {
                      await Get.find<OrderController>().getLatestOrders(
                          category: 'car_spa'.tr, pageNo: "1", status: "all");
                    } else if (category == 'car_mechanical'.tr) {
                      await Get.find<OrderController>().getLatestOrders(
                          category: 'car_mechanical'.tr,
                          pageNo: "1",
                          status: "all");
                    } else if (category == 'quick_help'.tr) {
                      await Get.find<OrderController>().getLatestOrders(
                          category: 'quick_help'.tr,
                          pageNo: "1",
                          status: "all");
                    } else {
                      await Get.find<OrderController>().getLatestOrders(
                          category: 'car_shoppe'.tr,
                          pageNo: "1",
                          status: "all");
                    }
                  },
                  child: ListView.builder(
                    itemCount: orderController.allServiceModel.length,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrderRequestWidget(
                          orderModel: orderController.allServiceModel[index],
                          index: index,
                          onTap: onTap);
                    },
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(child: Text('no_order_request_available'.tr)),
                )
          : Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(child: CircularProgressIndicator()));
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
