import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/loading_screen.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/widget/my_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ShoppeScreen extends StatelessWidget {
  ShoppeScreen({Key key}) : super(key: key);
  int pageNo = 1;
  void _onLoading() async {
    pageNo = pageNo++;
    Get.find<ShoppeController>().getMyProducts(pageNo.toString());
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    Get.find<ShoppeController>().getMyProducts(pageNo.toString());
    _refreshController.refreshCompleted();
  }

  //refresh controller for pagination.
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppeController>(builder: (shoppeController) {
      return Scaffold(
          appBar:
              CustomAppBar(title: "Manage My Shoppe", isBackButtonExist: false),
          floatingActionButton: shoppeController.isLoading
              ? SizedBox()
              : FloatingActionButton(
                  heroTag: 'nothing',
                  onPressed: () {
                    Get.find<CreateProductController>().getAllCategoryDetails();
                    Get.toNamed(RouteHelper.addProduct);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.add_circle_outline,
                      color: Theme.of(context).cardColor, size: 30),
                ),
          body: shoppeController.isLoading
              ? LoadingScreen()
              : SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  header: const WaterDropHeader(),
                  onRefresh: _onRefresh,
                  onLoading: (shoppeController.myProductList.length == 20)
                      ? _onLoading
                      : () async {
                          await Future.delayed(
                              const Duration(milliseconds: 500), () {
                            _refreshController.loadComplete();
                          });
                        },
                  child: shoppeController.myProductList.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: shoppeController.myProductList.length,
                          itemBuilder: ((context, index) {
                            return MyProductWidget(
                                productDetails:
                                    shoppeController.myProductList[index]);
                          }))
                      : Center(
                          child: Text("No Product Added"),
                        ),
                ));
    });
  }
}
