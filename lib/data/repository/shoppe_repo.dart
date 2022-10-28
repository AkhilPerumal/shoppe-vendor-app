import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:get/get.dart';

class ShoppeRepo extends GetxService {
  final ApiClient apiClient;
  ShoppeRepo({this.apiClient});

  Future<Response> addProduct({Map<String, dynamic> productDetails}) {
    return apiClient.postData(
      uri: AppConstants.CREATE_PRODUCT,
      body: productDetails,
    );
  }

  Future<Response> updateProduct(
      {Map<String, dynamic> productDetails, String id}) {
    return apiClient.putData(
      uri: AppConstants.UPDATE_PRODUCT + id,
      body: productDetails,
    );
  }

  Future<Response> uploadProductImageUpload(
      {Map<String, String> body, List<MultipartBody> images}) {
    return apiClient.postMultipartData(
        uri: AppConstants.UPLOAD_PRODUCT_IMAGE,
        body: body,
        multipartBody: images);
  }

  Future<Response> getAllCategoryDetails() {
    return apiClient.getData(uri: AppConstants.ALL_CATEGORY_LIST);
  }

  Future<Response> getMyProductList(String page) {
    return apiClient.getData(uri: AppConstants.MY_PRODUCT_LIST + page);
  }

  Future<Response> getSingleProduct(String id) {
    return apiClient.getData(uri: AppConstants.SINGLE_PRODUCT + id);
  }

  Future<Response> updateQuantity({int count, String id}) {
    return apiClient
        .putData(uri: AppConstants.UPDATE_PRODUCT_QUANTITY + id, body: {
      "quantity": count,
    });
  }
}
