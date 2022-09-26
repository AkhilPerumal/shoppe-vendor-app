import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/view/screens/request/widget/order_requset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class OrderTabPage extends StatelessWidget {
  OrderTabPage({
    Key key,
    this.category,
  }) : super(key: key);

  final String category;
  RefreshController _controller = RefreshController();

  loadOrders({String category, bool reload, bool loadMore}) async {
    if (category == 'car_spa'.tr) {
      var pageNo = 1;
      if (loadMore) {
        pageNo = pageNo + 1;
      }
      await Get.find<OrderController>().getLatestOrders(
          category: 'car_spa'.tr,
          pageNo: pageNo.toString(),
          status: "all",
          fromPage: "New Order");
    } else if (category == 'car_mechanical'.tr) {
      var pageNo = 1;
      if (loadMore) {
        pageNo = pageNo + 1;
      }
      await Get.find<OrderController>().getLatestOrders(
          category: 'car_mechanical'.tr,
          pageNo: pageNo.toString(),
          status: "all",
          fromPage: "New Order");
    } else if (category == 'quick_help'.tr) {
      var pageNo = 1;
      if (loadMore) {
        pageNo = pageNo + 1;
      }
      await Get.find<OrderController>().getLatestOrders(
          category: 'quick_help'.tr,
          pageNo: pageNo.toString(),
          status: "all",
          fromPage: "New Order");
    } else {
      var pageNo = 1;
      if (loadMore) {
        pageNo = pageNo + 1;
      }
      await Get.find<OrderController>().getLatestOrders(
          category: 'car_shoppe'.tr,
          pageNo: pageNo.toString(),
          status: "all",
          fromPage: "New Order");
    }
    if (reload) {
      _controller.refreshCompleted();
    }
    if (loadMore) {
      _controller.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    loadOrders(category: category, reload: false, loadMore: false);
    return GetBuilder<OrderController>(builder: (orderController) {
      return !orderController.isLoading
          ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () {
                if (orderController.currentOrderList.length > 0) {
                  loadOrders(category: category, reload: false, loadMore: true);
                } else {
                  _controller.loadNoData();
                }
              },
              onRefresh: () =>
                  loadOrders(category: category, reload: true, loadMore: false),
              controller: _controller,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                            height: 40.0,
                            width: constraints.maxWidth / 2.2,
                          ),
                          children: orderController.fliterListOrderRequest,
                          onPressed: (int index) {
                            orderController.updateFiltertype(
                                index: index,
                                category: category,
                                fromPage: "New Order");
                          },
                          isSelected:
                              orderController.selectedFilterOrderRequest,
                        );
                      }),
                    ),
                    orderController.currentOrderList != null
                        ? orderController.currentOrderList.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    orderController.currentOrderList.length,
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return OrderRequestWidget(
                                      orderModel: orderController
                                          .currentOrderList[index],
                                      index: index);
                                },
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: Center(
                                  child: Text('no_order_request_available'.tr),
                                ),
                              )
                        : Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(child: CircularProgressIndicator())),
                  ],
                ),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(child: CircularProgressIndicator()));
    });
  }
}
