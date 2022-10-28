import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/api/api_checker.dart';
import 'package:carclenx_vendor_app/data/model/body/completed_service_body_model.dart';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';
import 'package:carclenx_vendor_app/data/model/response/ignore_model.dart';
import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_order_details.dart';
import 'package:carclenx_vendor_app/data/repository/order_repo.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  List<OrderModel> _currentOrderList, _runningOrderList;
  List<ProductOrderDetails> _shoppeOrderList;

  int _tabIndex = 0;
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
  int _totalPage;
  int _pageSize;
  int _offset = 1;
  OrderModel _selectedOrder;
  ProductOrderDetails _selectedShoppeProduct;
  String _toogleType;
  List<Widget> _fliterListOrderRequest = [Text("New"), Text("Active")];
  List<Widget> _fliterListOrderHistory = [Text("Completed"), Text("Cancelled")];
  List<bool> _selectedFilterOrderRequest = [true, false];
  List<bool> _selectedFilterOrderHistory = [true, false];
  bool _haveMore;
  SubTabType _selectedSubTab;

  List<Widget> get fliterListOrderRequest => _fliterListOrderRequest;
  List<Widget> get fliterListOrderHistory => _fliterListOrderHistory;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get runningOrderList => _runningOrderList;
  List<ProductOrderDetails> get shoppeOrderList => _shoppeOrderList;

  int get tabIndex => _tabIndex;
  bool get isLoading => _isLoading;
  bool get haveMore => _haveMore;
  Position get position => _position;
  Placemark get placeMark => _placeMark;
  String get address =>
      '${_placeMark.name} ${_placeMark.subAdministrativeArea} ${_placeMark.isoCountryCode}';
  String get otp => _otp;
  bool get paginate => _paginate;
  int get totalPage => _totalPage;
  int get pageSize => _pageSize;
  int get offset => _offset;
  List<bool> get selectedFilterOrderRequest => _selectedFilterOrderRequest;
  List<bool> get selectedFilterOrderHistory => _selectedFilterOrderHistory;
  String get toogleType => _toogleType;
  OrderModel get selectedOrder => _selectedOrder;
  ProductOrderDetails get selectedShoppeOrder => _selectedShoppeProduct;
  SubTabType get slectedSubTab => _selectedSubTab;

  updateSubTab(SubTabType subTabType, CategoryType categoryType) {
    _selectedSubTab = subTabType;
    // _selectedFilterOrderHistory.clear();
    // _selectedFilterOrderRequest.clear();
    switch (subTabType) {
      case SubTabType.NEW:
        _selectedFilterOrderRequest = [true, false];
        break;
      case SubTabType.ACTIVE:
        _selectedFilterOrderRequest = [false, true];
        break;
      case SubTabType.COMPELTED:
        _selectedFilterOrderHistory = [true, false];
        break;
      case SubTabType.CANCELLED:
        _selectedFilterOrderHistory = [false, true];
        break;
    }
    setCurrentOrderList(category: categoryType);
    update();
  }

  void updateAddOnStatus({int selectedIndex}) {
    selectedOrder.addOn[selectedIndex].isSelected =
        selectedOrder.addOn[selectedIndex].isSelected ? false : true;

    update();
  }

  void setServiceSelectedOrder(OrderModel orderModel) {
    _selectedOrder = orderModel;
    update();
  }

  void setShoppeSelectedOrder(ProductOrderDetails orderModel) {
    _selectedShoppeProduct = orderModel;
    update();
  }

  void setCurrentOrderList({CategoryType category, String pageNo = "1"}) {
    if (category == CategoryType.CAR_SHOPPE) {
      if (_selectedSubTab == SubTabType.NEW) {
        getLatestOrders(
            category: CategoryType.CAR_SHOPPE,
            pageNo: pageNo,
            status: "Processing");
      }
      if (_selectedSubTab == SubTabType.ACTIVE) {
        getLatestOrders(
            category: CategoryType.CAR_SHOPPE, pageNo: pageNo, status: "live");
      }
      if (_selectedSubTab == SubTabType.COMPELTED) {
        getLatestOrders(
            category: CategoryType.CAR_SHOPPE,
            pageNo: pageNo,
            status: "Completed");
      }
      if (_selectedSubTab == SubTabType.CANCELLED) {
        getLatestOrders(
            category: CategoryType.CAR_SHOPPE,
            pageNo: pageNo,
            status: "dropped");
      }
    }
    if (category == CategoryType.CAR_SPA) {
      if (_selectedSubTab == SubTabType.NEW) {
        getLatestOrders(
            category: CategoryType.CAR_SPA, pageNo: pageNo, status: "new");
      }
      if (_selectedSubTab == SubTabType.ACTIVE) {
        getLatestOrders(
            category: CategoryType.CAR_SPA, pageNo: pageNo, status: "live");
      }
      if (_selectedSubTab == SubTabType.COMPELTED) {
        getLatestOrders(
            category: CategoryType.CAR_SPA,
            pageNo: pageNo,
            status: "Completed");
      }
      if (_selectedSubTab == SubTabType.CANCELLED) {
        getLatestOrders(
            category: CategoryType.CAR_SPA, pageNo: pageNo, status: "dropped");
      }
    }

    if (category == CategoryType.CAR_MECHANIC) {
      if (_selectedSubTab == SubTabType.NEW) {
        getLatestOrders(
            category: CategoryType.CAR_MECHANIC, pageNo: pageNo, status: "new");
      }
      if (_selectedSubTab == SubTabType.ACTIVE) {
        getLatestOrders(
            category: CategoryType.CAR_MECHANIC,
            pageNo: pageNo,
            status: "live");
      }
      if (_selectedSubTab == SubTabType.COMPELTED) {
        getLatestOrders(
            category: CategoryType.CAR_MECHANIC,
            pageNo: pageNo,
            status: "Completed");
      }
      if (_selectedSubTab == SubTabType.CANCELLED) {
        getLatestOrders(
            category: CategoryType.CAR_MECHANIC,
            pageNo: pageNo,
            status: "dropped");
      }
    }
    if (category == CategoryType.QUICK_HELP) {
      if (_selectedSubTab == SubTabType.NEW) {
        getLatestOrders(
            category: CategoryType.QUICK_HELP, pageNo: "1", status: "new");
      }
      if (_selectedSubTab == SubTabType.ACTIVE) {
        getLatestOrders(
            category: CategoryType.QUICK_HELP, pageNo: "1", status: "live");
      }
      if (_selectedSubTab == SubTabType.COMPELTED) {
        getLatestOrders(
            category: CategoryType.QUICK_HELP,
            pageNo: "1",
            status: "Completed");
      }
      if (_selectedSubTab == SubTabType.CANCELLED) {
        getLatestOrders(
            category: CategoryType.QUICK_HELP, pageNo: "1", status: "dropped");
      }
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
      _selectedOrder = OrderModel.fromJson(response.body);
      print('order model : ${_selectedOrder.toJson()}');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getLatestOrders(
      {String status, String pageNo, CategoryType category}) async {
    _isLoading = true;
    _currentOrderList = [];
    _shoppeOrderList = [];
    _haveMore = false;
    update();
    Response response = await orderRepo.getLatestOrders(
        status: status, pageNo: pageNo, category: category);
    if (response.statusCode == 200) {
      if (response.body != null &&
          response.body['resultData'] != null &&
          response.body['resultData'].length > 0) {
        if (category != CategoryType.CAR_SHOPPE) {
          response.body['resultData'].forEach((data) {
            _currentOrderList.add(OrderModel.fromJson(data));
          });
          _currentOrderList.forEach((element) {
            element.category = category;
          });
        } else {
          response.body['resultData'].forEach((data) {
            _shoppeOrderList.add(ProductOrderDetails.fromJson(data));
          });
        }
        _totalPage = response.body['totalPages'];
        _isLoading = false;
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
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

  Future<bool> serviceOrderStatusUpdate(
      {String orderID, OrderModel orderModel, OrderStatus status}) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.orderStatusUpdate(
        orderID: orderID,
        status: EnumConverter.convertEnumToStatus(status),
        category: orderModel.category);
    Get.back();
    bool _isSuccess;
    if (response.statusCode == 200) {
      updateOrderStatusLocal(
          category: orderModel.category,
          orderID: orderModel.id,
          status: status);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<bool> shoppeOrderStatusUpdate(
      {String orderID,
      ProductOrderDetails orderModel,
      OrderStatus status}) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.orderStatusUpdate(
        orderID: orderID,
        status: EnumConverter.convertEnumToStatus(status),
        category: CategoryType.CAR_SHOPPE);
    Get.back();
    bool _isSuccess;
    if (response.statusCode == 200) {
      updateOrderStatusLocal(
          category: CategoryType.CAR_SHOPPE,
          orderID: orderModel.id,
          status: status);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  updateOrderStatusLocal(
      {CategoryType category, String orderID, OrderStatus status}) {
    if (status == OrderStatus.ACCEPTED ||
        status == OrderStatus.CANCELLED ||
        status == OrderStatus.REJECTED ||
        status == OrderStatus.COMPLETED) {
      if (category == CategoryType.CAR_SPA) {
        _currentOrderList.removeWhere(((element) => orderID == element.id));
      }
      if (category == CategoryType.CAR_MECHANIC) {
        _currentOrderList.removeWhere(((element) => orderID == element.id));
      }
      if (category == CategoryType.QUICK_HELP) {
        _currentOrderList.removeWhere(((element) => orderID == element.id));
      }
    }
    if (category == CategoryType.CAR_SHOPPE) {
      if (status != OrderStatus.DISPATCHED) {
        _shoppeOrderList.removeWhere(((element) => orderID == element.id));
      }
    }
    update();
  }

  Future<bool> generateHappyCode(
      {List<AddOn> addons, CategoryType category}) async {
    List<AddOn> selectedAddon = [];
    addons.forEach((element) {
      selectedAddon.add(AddOn(name: element.name, price: element.price));
    });
    CompletedServiceBody completedServiceBody = CompletedServiceBody(
        orderId: selectedOrder.id,
        completedReport: CompletedReport(
            addOns: selectedAddon, serviceId: selectedOrder.serviceId.id));
    Response response = await orderRepo.generateHappyCode(
        category: category, body: completedServiceBody.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("StatusCode Generated  :  " + response.body.toString());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyHappyCode(String code, CategoryType category) async {
    Response response = await orderRepo.verifyHappyCode(
        body: {"orderId": selectedOrder.id, "code": code}, category: category);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("HappyCode verified :  " + response.body.toString());
      return true;
    } else {
      return false;
    }
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
