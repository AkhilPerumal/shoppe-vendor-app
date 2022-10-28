import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';

class OrderCollectionModel {
  OrderSplitList mechanical;
  OrderSplitList quickhelp;
  OrderSplitList carspa;

  OrderCollectionModel({this.mechanical, this.quickhelp, this.carspa});

  OrderCollectionModel.fromList(
      {List<OrderModel> orderList, CategoryType category}) {
    if (category == CategoryType.CAR_SPA) {
      carspa =
          OrderSplitList.fromList(orderList: orderList, category: category);
    }
    if (category == CategoryType.CAR_MECHANIC) {
      mechanical =
          OrderSplitList.fromList(orderList: orderList, category: category);
    }
    if (category == CategoryType.QUICK_HELP) {
      quickhelp =
          OrderSplitList.fromList(orderList: orderList, category: category);
    }
  }

  OrderCollectionModel.fromJson({Map<String, dynamic> json}) {
    if (json['carspa'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['carspa'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      carspa = OrderSplitList.fromList(
          orderList: resultData, category: CategoryType.CAR_SPA);
    }
    if (json['quickhelp'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['quickhelp'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      quickhelp = OrderSplitList.fromList(
          orderList: resultData, category: CategoryType.QUICK_HELP);
    }
    if (json['mechanical'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['mechanical'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      mechanical = OrderSplitList.fromList(
          orderList: resultData, category: CategoryType.CAR_MECHANIC);
    }
  }
  OrderCollectionModel.fromJsonWithCategory(
      {Map<String, dynamic> resultBody, CategoryType category}) {
    List<OrderModel> resultData = <OrderModel>[];
    resultBody['resultData'].forEach((v) {
      resultData.add(new OrderModel.fromJson(v));
    });
    if (category == CategoryType.CAR_SPA) {
      carspa =
          OrderSplitList.fromList(orderList: resultData, category: category);
    }
    if (category == CategoryType.CAR_MECHANIC) {
      mechanical =
          OrderSplitList.fromList(orderList: resultData, category: category);
    }
    if (category == CategoryType.QUICK_HELP) {
      quickhelp =
          OrderSplitList.fromList(orderList: resultData, category: category);
    }
  }
}

class OrderSplitList {
  List<OrderModel> newOrderList;
  List<OrderModel> activeOrderList;
  List<OrderModel> completedOrderList;
  List<OrderModel> cancelledOrderList;

  OrderSplitList(
      {this.newOrderList,
      this.activeOrderList,
      this.cancelledOrderList,
      this.completedOrderList});

  OrderSplitList.fromList({List<OrderModel> orderList, CategoryType category}) {
    newOrderList = [];
    activeOrderList = [];
    completedOrderList = [];
    cancelledOrderList = [];
    orderList.forEach((element) {
      element.category = category;
    });

    orderList.forEach((element) {
      if (element.status == OrderStatus.ACTIVE ||
          element.status == OrderStatus.REASSIGNED) {
        newOrderList.add(element);
      }
      if (element.status == OrderStatus.ACCEPTED ||
          element.status == OrderStatus.IN_PROGRESS) {
        activeOrderList.add(element);
      }
      if (element.status == OrderStatus.COMPLETED) {
        completedOrderList.add(element);
      }
      if (element.status == OrderStatus.CANCELLED) {
        cancelledOrderList.add(element);
      }
    });
  }
}
