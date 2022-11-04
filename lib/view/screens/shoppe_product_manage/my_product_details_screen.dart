import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/widget/product_brand_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MyProductDetailsScreen extends StatelessWidget {
  MyProductDetailsScreen({Key key}) : super(key: key);
  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Details'),
      body: GetBuilder<ShoppeController>(builder: (shoppeController) {
        return Column(children: [
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              shoppeController.selectedProduct.imageUrl != null &&
                      shoppeController.selectedProduct.imageUrl.length > 0
                  ? CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        height: 260,
                        disableCenter: true,
                        autoPlayInterval: Duration(seconds: 6),
                      ),
                      items: shoppeController.selectedProduct.imageUrl
                          .map((item) => Container(
                                child: CustomImage(
                                  image: item,
                                  fit: BoxFit.fitWidth,
                                ),
                              ))
                          .toList(),
                    )
                  : CustomImage(
                      image: "",
                      height: 260,
                      width: Get.width,
                    ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shoppeController.selectedProduct.name,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                'Status',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoRegular.copyWith(
                                    color: shoppeController
                                                .selectedProduct.status ==
                                            1
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                              Icon(
                                Icons.radio_button_checked,
                                size: 16,
                                color:
                                    shoppeController.selectedProduct.status == 1
                                        ? Colors.green
                                        : Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${'price'.tr} : ' +
                                    PriceConverter.convertPrice(double.parse(
                                        '${shoppeController.selectedProduct.price}')),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoRegular,
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              Row(children: [
                                Icon(Icons.star,
                                    color: Theme.of(context).primaryColor,
                                    size: 20),
                                Text(
                                    shoppeController
                                        .selectedProduct.ratings.average
                                        .toStringAsFixed(1),
                                    style: robotoRegular),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Text(
                                  '${shoppeController.selectedProduct.ratings != null ? (shoppeController.selectedProduct.ratings.oneStar.count + shoppeController.selectedProduct.ratings.twoStar.count + shoppeController.selectedProduct.ratings.threeStar.count + shoppeController.selectedProduct.ratings.fourStar.count + shoppeController.selectedProduct.ratings.fiveStar.count) : 0.0} ${'ratings'.tr}',
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ]),
                            ],
                          ),
                          SizedBox(
                            width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${'Offer Price'} : ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: robotoRegular,
                                  ),
                                  Text(
                                    PriceConverter.convertPrice(double.parse(
                                        ' ${shoppeController.selectedProduct.offerPrice}')),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: robotoBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                  ),
                                ],
                              ),
                              Text(
                                'discount : ' +
                                    double.parse((PriceConverter
                                                .percentageCalculationWithDiscountAmount(
                                                    double.parse(
                                                        shoppeController
                                                            .selectedProduct
                                                            .price
                                                            .toString()),
                                                    double.parse(
                                                        shoppeController
                                                            .selectedProduct
                                                            .offerPrice
                                                            .toString())))
                                            .toString())
                                        .ceilToDouble()
                                        .toString() +
                                    '%',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    robotoRegular.copyWith(color: Colors.green),
                              )
                            ],
                          ),
                        ],
                      ),
                    ])),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Text('Category', style: robotoMedium),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Text(
                        shoppeController.selectedProduct.categoryId.name,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      ),
                    ]),
                    Column(children: [
                      Text('Sub Category', style: robotoMedium),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Text(
                        shoppeController.selectedProduct.subCategoryId.name,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Container(
                padding: EdgeInsets.all(8),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions
                      .RADIUS_SMALL), // border: Border.all(color: Theme.of(context).disabledColor),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selected Brands and Models',
                              style: robotoMedium,
                            ),
                            // shoppeController.selectedProduct.modelId
                            shoppeController.getAllMakeAndModelCount()[
                                        'modelCount'] !=
                                    0
                                ? shoppeController
                                            .selectedProduct.modelId[0].name ==
                                        "GENERAL"
                                    ? Container(
                                        child: Text(
                                          "General",
                                          style: robotoBold,
                                        ),
                                      )
                                    : Container(
                                        height: 20,
                                        width: 60,
                                        child: CustomButton(
                                          buttonText: "View All",
                                          height: 20,
                                          width: 60,
                                          fontSize: 12,
                                          onPressed: () {
                                            shoppeController.getMakeList();
                                            Get.bottomSheet(ProductBrandSheet(),
                                                backgroundColor:
                                                    Theme.of(context).cardColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    25.0))),
                                                isScrollControlled: true);
                                          },
                                        ),
                                      )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      shoppeController
                                  .getAllMakeAndModelCount()['modelCount'] !=
                              0
                          ? shoppeController.selectedProduct.modelId[0].name ==
                                  "GENERAL"
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "No of Brands choosed : ",
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        Text(
                                          shoppeController
                                              .getAllMakeAndModelCount()[
                                                  'makeCount']
                                              .toString(),
                                          style: robotoRegular,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "No of Models choosed : ",
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        SizedBox(
                                          width:
                                              Dimensions.PADDING_SIZE_DEFAULT,
                                        ),
                                        Text(
                                          shoppeController
                                              .getAllMakeAndModelCount()[
                                                  'modelCount']
                                              .toString(),
                                          style: robotoRegular,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "This product is applicable for all Brands & Models",
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).disabledColor),
                              ),
                            ),
                    ]),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              GetBuilder<CreateProductController>(
                  builder: (createProductController) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey[Get.isDarkMode ? 800 : 200],
                        //       spreadRadius: 1,
                        //       blurRadius: 5,
                        //       offset: Offset(0, 5))
                        // ],
                      ),
                      child: Row(
                          mainAxisAlignment: shoppeController.isUpdatingStock
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.start,
                          children: [
                            Text("Stock available : "),
                            SizedBox(
                              width: !shoppeController.isUpdatingStock
                                  ? Dimensions.PADDING_SIZE_SMALL
                                  : 0,
                            ),
                            shoppeController.isUpdatingStock
                                ? Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_LARGE),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                _createIncrementDicrementButton(
                                                    context, Icons.remove, () {
                                                  createProductController
                                                      .setQuantity(
                                                          isIncrement: false);
                                                }),
                                                Container(
                                                  width: 50,
                                                  // decoration: BoxDecoration(
                                                  //   border: Border.all(
                                                  //       color: Theme.of(context)
                                                  //           .primaryColor),
                                                  // ),
                                                  child: TextField(
                                                    style:
                                                        robotoRegular.copyWith(
                                                            color:
                                                                Colors.black),
                                                    textAlign: TextAlign.center,
                                                    controller:
                                                        createProductController
                                                            .stockCountController,
                                                    onChanged: (value) {
                                                      createProductController
                                                          .setQuantity(
                                                              isInitial: true,
                                                              count: int.parse(
                                                                  value));
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: "0",
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .RADIUS_SMALL),
                                                          borderSide:
                                                              BorderSide.none),
                                                    ),
                                                  ),
                                                ),
                                                _createIncrementDicrementButton(
                                                    context, Icons.add, () {
                                                  createProductController
                                                      .setQuantity(
                                                          isIncrement: true);
                                                }),
                                              ]),
                                        ),
                                        CustomButton(
                                          buttonText: "Apply",
                                          fontSize: 14,
                                          width: 60,
                                          height: 25,
                                          onPressed: () {
                                            createProductController
                                                .updateStock(
                                                    id: shoppeController
                                                        .selectedProduct.id)
                                                .then((value) {
                                              if (value) {
                                                shoppeController
                                                    .getMyProducts('1');
                                                shoppeController
                                                    .setStockUpdatingStatus(
                                                        createProductController
                                                            .stockCount);
                                                showCustomSnackBar(
                                                    "Stock Updated",
                                                    isError: false);
                                              } else {
                                                showCustomSnackBar(
                                                    "Something went wrong, Please try again!");
                                              }
                                            });
                                          },
                                        ),
                                        CustomButton(
                                          buttonText: "Cancel",
                                          width: 60,
                                          height: 25,
                                          backgroundColor: Colors.black,
                                          onPressed: () =>
                                              shoppeController.setStockEdit(),
                                        )
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(shoppeController
                                              .selectedProduct.quantity
                                              .toString()),
                                        ),
                                        CustomButton(
                                          buttonText: "Update Stock",
                                          fontSize: 14,
                                          width: 120,
                                          height: 25,
                                          onPressed: () {
                                            Get.find<CreateProductController>()
                                                .setQuantity(
                                                    count: shoppeController
                                                        .selectedProduct
                                                        .quantity,
                                                    isInitial: true);
                                            shoppeController
                                                .setStockUpdatingStatus(
                                                    shoppeController
                                                        .selectedProduct
                                                        .quantity);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ]),
                    ),
                  ],
                );
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              (shoppeController.selectedProduct.description != null &&
                      shoppeController.selectedProduct.description.isNotEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('description'.tr, style: robotoMedium),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(shoppeController.selectedProduct.description,
                            style: robotoRegular),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      ],
                    )
                  : SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('reviews'.tr, style: robotoMedium),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  // shoppeController.productReviewList != null
                  //     ? shoppeController.productReviewList.length > 0
                  //         ? ListView.builder(
                  //             itemCount:
                  //                 shoppeController.productReviewList.length,
                  //             physics: NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemBuilder: (context, index) {
                  //               return ReviewWidget(
                  //                 review:
                  //                     shoppeController.productReviewList[index],
                  //                 fromRestaurant: false,
                  //                 hasDivider: index !=
                  //                     shoppeController
                  //                             .productReviewList.length -
                  //                         1,
                  //               );
                  //             },
                  //           )
                  // :
                  Padding(
                    padding:
                        EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                    child: Center(
                        child: Text('No review available',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor))),
                  )
                  // : Padding(
                  //     padding: EdgeInsets.only(
                  //         top: Dimensions.PADDING_SIZE_LARGE),
                  //     child: Center(child: CircularProgressIndicator()),
                  //   ),
                ],
              )
            ]),
          )),
          GetBuilder<CreateProductController>(
              builder: (createProductController) {
            return createProductController.isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    onPressed: () {
                      createProductController
                          .getAllCategoryDetails()
                          .then((value) {
                        createProductController.setForEditProduct(
                            shoppeController.selectedProduct);
                        Get.toNamed(RouteHelper.editProduct);
                      });
                    },
                    buttonText: 'Update',
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  );
          }),
        ]);
      }),
    );
  }

  Widget _createIncrementDicrementButton(
      BuildContext context, IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Theme.of(context).primaryColor,
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyMedium.color,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
