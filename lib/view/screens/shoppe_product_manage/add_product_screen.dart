import 'dart:io';

import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
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
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Attach product images',
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        CustomButton(
                                          buttonText: "Re-Upload",
                                          width: Get.width * 0.25,
                                          height: 28,
                                          backgroundColor: Colors.black,
                                          icon: Icons.camera_enhance_outlined,
                                          fontSize: 12,
                                          onPressed: () {
                                            if (createProductController
                                                        .pickedImageList
                                                        .length >=
                                                    0 &&
                                                createProductController
                                                        .pickedImageList
                                                        .length <
                                                    6) {
                                              createProductController.pickImage(
                                                  singleImage: false);
                                            } else {
                                              showCustomSnackBar(
                                                  'Maximum image you can select is 2');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: ((createProductController
                                                          .editingProduct !=
                                                      null &&
                                                  createProductController
                                                          .editingProduct
                                                          .imageUrl !=
                                                      null &&
                                                  createProductController
                                                          .editingProduct
                                                          .imageUrl
                                                          .length >
                                                      0) ||
                                              createProductController
                                                      .pickedImageList.length >
                                                  0)
                                          ? 150
                                          : 60,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child:
                                                ((createProductController
                                                                    .editingProduct !=
                                                                null &&
                                                            createProductController
                                                                    .editingProduct
                                                                    .imageUrl !=
                                                                null &&
                                                            createProductController
                                                                    .editingProduct
                                                                    .imageUrl
                                                                    .length >
                                                                0) ||
                                                        createProductController
                                                                .pickedImageList
                                                                .length >
                                                            0)
                                                    ? ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: createProductController
                                                                    .pickedImageList
                                                                    .length >
                                                                0
                                                            ? createProductController
                                                                .pickedImageList
                                                                .length
                                                            : createProductController
                                                                .editingProduct
                                                                .imageUrl
                                                                .length,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          if (createProductController
                                                                  .pickedImageList
                                                                  .length >
                                                              0) {
                                                            return imageHolder(
                                                                createProductController,
                                                                context,
                                                                index);
                                                          } else {
                                                            return applicationImage(
                                                                createProductController,
                                                                context,
                                                                index);
                                                          }
                                                        }),
                                                      )
                                                    : Container(
                                                        child: Text(
                                                          "Add image",
                                                          style: robotoRegular.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      buttonText: isEdit ? "Update" : "Create",
                      onPressed: () {
                        if (isEdit) {
                          createProductController
                              .updateProduct(Get.find<ShoppeController>()
                                  .selectedProduct
                                  .id)
                              .then((value) {
                            if (value != null && value == true) {
                              if (createProductController
                                          .pickedImageList.length >
                                      0 &&
                                  createProductController
                                          .pickedImageList.length <
                                      6) {
                                createProductController
                                    .imageUploader()
                                    .then((value) {
                                  Get.find<ShoppeController>()
                                      .getMyProducts('1');
                                  Get.until(
                                    (route) =>
                                        Get.currentRoute == RouteHelper.initial,
                                  );
                                });
                              } else {
                                Get.find<ShoppeController>().getMyProducts('1');
                                Get.until(
                                  (route) =>
                                      Get.currentRoute == RouteHelper.initial,
                                );
                              }

                              // Get.bottomSheet(
                              //     Container(child: UploadImageSheet()),
                              //     backgroundColor: Theme.of(context).cardColor,
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.vertical(
                              //             top: Radius.circular(25.0))),
                              //     isScrollControlled: true);
                            }
                          });
                        } else {
                          createProductController.createProduct().then((value) {
                            if (value != null && value == true) {
                              if (createProductController
                                          .pickedImageList.length >
                                      0 &&
                                  createProductController
                                          .pickedImageList.length <
                                      6) {
                                createProductController
                                    .imageUploader()
                                    .then((value) {
                                  if (value) {
                                    Get.find<ShoppeController>()
                                        .getMyProducts('1');
                                    Get.back();
                                  }
                                });
                              } else {
                                Get.find<ShoppeController>().getMyProducts('1');
                                Get.until(
                                  (route) =>
                                      Get.currentRoute == RouteHelper.initial,
                                );
                              }
                            }
                          });
                        }
                      },
                    )
                  ],
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

  Widget imageHolder(CreateProductController createProductController,
      BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: Image.file(
              File(createProductController.pickedImageList[index].path),
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () => createProductController.removeImage(index),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT)),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget imagePickerButton(
      CreateProductController createProductController, BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: createProductController.pickedImage != null
                ? Image.file(
                    File(createProductController.pickedImage.path),
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: Images.placeholder,
                    height: 120,
                    width: 150,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder,
                        height: 120,
                        width: 150,
                        fit: BoxFit.cover),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                if (createProductController.pickedImageList.length >= 0 &&
                    createProductController.pickedImageList.length < 6) {
                  createProductController.pickImage(singleImage: false);
                } else {
                  showCustomSnackBar('Maximum image you can select is 5');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget applicationImage(CreateProductController createProductController,
      BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 120,
        width: 150,
        decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        ),
        child: CustomImage(
          image: createProductController.editingProduct.imageUrl[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
