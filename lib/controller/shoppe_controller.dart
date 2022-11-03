import 'package:carclenx_vendor_app/data/model/response/product_details_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_make_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_model_model.dart';
import 'package:carclenx_vendor_app/data/repository/shoppe_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ShoppeController extends GetxController implements GetxService {
  ShoppeRepo shoppeRepo;
  ShoppeController({this.shoppeRepo});

  TextEditingController stockCountController = TextEditingController();

  bool isUpdatingStock = false;
  bool isLoading = false;
  List<ProductDetails> myProductList = [];
  ProductDetails selectedProduct;
  List<ProductMake> makeList = [];
  List<ProductModel> modelList = [];

  setStockUpdatingStatus(int quantity) {
    setStockEdit();
    selectedProduct.quantity = quantity;
    update();
  }

  setStockEdit() {
    isUpdatingStock = !isUpdatingStock;
    update();
  }

  setProduct(ProductDetails product) {
    selectedProduct = product;
    myProductList.forEach(
      (element) {
        if (element.id == product.id) {
          element = product;
        }
      },
    );
    update();
  }

  getAllMakeAndModelCount() {
    var modelCount = selectedProduct.modelId.length;
    var idList = Set<String>();
    selectedProduct.modelId
        .where((element) => idList.add(element.makeId.id))
        .toList();
    var makeCount = idList.length;
    return {'makeCount': makeCount, 'modelCount': modelCount};
  }

  getMakeList() {
    Map<String, ProductMake> makeMap = {};
    var makes = [];
    makes = selectedProduct.modelId.map((e) => e.makeId).toList();
    makes.forEach((make) {
      makeMap.putIfAbsent(make.id, () => make);
    });
    makeList = makeMap.values.toList();
    update();
  }

  getModelList(String makeId) {
    modelList = [];
    selectedProduct.modelId.forEach((element) {
      if (element.makeId.id == makeId) {
        modelList.add(element);
      }
    });
    update();
  }

  getMyProducts(String pageNo) async {
    isLoading = true;
    myProductList = [];
    update();
    Response response = await shoppeRepo.getMyProductList(pageNo);
    if (response.statusCode == 200 || response.statusCode == 201) {
      response.body['resultData'].forEach((element) {
        myProductList.add(ProductDetails.fromJson(element));
      });
    }
    isLoading = false;
    update();
  }

  geSingleProducts(String id) async {
    isLoading = true;
    update();
    Response response = await shoppeRepo.getSingleProduct(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      selectedProduct = ProductDetails.fromJson(response.body['resultData']);
    }
    isLoading = false;
    update();
  }
}
