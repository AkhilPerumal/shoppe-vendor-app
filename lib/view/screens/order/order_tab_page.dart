import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_order/widget/order_product_widget.dart';
import 'package:carclenx_vendor_app/view/screens/service_order/widget/order_requset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class OrderTabPage extends StatelessWidget {
  OrderTabPage({
    Key key,
    this.category,
  }) : super(key: key);

  final CategoryType category;
  RefreshController _controller = RefreshController();

  loadOrders({bool reload, bool loadMore}) {
    var pageNo = 1;
    if (loadMore && Get.find<OrderController>().totalPage <= pageNo) {
      pageNo = pageNo + 1;
      Get.find<OrderController>()
          .setCurrentOrderList(category: category, pageNo: pageNo.toString());
      if (Get.find<OrderController>().totalPage == pageNo) {
        _controller.loadNoData();
      }
      _controller.loadComplete();
    }

    if (reload) {
      pageNo = 1;
      Get.find<OrderController>()
          .setCurrentOrderList(category: category, pageNo: pageNo.toString());
      _controller.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return !orderController.isLoading
          ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () {
                if (orderController.currentOrderList.length > 0) {
                  loadOrders(reload: false, loadMore: true);
                } else {
                  _controller.loadNoData();
                }
              },
              onRefresh: () => loadOrders(reload: true, loadMore: false),
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
                            orderController.updateSubTab(
                                index == 0 ? SubTabType.NEW : SubTabType.ACTIVE,
                                category);
                          },
                          isSelected:
                              orderController.selectedFilterOrderRequest,
                        );
                      }),
                    ),
                    category == CategoryType.CAR_SHOPPE
                        ? orderController.shoppeOrderList != null
                            ? orderController.shoppeOrderList.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        orderController.shoppeOrderList.length,
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return OrderProductWidget(
                                          orderdetails: orderController
                                              .shoppeOrderList[index]);
                                    },
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Center(
                                      child:
                                          Text('no_order_request_available'.tr),
                                    ),
                                  )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child:
                                    Center(child: CircularProgressIndicator()))
                        : orderController.currentOrderList != null
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
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Center(
                                      child:
                                          Text('no_order_request_available'.tr),
                                    ),
                                  )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child:
                                    Center(child: CircularProgressIndicator())),
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
