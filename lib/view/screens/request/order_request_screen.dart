import 'dart:async';

import 'package:carclenx_vendor_app/controller/my_tab_controller.dart';
import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/screens/request/widget/order_tab_page.dart';
import 'package:carclenx_vendor_app/view/screens/request/widget/order_requset_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRequestScreen extends StatelessWidget {
  final Function onTap;
  OrderRequestScreen({@required this.onTap});

  final MyTabController _tabx = Get.put(MyTabController(length: 4));
  double tab_height = 0;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    tab_height = width * 0.2;
    return GetBuilder<MyTabController>(builder: (_tbx) {
      return Scaffold(
        appBar: AppBar(
          title: Text('order_request'.tr,
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: Theme.of(context).textTheme.bodyText1.color)),
          centerTitle: true,
          // backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(100, tab_height),
            child: Container(
              height: tab_height,
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
                  onTap: (value) {
                    _tabx.setTabIndex(value);
                  },
                  tabs: [
                    Container(
                      height: tab_height,
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
                      height: tab_height,
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
                      height: tab_height,
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
                      height: tab_height,
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
          physics: NeverScrollableScrollPhysics(),
          children: [
            OrderTabPage(category: 'car_shoppe'.tr),
            OrderTabPage(category: 'car_spa'.tr),
            OrderTabPage(category: 'car_mechanical'.tr),
            OrderTabPage(category: 'quick_help'.tr)
          ],
        ),
      );
    });
  }
}
