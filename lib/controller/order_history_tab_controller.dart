import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderHistoryTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  OrderHistoryTabController({this.length});
  final int length;

  TabController tabController;

  int _tabIndex = 0;
  SubTabType _subTabType;

  int get tabIndex => _tabIndex;

  SubTabType get subTabType => _subTabType;

  setTabIndex({int index, SubTabType subTabType}) {
    _tabIndex = index;
    _subTabType = subTabType;
    tabController.index = _tabIndex;
    loadData(tabIndex: _tabIndex, subTabType: subTabType);
    update();
  }

  void initialize() {
    tabController = TabController(vsync: this, length: this.length);

    // loadData(tabIndex: _tabIndex, subTabType: SubTabType.COMPELTED);

    tabController.addListener(() {
      if (_tabIndex != tabController.index) {
        _tabIndex = tabController.index;
        loadData(tabIndex: _tabIndex, subTabType: SubTabType.COMPELTED);
        update();
      }
    });
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  loadData({int tabIndex, SubTabType subTabType}) {
    if (tabIndex == 0) {
      Get.find<OrderController>()
          .updateSubTab(subTabType, CategoryType.CAR_SHOPPE);
    } else if (tabIndex == 1) {
      Get.find<OrderController>()
          .updateSubTab(subTabType, CategoryType.CAR_SPA);
    } else if (tabIndex == 2) {
      Get.find<OrderController>()
          .updateSubTab(subTabType, CategoryType.CAR_MECHANIC);
    } else {
      Get.find<OrderController>()
          .updateSubTab(subTabType, CategoryType.QUICK_HELP);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
