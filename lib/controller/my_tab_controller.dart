import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  MyTabController({this.length});
  final int length;

  TabController tabController;

  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  setTabIndex(int index) {
    _tabIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(vsync: this, length: this.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
