import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/api/api_checker.dart';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:carclenx_vendor_app/data/model/response/order_collection_model.dart';
import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';
import 'package:carclenx_vendor_app/data/model/response/ignore_model.dart';
import 'package:carclenx_vendor_app/data/model/response/order_details_model.dart';
import 'package:carclenx_vendor_app/data/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  List<OrderModel> _currentOrderList, _runningOrderList;
  List<OrderModel> _completedOrderList,
      _activeOrderList,
      _newOrderList,
      _canceledOrderList;
  int _tabIndex = 0;
  OrderCollectionModel _orderCollectionModel;
  List<OrderDetailsModel> _orderDetailsModel;
  List<IgnoreModel> _ignoredRequests = [];
  bool _isLoading = false;
  Position _position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: null,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Placemark _placeMark = Placemark(
      name: 'Unknown',
      subAdministrativeArea: 'Location',
      isoCountryCode: 'Found');
  String _otp = '';
  bool _paginate = false;
  int _pageSize;
  List<int> _offsetList = [];
  int _offset = 1;
  OrderModel _orderModel;
  String _toogleType;
  List<Widget> _fliterListOrderRequest = [
    Text("New"),
    Text("Active"),
  ];
  List<Widget> _fliterListOrderHistory = [
    Text("Completed"),
    Text("Cancelled"),
  ];
  List<bool> _selectedFilterOrderRequest = [true, false];
  List<bool> _selectedFilterOrderHistory = [true, false];
  bool _haveMore;

  List<Widget> get fliterListOrderRequest => _fliterListOrderRequest;
  List<Widget> get fliterListOrderHistory => _fliterListOrderHistory;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get runningOrderList => _runningOrderList;
  List<OrderModel> get activeOrderList => _activeOrderList;
  List<OrderModel> get completedOrderList => _completedOrderList;
  List<OrderModel> get newOrderList => _newOrderList;
  List<OrderModel> get canceledOrderList => _canceledOrderList;
  OrderCollectionModel get orderCollectionModel => _orderCollectionModel;

  int get tabIndex => _tabIndex;
  bool get isLoading => _isLoading;
  bool get haveMore => _haveMore;
  Position get position => _position;
  Placemark get placeMark => _placeMark;
  String get address =>
      '${_placeMark.name} ${_placeMark.subAdministrativeArea} ${_placeMark.isoCountryCode}';
  String get otp => _otp;
  bool get paginate => _paginate;
  int get pageSize => _pageSize;
  int get offset => _offset;
  List<bool> get selectedFilterOrderRequest => _selectedFilterOrderRequest;
  List<bool> get selectedFilterOrderHistory => _selectedFilterOrderHistory;
  String get toogleType => _toogleType;
  OrderModel get orderModel => _orderModel;

  void updateToogleType(String type) {
    _toogleType = type;
    update();
  }

  void updateFiltertype({int index, String category, String fromPage}) {
    if (fromPage == "New Order") {
      _selectedFilterOrderRequest.clear();
      for (int i = 0; i < _fliterListOrderRequest.length; i++) {
        if (i == index) {
          _selectedFilterOrderRequest.add(true);
        } else {
          _selectedFilterOrderRequest.add(false);
        }
      }
    } else {
      _selectedFilterOrderHistory.clear();
      for (int i = 0; i < _fliterListOrderHistory.length; i++) {
        if (i == index) {
          _selectedFilterOrderHistory.add(true);
        } else {
          _selectedFilterOrderHistory.add(false);
        }
      }
    }
    setCurrentOrderList(category, index, fromPage);
    update();
  }

  void setCurrentOrderList(String category, int index, String fromPage) {
    if (category == 'car_spa'.tr) {
      if (fromPage == "New Order") {
        if (index == 0) {
          _currentOrderList = orderCollectionModel.carspa.newOrderList;
        } else {
          _currentOrderList = orderCollectionModel.carspa.activeOrderList;
        }
      } else {
        if (index == 0) {
          _currentOrderList = orderCollectionModel.carspa.completedOrderList;
        } else {
          _currentOrderList = orderCollectionModel.carspa.cancelledOrderList;
        }
      }
    } else if (category == 'car_mechanical'.tr) {
      if (fromPage == "New Order") {
        if (index == 0) {
          _currentOrderList = orderCollectionModel.mechanical.newOrderList;
        } else {
          _currentOrderList = orderCollectionModel.mechanical.activeOrderList;
        }
      } else {
        if (index == 0) {
          _currentOrderList =
              orderCollectionModel.mechanical.completedOrderList;
        } else {
          _currentOrderList =
              orderCollectionModel.mechanical.cancelledOrderList;
        }
      }
    } else if (category == 'quick_help'.tr) {
      if (fromPage == "New Order") {
        if (index == 0) {
          _currentOrderList = orderCollectionModel.quickhelp.newOrderList;
        } else {
          _currentOrderList = orderCollectionModel.quickhelp.activeOrderList;
        }
      } else {
        if (index == 0) {
          _currentOrderList = orderCollectionModel.quickhelp.completedOrderList;
        } else {
          _currentOrderList = orderCollectionModel.quickhelp.cancelledOrderList;
        }
      }
    } else {
      if (fromPage == "New Order") {
        if (index == 0) {
          _currentOrderList = newOrderList;
        } else {
          _currentOrderList = activeOrderList;
        }
      } else {
        if (index == 0) {
          _currentOrderList = completedOrderList;
        } else {
          _currentOrderList = canceledOrderList;
        }
      }
    }
    update();
  }

  Future<void> getAllOrders() async {
    Response response = await orderRepo.getAllOrders();
    if (response.statusCode == 200) {
      _orderCollectionModel =
          OrderCollectionModel.fromJson(json: response.body['resultData']);

      Get.find<AuthController>()
          .userModel
          .setOrderCount(_orderCollectionModel.orderCount);
      Get.find<AuthController>()
          .userModel
          .setEarnings(_orderCollectionModel.earnings);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void showBottomLoader() {
    _paginate = true;
    update();
  }

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> getOrderWithId(String orderId) async {
    Response response = await orderRepo.getOrderWithId(orderId);
    if (response.statusCode == 200) {
      _orderModel = OrderModel.fromJson(response.body);
      print('order model : ${_orderModel.toJson()}');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getLatestOrders(
      {String status, String pageNo, String category, String fromPage}) async {
    _isLoading = true;
    _haveMore = false;
    Response response = await orderRepo.getLatestOrders(
        status: status, pageNo: pageNo, category: category);
    if (response.statusCode == 200) {
      _newOrderList = [];
      _activeOrderList = [];
      _completedOrderList = [];
      _canceledOrderList = [];
      if (response.body != null &&
          response.body['resultData'] != null &&
          response.body['resultData'].length > 0) {
        _orderCollectionModel = OrderCollectionModel.fromJsonWithCategory(
            resultBody: response.body, category: category);

        if (fromPage == "New Order") {
          setCurrentOrderList(
              category,
              _selectedFilterOrderRequest
                  .indexWhere((element) => element == true),
              fromPage);
        } else {
          setCurrentOrderList(
              category,
              _selectedFilterOrderHistory
                  .indexWhere((element) => element == true),
              fromPage);
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    updateFiltertype(category: category, fromPage: fromPage, index: 0);
    _isLoading = false;
    update();
  }

  Future<void> recordLocation(RecordLocationBody recordLocationBody) async {
    Response response = await orderRepo.recordLocation(recordLocationBody);
    if (response.statusCode == 200) {
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<bool> updateOrderStatus(int index, String status,
      {bool back = false}) async {
    _isLoading = true;
    update();
    //   UpdateStatusBody _updateStatusBody = UpdateStatusBody(
    //     orderId: _currentOrderList[index].id,
    //     status: status,
    //     otp: status == 'delivered' ? _otp : null,
    //   );
    //   Response response = await orderRepo.updateOrderStatus(_updateStatusBody);
    //   Get.back();
    //   bool _isSuccess;
    //   if (response.statusCode == 200) {
    //     if (back) {
    //       Get.back();
    //     }
    //     _currentOrderList[index].orderStatus = status;
    //     showCustomSnackBar(response.body['message'], isError: false);
    //     _isSuccess = true;
    //   } else {
    //     ApiChecker.checkApi(response);
    //     _isSuccess = false;
    //   }
    //   _isLoading = false;
    //   update();
    //   return _isSuccess;
  }

  // Future<void> updatePaymentStatus(int index, String status) async {
  //   _isLoading = true;
  //   update();
  //   UpdateStatusBody _updateStatusBody =
  //       UpdateStatusBody(orderId: _currentOrderList[index].id, status: status);
  //   Response response = await orderRepo.updatePaymentStatus(_updateStatusBody);
  //   if (response.statusCode == 200) {
  //     _currentOrderList[index].paymentStatus = status;
  //     showCustomSnackBar(response.body['message'], isError: false);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   _isLoading = false;
  //   update();
  // }

  Future<void> getOrderDetails(String orderID) async {
    _orderDetailsModel = null;
    Response response = await orderRepo.getOrderDetails(orderID);
    if (response.statusCode == 200) {
      _orderDetailsModel = [];
      response.body.forEach((orderDetails) =>
          _orderDetailsModel.add(OrderDetailsModel.fromJson(orderDetails)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> acceptOrder(
      int orderID, int index, OrderModel orderModel) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.acceptOrder(orderID);
    Get.back();
    bool _isSuccess;
    if (response.statusCode == 200) {
      // _latestOrderList.removeAt(index);
      // _currentOrderList.add(orderModel);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void getIgnoreList() {
    _ignoredRequests = [];
    _ignoredRequests.addAll(orderRepo.getIgnoreList());
  }

  void ignoreOrder(int index) {
    // _ignoredRequests
    //     .add(IgnoreModel(id: _latestOrderList[index].id, time: DateTime.now()));
    // _latestOrderList.removeAt(index);
    // orderRepo.setIgnoreList(_ignoredRequests);
    update();
  }

  void removeFromIgnoreList() {
    List<IgnoreModel> _tempList = [];
    _tempList.addAll(_ignoredRequests);
    for (int index = 0; index < _tempList.length; index++) {
      if (Get.find<SplashController>()
              .currentTime
              .difference(_tempList[index].time)
              .inMinutes >
          10) {
        _tempList.removeAt(index);
      }
    }
    _ignoredRequests = [];
    _ignoredRequests.addAll(_tempList);
    orderRepo.setIgnoreList(_ignoredRequests);
  }

  Future<void> getCurrentLocation() async {
    Position _currentPosition = await Geolocator.getCurrentPosition();
    if (!GetPlatform.isWeb) {
      try {
        List<Placemark> _placeMarks = await placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude);
        _placeMark = _placeMarks.first;
      } catch (e) {}
    }
    _position = _currentPosition;
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    if (otp != '') {
      update();
    }
  }
}
