import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/loading_screen.dart';
import 'package:carclenx_vendor_app/view/base/my_text_field.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/widget/select_brand_sheet.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/widget/upload_image_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({this.isEdit = false});
  bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: isEdit ? "Edit Product" : "Add New Product"),
      body: GetBuilder<CreateProductController>(
          builder: (createProductController) {
        return createProductController.isLoading
            ? LoadingScreen()
            : Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            MyTextField(
                                hintText: 'Product Name',
                                controller:
                                    createProductController.nameController,
                                focusNode: createProductController.nameNode,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                nextFocus: createProductController.priceNode),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            MyTextField(
                                hintText: 'Original Price/MRP',
                                controller:
                                    createProductController.priceController,
                                focusNode: createProductController.priceNode,
                                isAmount: true,
                                amountIcon: true,
                                capitalization: TextCapitalization.words,
                                inputAction: TextInputAction.next,
                                nextFocus:
                                    createProductController.discountNode),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            MyTextField(
                              hintText: 'Offer Price',
                              controller:
                                  createProductController.discountController,
                              focusNode: createProductController.discountNode,
                              amountIcon: true,
                              isAmount: true,
                              capitalization: TextCapitalization.words,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Choose Brands & Models",
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Container(
                                  width: Get.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .grey[Get.isDarkMode ? 800 : 200],
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 5))
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "General",
                                              style: !createProductController
                                                      .isSelectedCustomBrand
                                                  ? robotoBold
                                                  : robotoRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor),
                                            ),
                                            Transform.scale(
                                              scale: 0.6,
                                              child: CupertinoSwitch(
                                                value: createProductController
                                                    .isSelectedCustomBrand,
                                                onChanged: ((value) {
                                                  createProductController
                                                      .updateMakeGeneralStatus();
                                                  if (createProductController
                                                      .isSelectedCustomBrand) {
                                                    Get.bottomSheet(
                                                        SelectBrandSheet(),
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .cardColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            25.0))),
                                                        isScrollControlled:
                                                            true);
                                                  }
                                                }),
                                              ),
                                            ),
                                            Text(
                                              "Selected Brands & Models",
                                              style: createProductController
                                                      .isSelectedCustomBrand
                                                  ? robotoBold
                                                  : robotoRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor),
                                            ),
                                          ],
                                        ),
                                        createProductController
                                                .isSelectedCustomBrand
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "No of Brands choosed : ",
                                                            style: robotoRegular.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor),
                                                          ),
                                                          Text(
                                                            createProductController
                                                                .getAllMakeAndModelCount()[
                                                                    'makeCount']
                                                                .toString(),
                                                            style:
                                                                robotoRegular,
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "No of Models choosed : ",
                                                            style: robotoRegular.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor),
                                                          ),
                                                          Text(
                                                            createProductController
                                                                .getAllMakeAndModelCount()[
                                                                    'modelCount']
                                                                .toString(),
                                                            style:
                                                                robotoRegular,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      width: Get.width * 0.35,
                                                      height: 30,
                                                      child: CustomButton(
                                                        buttonText: "Choose",
                                                        icon: Icons.local_taxi,
                                                        onPressed: () {
                                                          Get.bottomSheet(
                                                              SelectBrandSheet(),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .cardColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              25.0))),
                                                              isScrollControlled:
                                                                  true);
                                                        },
                                                      )),
                                                ],
                                              )
                                            : SizedBox(),
                                      ]),
                                ),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Category",
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Container(
                                          width: Get.width * 0.4,
                                          padding: EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Get.isDarkMode
                                                          ? 800
                                                          : 200],
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5))
                                            ],
                                          ),
                                          child: Center(
                                            child: DropdownButton(
                                              isExpanded: true,
                                              dropdownColor:
                                                  Theme.of(context).cardColor,
                                              value: createProductController
                                                  .selectedCategory,
                                              style: robotoBlack.copyWith(
                                                  color: createProductController
                                                              .selectedCategory ==
                                                          "choose"
                                                      ? Theme.of(context)
                                                          .disabledColor
                                                      : Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyMedium
                                                          .color),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Color(0xFF9E9E9E)),
                                              underline: SizedBox(),
                                              onChanged: (dynamic newValue) {
                                                createProductController
                                                    .setCategory(
                                                        newValue, true);
                                                createProductController
                                                    .setSubCategoryList(
                                                        newValue);
                                              },
                                              items: createProductController
                                                  .productCategoriesModel
                                                  .categories
                                                  .map((category) {
                                                return DropdownMenuItem(
                                                  alignment: Alignment.center,
                                                  child: Text(category.name,
                                                      style: robotoRegular.copyWith(
                                                          color: category.id ==
                                                                  "choose"
                                                              ? Theme.of(
                                                                      context)
                                                                  .disabledColor
                                                              : Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .bodyMedium
                                                                  .color)),
                                                  value: category.id,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sub-Category",
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Container(
                                          width: Get.width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Get.isDarkMode
                                                          ? 800
                                                          : 200],
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5))
                                            ],
                                          ),
                                          child: Center(
                                            child: DropdownButton(
                                              isExpanded: true,
                                              dropdownColor:
                                                  Theme.of(context).cardColor,
                                              style: robotoBlack.copyWith(
                                                  color: createProductController
                                                              .selectedCategory ==
                                                          "choose"
                                                      ? Theme.of(context)
                                                          .disabledColor
                                                      : Theme.of(context)
                                                          .primaryTextTheme
                                                          .bodyMedium
                                                          .color),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Color(0xFF9E9E9E)),
                                              underline: SizedBox(),
                                              value: createProductController
                                                  .selectedSubCategory,
                                              onChanged: (dynamic newValue) {
                                                createProductController
                                                    .setCategory(
                                                        newValue, false);
                                              },
                                              items: createProductController
                                                  .selectedSubCategoryList
                                                  .map((category) {
                                                return DropdownMenuItem(
                                                  alignment: Alignment.center,
                                                  child: Text(category.name,
                                                      style: robotoRegular.copyWith(
                                                          color: category.id ==
                                                                  "choose"
                                                              ? Theme.of(
                                                                      context)
                                                                  .disabledColor
                                                              : Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .bodyMedium
                                                                  .color)),
                                                  value: category.id,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quantity",
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    Container(
                                      width: Get.width,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[
                                                  Get.isDarkMode ? 800 : 200],
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 5))
                                        ],
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Stock available : "),
                                            Container(
                                              padding: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_LARGE),
                                                color:
                                                    Theme.of(context).cardColor,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    _createIncrementDicrementButton(
                                                        context, Icons.remove,
                                                        () {
                                                      createProductController
                                                          .setQuantity(
                                                              isIncrement:
                                                                  false);
                                                    }),
                                                    Container(
                                                      width: 50,
                                                      // decoration: BoxDecoration(
                                                      //   border: Border.all(
                                                      //       color: Theme.of(context)
                                                      //           .primaryColor),
                                                      // ),
                                                      child: TextField(
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            createProductController
                                                                .stockCountController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "0",
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .RADIUS_SMALL),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                        ),
                                                      ),
                                                    ),
                                                    _createIncrementDicrementButton(
                                                        context, Icons.add, () {
                                                      createProductController
                                                          .setQuantity(
                                                              isIncrement:
                                                                  true);
                                                    }),
                                                  ]),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                MyTextField(
                                    hintText: 'Description',
                                    maxLines: 5,
                                    controller: createProductController
                                        .descriptionController,
                                    focusNode:
                                        createProductController.descriptionNode,
                                    capitalization: TextCapitalization.words,
                                    inputAction: TextInputAction.done,
                                    nextFocus:
                                        createProductController.priceNode),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL,
                                ),
                              ],
                            )
                          ],
                        ),
                        CustomButton(
                          buttonText: "Next",
                          onPressed: () {
                            if (isEdit) {
                              createProductController
                                  .updateProduct(Get.find<ShoppeController>()
                                      .selectedProduct
                                      .id)
                                  .then((value) {
                                if (value != null && value == true) {
                                  Get.bottomSheet(
                                      Container(child: UploadImageSheet()),
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0))),
                                      isScrollControlled: true);
                                }
                              });
                            } else {
                              createProductController
                                  .createProduct()
                                  .then((value) {
                                if (value != null && value == true) {
                                  Get.bottomSheet(
                                      Container(child: UploadImageSheet()),
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0))),
                                      isScrollControlled: true);
                                }
                              });
                            }
                          },
                        )
                      ]),
                ),
              );
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
