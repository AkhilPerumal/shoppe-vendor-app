import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';

class OrderCollectionModel {
  MechanicalOrders mechanicalOrders;
  CarSpaOrders carSpaOrders;
  QuickHelpOrders quickHelpOrders;
  OrderCollectionModel(
      {this.carSpaOrders, this.mechanicalOrders, this.quickHelpOrders});
}

class MechanicalOrders {
  List<OrderModel> newOrderList = [];
  List<OrderModel> activeOrderList = [];
  List<OrderModel> completedOrderList = [];
  List<OrderModel> cancelledOrderList = [];

  MechanicalOrders(
      {this.newOrderList,
      this.activeOrderList,
      this.completedOrderList,
      this.cancelledOrderList});
}

class CarSpaOrders {
  List<OrderModel> newOrderList;
  List<OrderModel> activeOrderList;
  List<OrderModel> completedOrderList;
  List<OrderModel> cancelledOrderList;

  CarSpaOrders(
      {this.newOrderList,
      this.activeOrderList,
      this.completedOrderList,
      this.cancelledOrderList});

  CarSpaOrders.fromList({
    List<OrderModel> newOrders,
    List<OrderModel> activeOrders,
    List<OrderModel> completedOrders,
    List<OrderModel> cancelledOrders,
  }) {
    if (newOrders != null) {
      newOrderList = <OrderModel>[];
      newOrders.forEach((v) {
        newOrderList.add(new OrderModel.fromJson(v.toJson()));
      });
    }
    if (activeOrders != null) {
      activeOrderList = <OrderModel>[];
      activeOrders.forEach((v) {
        activeOrderList.add(new OrderModel.fromJson(v.toJson()));
      });
    }
    if (completedOrders != null) {
      completedOrderList = <OrderModel>[];
      completedOrders.forEach((v) {
        completedOrderList.add(new OrderModel.fromJson(v.toJson()));
      });
    }
    if (cancelledOrders != null) {
      cancelledOrderList = <OrderModel>[];
      cancelledOrders.forEach((v) {
        cancelledOrderList.add(new OrderModel.fromJson(v.toJson()));
      });
    }
  }
}

class QuickHelpOrders {
  List<OrderModel> newOrderList = [];
  List<OrderModel> activeOrderList = [];
  List<OrderModel> completedOrderList = [];
  List<OrderModel> cancelledOrderList = [];

  QuickHelpOrders(
      {this.newOrderList,
      this.activeOrderList,
      this.completedOrderList,
      this.cancelledOrderList});
}
