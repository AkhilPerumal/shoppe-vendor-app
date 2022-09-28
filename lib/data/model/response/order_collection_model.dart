import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/user_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:get/get.dart';

class OrderCollectionModel {
  OrderSplitList mechanical;
  OrderSplitList quickhelp;
  OrderSplitList carspa;
  OrderCount orderCount;
  Earnings earnings;

  int mechanical_todays_order_count;
  int mechanical_weekly_order_count;

  int carspa_todays_order_count;
  int carspa_weekly_order_count;

  int quickhelp_todays_order_count;
  int quickhelp_weekly_order_count;

  int mechanical_new_count = 0;
  int mechanical_active_count = 0;
  int mechanical_completed_count = 0;
  int mechanical_cancelled_count = 0;
  int carspa_new_count = 0;
  int carspa_active_count = 0;
  int carspa_completed_count = 0;
  int carspa_cancelled_count = 0;
  int quickhelp_new_count = 0;
  int quickhelp_active_count = 0;
  int quickhelp_completed_count = 0;
  int quickhelp_cancelled_count = 0;

  OrderCollectionModel({this.mechanical, this.quickhelp, this.carspa});

  OrderCollectionModel.fromList({List<OrderModel> orderList, String category}) {
    if (category == 'car_spa'.tr) {
      carspa = OrderSplitList.fromList(orderList);
    }
    if (category == 'car_mechanical'.tr) {
      mechanical = OrderSplitList.fromList(orderList);
    }
    if (category == 'quick_help'.tr) {
      quickhelp = OrderSplitList.fromList(orderList);
    }
  }

  OrderCollectionModel.fromJson({Map<String, dynamic> json}) {
    if (json['carspa'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['carspa'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      carspa = OrderSplitList.fromList(resultData);
    }
    if (json['quickhelp'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['quickhelp'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      quickhelp = OrderSplitList.fromList(resultData);
    }
    if (json['mechanical'] != null) {
      List<OrderModel> resultData = <OrderModel>[];
      json['mechanical'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
      mechanical = OrderSplitList.fromList(resultData);
    }
    getAllCount();
  }
  OrderCollectionModel.fromJsonWithCategory(
      {Map<String, dynamic> resultBody, String category}) {
    List<OrderModel> resultData = <OrderModel>[];
    resultBody['resultData'].forEach((v) {
      resultData.add(new OrderModel.fromJson(v));
    });
    if (category == 'car_spa'.tr) {
      carspa = OrderSplitList.fromList(resultData);
    }
    if (category == 'car_mechanical'.tr) {
      mechanical = OrderSplitList.fromList(resultData);
    }
    if (category == 'quick_help'.tr) {
      quickhelp = OrderSplitList.fromList(resultData);
    }
    getAllCount();
    getEarningsList();
  }

  getAllCount() {
    if (mechanical != null) {
      var count = getSelectiveCategoryWiseCount(orderList: mechanical);
      mechanical_todays_order_count = getTodaysCount(orderList: mechanical);
      mechanical_weekly_order_count = getweeksCount(orderList: mechanical);

      mechanical_active_count = count['active'];
      mechanical_new_count = count['new'];
      mechanical_completed_count = count['completed'];
      mechanical_cancelled_count = count['cancelled'];
      getweeksCount(orderList: mechanical);
    }
    if (carspa != null) {
      var count = getSelectiveCategoryWiseCount(orderList: carspa);
      carspa_todays_order_count = getTodaysCount(orderList: carspa);
      carspa_weekly_order_count = getweeksCount(orderList: carspa);

      carspa_new_count = count['new'];
      carspa_active_count = count['active'];
      carspa_completed_count = count['completed'];
      carspa_cancelled_count = count['cancelled'];
    }
    if (quickhelp != null) {
      var count = getSelectiveCategoryWiseCount(orderList: quickhelp);
      quickhelp_todays_order_count = getTodaysCount(orderList: quickhelp);
      quickhelp_weekly_order_count = getweeksCount(orderList: quickhelp);

      quickhelp_new_count = count['new'];
      quickhelp_active_count = count['active'];
      quickhelp_completed_count = count['completed'];
      quickhelp_cancelled_count = count['cancelled'];
    }
    orderCount = OrderCount(
        carspa_todays_order_count: carspa_todays_order_count,
        carspa_weekly_order_count: carspa_weekly_order_count,
        mechanical_todays_order_count: mechanical_todays_order_count,
        mechanical_weekly_order_count: mechanical_weekly_order_count,
        quickhelp_todays_order_count: quickhelp_todays_order_count,
        quickhelp_weekly_order_count: quickhelp_weekly_order_count,
        carspa_active_count: carspa_active_count,
        carspa_new_count: carspa_new_count,
        carspa_completed_count: carspa_completed_count,
        carspa_cancelled_count: carspa_cancelled_count,
        mechanical_active_count: mechanical_active_count,
        mechanical_new_count: mechanical_new_count,
        mechanical_cancelled_count: mechanical_cancelled_count,
        mechanical_completed_count: mechanical_completed_count,
        quickhelp_active_count: quickhelp_active_count,
        quickhelp_new_count: quickhelp_new_count,
        quickhelp_completed_count: quickhelp_completed_count,
        quickhelp_cancelled_count: quickhelp_cancelled_count);
  }

  getSelectiveCategoryWiseCount({OrderSplitList orderList}) {
    return {
      'new': orderList != null ? orderList.newOrderList.length : 0,
      'active': orderList != null ? orderList.activeOrderList.length : 0,
      'completed': orderList != null ? orderList.completedOrderList.length : 0,
      'cancelled': orderList != null ? orderList.cancelledOrderList.length : 0
    };
  }

  getTodaysCount({OrderSplitList orderList}) {
    return orderList != null && orderList.activeOrderList.length > 0
        ? orderList.activeOrderList
            .where((element) =>
                DateConverter.dateTimeStringToDate(element.date) ==
                DateConverter.dateTimeStringToDate(DateTime.now().toString()))
            .toList()
            .length
        : 0;
  }

  getweeksCount({OrderSplitList orderList}) {
    return orderList != null && orderList.activeOrderList.length > 0
        ? orderList.activeOrderList
            .where((element) => DateConverter.checkDatesAreOnSameWeek(
                date1: DateTime.parse(element.date)))
            .toList()
            .length
        : 0;
  }

  getEarningsList() {
    var todayEarning = getTodayEarningOfCategory(orderList: carspa) +
        getTodayEarningOfCategory(orderList: mechanical) +
        getTodayEarningOfCategory(orderList: quickhelp);
    var weeklyEarning = getWeeklyEarningOfCategory(orderList: carspa) +
        getWeeklyEarningOfCategory(orderList: mechanical) +
        getWeeklyEarningOfCategory(orderList: quickhelp);
    var monthlyEarning = getMonthlyEarningOfCategory(orderList: carspa) +
        getMonthlyEarningOfCategory(orderList: mechanical) +
        getMonthlyEarningOfCategory(orderList: quickhelp);
    var totalEarning = getTotalEarning(orderList: carspa) +
        getTotalEarning(orderList: mechanical) +
        getTotalEarning(orderList: quickhelp);

    earnings = Earnings(
        today_earning: todayEarning,
        week_earning: weeklyEarning,
        month_earning: monthlyEarning,
        total_earned: totalEarning);
  }

  getTotalEarning({OrderSplitList orderList}) {
    var total = 0;
    if (orderList != null && orderList.completedOrderList.length > 0) {
      orderList.completedOrderList.forEach((element) {
        total = element.grandTotal + total;
      });
    }
    return total;
  }

  getTodayEarningOfCategory({OrderSplitList orderList}) {
    var total = 0;
    List<OrderModel> orders;
    if (orderList != null && orderList.completedOrderList.length > 0) {
      orders = orderList.completedOrderList
          .where((element) =>
              DateConverter.dateTimeStringToDate(element.date) ==
              DateConverter.dateTimeStringToDate(DateTime.now().toString()))
          .toList();
    }

    if (orders != null && orders.length > 0) {
      orders.forEach((element) {
        total = element.grandTotal + total;
      });
    }
    return total;
  }

  getWeeklyEarningOfCategory({OrderSplitList orderList}) {
    var total = 0;
    List<OrderModel> orders;
    if (orderList != null && orderList.completedOrderList.length > 0) {
      orders = orderList.completedOrderList
          .where((element) => DateConverter.checkDatesAreOnSameWeek(
              date1: DateTime.parse(element.date)))
          .toList();
    }
    if (orders != null && orders.length > 0) {
      orders.forEach((element) {
        total = element.grandTotal + total;
      });
    }
    return total;
  }

  getMonthlyEarningOfCategory({OrderSplitList orderList}) {
    var total = 0;
    List<OrderModel> orders;
    if (orderList != null && orderList.completedOrderList.length > 0) {
      orders = orderList.completedOrderList
          .where((element) => DateConverter.checkDatesAreOnSameMonth(
              date1: DateTime.parse(element.date)))
          .toList();
    }
    if (orders != null && orders.length > 0) {
      orders.forEach((element) {
        total = element.grandTotal + total;
      });
    }
    return total;
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

  OrderSplitList.fromList(List<OrderModel> orderList) {
    newOrderList = [];
    activeOrderList = [];
    completedOrderList = [];
    cancelledOrderList = [];
    orderList.forEach((element) {
      if (element.status == "Active" || element.status == "Reassigned") {
        newOrderList.add(element);
      } else if (element.status == "Accepted") {
        activeOrderList.add(element);
      } else if (element.status == "Completed" ||
          element.status == "Rejected") {
        completedOrderList.add(element);
      } else {
        cancelledOrderList.add(element);
      }
    });
  }
}
