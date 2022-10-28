import 'dart:io';
import 'dart:math';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/data/model/response/product_category_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_details_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_sub_category_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as Http;
import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/create_product_categories_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_make_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_model_model.dart';
import 'package:carclenx_vendor_app/data/repository/shoppe_repo.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductController extends GetxController implements GetxService {
  ShoppeRepo shoppeRepo;
  CreateProductController({@required this.shoppeRepo});

  bool isLoading = false;
  bool isSelectedCustomBrand = false;
  int stockCount = 0;
  bool isError = false;
  String createdProductId;
  XFile pickedImage;

  String generalID = "";
  String selectedCategory = "choose";
  String selectedSubCategory = "choose";
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockCountController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode countNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode discountNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  CreateProductCategoriesModel productCategoriesModel;
  List<ProductModel> modelList;
  List<ProductModel> selectedModelList;
  List<ProductMake> makeList;
  List<ProductSubCategory> selectedSubCategoryList = [
    ProductSubCategory(id: "choose", name: "CHOOSE")
  ];
  List<File> pickedImageList = [];

  updateMakeGeneralStatus() {
    isSelectedCustomBrand = !isSelectedCustomBrand;
    update();
  }

  setCategory(String value, bool isCategory) {
    if (isCategory) {
      selectedCategory = value;
    } else {
      selectedSubCategory = value;
    }
    update();
  }

  setQuantity({bool isIncrement, int count, bool isInitial = false}) {
    if (isInitial) {
      if (count != null) {
        stockCount = count;
      } else {
        stockCount = 0;
      }
    } else {
      if (stockCountController.text != null &&
          stockCountController.text != '') {
        stockCount = int.tryParse(stockCountController.text);
      } else {
        stockCount = 0;
      }
      if (isIncrement) {
        stockCount = stockCount + 1;
      } else {
        if (stockCount > 0) {
          stockCount = stockCount - 1;
        }
      }
    }
    stockCountController.text = stockCount.toString();
    update();
  }

  setSubCategoryList(String id) {
    selectedSubCategoryList = [];
    selectedSubCategory = "choose";
    selectedSubCategoryList.insert(
        0, ProductSubCategory(id: "choose", name: "CHOOSE"));
    if (id != "choose") {
      productCategoriesModel.subcategories.forEach((element) {
        if (element.categoryId == id) {
          selectedSubCategoryList.add(element);
        }
      });
    }
    update();
  }

  getModelList(String makeId) {
    modelList = [];
    productCategoriesModel.models.forEach((element) {
      if (element.makeId.id == makeId) {
        modelList.add(element);
      }
    });
    update();
  }

  searchMake(String keyWord) {
    if (keyWord != "" && keyWord != null) {
      var selected = productCategoriesModel.makes
          .where((element) => element.name.contains(keyWord.toUpperCase()))
          .toList();
      if (selected != null && selected.length > 0) {
        makeList = selected;
      } else {
        makeList = null;
      }
    } else {
      makeList = productCategoriesModel.makes;
    }
    update();
  }

  selectModel({List<String> idList, bool status}) {
    idList.forEach((id) {
      modelList.forEach((element) {
        if (element.id == id) {
          element.isSelected = status;
        }
      });
    });
    update();
  }

  checkallModelSelected() {
    if (modelList.where((element) => element.isSelected == true).length ==
        modelList.length) {
      return true;
    } else {
      return false;
    }
  }

  getSelectedModelCount(String id) {
    selectedModelList = [];
    productCategoriesModel.models.forEach((element) {
      if (element.makeId.id == id) {
        if (element.isSelected) {
          selectedModelList.add(element);
        }
      }
    });
    return selectedModelList.length;
  }

  setForAddProduct() {
    selectedCategory = "choose";
    selectedSubCategory = "choose";
    nameController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    descriptionController = TextEditingController();
    stockCountController = TextEditingController();
    nameNode = FocusNode();
    countNode = FocusNode();
    priceNode = FocusNode();
    discountNode = FocusNode();
    descriptionNode = FocusNode();
    isSelectedCustomBrand = false;
    productCategoriesModel = CreateProductCategoriesModel();
    modelList = [];
    selectedModelList = [];
    makeList = [];
    selectedSubCategoryList = [
      ProductSubCategory(id: "choose", name: "CHOOSE")
    ];
    pickedImageList = [];
    update();
  }

  setForEditProduct(ProductDetails product) {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    discountController.text = product.offerPrice.toString();
    descriptionController.text = product.description;
    stockCountController.text = product.quantity.toString();
    selectedCategory = product.categoryId.id;
    isSelectedCustomBrand =
        product.modelId.where((element) => element.name == "GENERAL").isEmpty;
    product.modelId.forEach((selectedModel) {
      productCategoriesModel.models.forEach((allModel) {
        if (selectedModel.id == allModel.id) {
          allModel.isSelected = true;
        }
      });
    });
    selectedSubCategoryList = [];
    selectedSubCategoryList.insert(
        0, ProductSubCategory(id: "choose", name: "CHOOSE"));
    selectedSubCategory = product.subCategoryId.id;
    if (selectedCategory != "choose") {
      productCategoriesModel.subcategories.forEach((element) {
        if (element.categoryId == selectedCategory) {
          selectedSubCategoryList.add(element);
        }
      });
    }
    update();
  }

  getAllMakeAndModelCount() {
    selectedModelList = [];

    productCategoriesModel.models.forEach((element) {
      if (element.isSelected) {
        selectedModelList.add(element);
      }
    });
    var modelCount = selectedModelList.length;

    var idList = Set<String>();
    selectedModelList
        .where((element) => idList.add(element.makeId.id))
        .toList();
    var makeCount = idList.length;
    return {'makeCount': makeCount, 'modelCount': modelCount};
  }

  void pickImage({bool singleImage}) async {
    if (singleImage) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpeg', 'png', 'gif']);
      update();
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['jpeg', 'png', 'gif'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        files.forEach(
          (element) {
            pickedImageList.add(element);
          },
        );
        update();
      } else {
        // User canceled the picker
      }
    }
  }

  void removeImage(int index) {
    pickedImageList.removeAt(index);
    update();
  }

  Future getAllCategoryDetails() async {
    isLoading = true;
    setForAddProduct();
    selectedCategory = "choose";
    selectedSubCategory = "choose";
    update();
    Response response = await shoppeRepo.getAllCategoryDetails();
    if (response.statusCode == 200 && response.body['resultData'] != null) {
      productCategoriesModel =
          CreateProductCategoriesModel.fromJson(response.body['resultData']);
      productCategoriesModel.categories
          .insert(0, ProductCategory(id: "choose", name: "CHOOSE"));
      productCategoriesModel.models.forEach((element) {
        if (element.name == "GENERAL") {
          generalID = element.id;
        }
      });
      var indexOfMakeGeneral = productCategoriesModel.makes
          .indexWhere((element) => element.name == "GENERAL");
      if (indexOfMakeGeneral != null) {
        productCategoriesModel.makes.removeAt(indexOfMakeGeneral);
      }
      makeList = productCategoriesModel.makes;
      isLoading = false;
      update();
      return true;
    } else {
      isLoading = false;
      update();
      return false;
    }
  }

  Future createProduct() async {
    isLoading = true;
    update();
    var selectedModelIdLit = [];
    productCategoriesModel.models.forEach((element) {
      if (element.isSelected) {
        selectedModelIdLit.add(element.id);
      }
    });
    if ((nameController.text == "" || nameController.text == null)) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Name of Product", isError: true);
    }
    if (priceController.text == "" || priceController.text == null) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Price", isError: true);
    }
    if (discountController.text == "" || discountController.text == null) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Price", isError: true);
    }
    if (descriptionController.text == "" ||
        descriptionController.text == null) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Description", isError: true);
    }
    if (stockCountController.text == "" ||
        stockCountController.text == null ||
        stockCountController.text == "0") {
      isError = true;
      update();
      showCustomSnackBar("Please add Stock", isError: true);
    }
    if (isSelectedCustomBrand == true) {
      if (selectedModelIdLit == null || selectedModelIdLit.length == 0) {
        isError = true;
        update();
        showCustomSnackBar("You should choose atleast one car model",
            isError: true);
      }
    }
    if (selectedCategory == null || selectedCategory == "") {
      isError = true;
      update();
      showCustomSnackBar("You need to choose a Category", isError: true);
    }
    if (selectedSubCategory == null || selectedSubCategory == "") {
      isError = true;
      update();
      showCustomSnackBar("You need to choose a Sub-Category", isError: true);
    }
    if (!isError) {
      var product;
      if (discountController.text != null && discountController.text != "") {
        product = {
          'name': nameController.text,
          'user_id': Get.find<AuthController>().userModel.id,
          'price': priceController.text,
          'description': descriptionController.text,
          'model_id': isSelectedCustomBrand ? selectedModelIdLit : [generalID],
          'category_id': selectedCategory,
          'sub_category_id': selectedSubCategory,
          'quantity': stockCountController.text,
          'offerPrice': discountController.text,
        };
      } else {
        product = {
          'name': nameController.text,
          'user_id': Get.find<AuthController>().userModel.id,
          'price': priceController.text,
          'description': descriptionController.text,
          'model_id': isSelectedCustomBrand ? selectedModelIdLit : [generalID],
          'category_id': selectedCategory,
          'sub_category_id': selectedSubCategory,
          'quantity': stockCountController.text,
        };
      }
      Response response = await shoppeRepo.addProduct(productDetails: product);
      isLoading = false;
      update();
      if (response.statusCode == 200 || response.statusCode == 201) {
        createdProductId = response.body['resultData']['_id'];
        return true;
      } else {
        showCustomSnackBar('Something went wrong!', isError: true);
        return false;
      }
    } else {
      isLoading = false;
      update();
    }
  }

  Future<bool> updateProduct(String id) async {
    isLoading = true;
    isError = false;
    update();
    var selectedModelIdLit = [];
    productCategoriesModel.models.forEach((element) {
      if (element.isSelected) {
        selectedModelIdLit.add(element.id);
      }
    });
    if ((nameController.text == "" || nameController.text == null)) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Name of Product", isError: true);
    }
    if (priceController.text == "" || priceController.text == null) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Price", isError: true);
    }
    if (discountController.text != "" || discountController.text != null) {
      if (double.parse(discountController.text) >
          double.parse(priceController.text)) {
        isError = true;
        update();
        showCustomSnackBar("Offer price should be less than Price",
            isError: true);
      }
    }
    if (descriptionController.text == "" ||
        descriptionController.text == null) {
      isError = true;
      update();
      showCustomSnackBar("Please Enter Description", isError: true);
    }
    if (stockCountController.text == "" ||
        stockCountController.text == null ||
        stockCountController.text == "0") {
      isError = true;
      update();
      showCustomSnackBar("Please add Stock", isError: true);
    }
    if (isSelectedCustomBrand == true) {
      if (selectedModelIdLit == null || selectedModelIdLit.length == 0) {
        isError = true;
        update();
        showCustomSnackBar("You should choose atleast one car model",
            isError: true);
      }
    }
    if (selectedCategory == null || selectedCategory == "") {
      isError = true;
      update();
      showCustomSnackBar("You need to choose a Category", isError: true);
    }
    if (selectedSubCategory == null || selectedSubCategory == "") {
      isError = true;
      update();
      showCustomSnackBar("You need to choose a Sub-Category", isError: true);
    }
    if (!isError) {
      var product;
      if (discountController.text != null && discountController.text != "") {
        product = {
          'name': nameController.text,
          'user_id': Get.find<AuthController>().userModel.id,
          'price': priceController.text,
          'description': descriptionController.text,
          'model_id': isSelectedCustomBrand ? selectedModelIdLit : [generalID],
          'category_id': selectedCategory,
          'sub_category_id': selectedSubCategory,
          'quantity': stockCountController.text,
          'offerPrice': discountController.text,
        };
      } else {
        product = {
          'name': nameController.text,
          'user_id': Get.find<AuthController>().userModel.id,
          'price': priceController.text,
          'description': descriptionController.text,
          'model_id': isSelectedCustomBrand ? selectedModelIdLit : [generalID],
          'category_id': selectedCategory,
          'sub_category_id': selectedSubCategory,
          'quantity': stockCountController.text,
        };
      }
      Response response =
          await shoppeRepo.updateProduct(productDetails: product, id: id);
      isLoading = false;
      update();
      if (response.statusCode == 200 || response.statusCode == 201) {
        createdProductId = id;
        Get.find<ShoppeController>()
            .setProduct(ProductDetails.fromJson(response.body['resultData']));
        return true;
      } else {
        showCustomSnackBar('Something went wrong!', isError: true);
        return false;
      }
    } else {
      isLoading = false;
      update();
      return false;
    }
  }

  imageUploader() async {
    List<MultipartBody> newList = [];
    for (File img in pickedImageList) {
      if (img != "") {
        var multipartFile = await MultipartBody('upload', img);
        newList.add(multipartFile);
      }
    }
    Map<String, String> body = {'id': createdProductId};
    Response response =
        await shoppeRepo.uploadProductImageUpload(body: body, images: newList);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar("Images Uploaded", isError: false);
    }
  }

  Future updateStock({@required String id}) async {
    Response response =
        await shoppeRepo.updateQuantity(id: id, count: stockCount);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
