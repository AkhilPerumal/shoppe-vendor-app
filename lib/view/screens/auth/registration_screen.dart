import 'dart:io';
import 'dart:math';

import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/data/model/body/sign_up_body_model.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/base/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key key, this.fromSignIn = true}) : super(key: key);
  bool fromSignIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: fromSignIn ? "Sign up" : "Edit Application"),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  MyTextField(
                      hintText: 'Name',
                      controller: authController.nameController,
                      focusNode: authController.nameFocusNode,
                      capitalization: TextCapitalization.words,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.emailFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  MyTextField(
                      hintText: 'Email',
                      controller: authController.emailController,
                      focusNode: authController.emailFocusNode,
                      inputType: TextInputType.emailAddress,
                      capitalization: TextCapitalization.words,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.phoneFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  MyTextField(
                      hintText: 'Phone',
                      controller: authController.phoneController,
                      focusNode: authController.phoneFocusNode,
                      maxLines: 1,
                      isEnabled: fromSignIn,
                      fillColor:
                          fromSignIn ? null : Colors.black.withOpacity(0.1),
                      inputType: TextInputType.phone,
                      capitalization: TextCapitalization.words,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.workinLocationFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  MyTextField(
                      hintText: 'Prefered Working Location',
                      controller: authController.workinglocationController,
                      focusNode: authController.workinLocationFocusNode,
                      capitalization: TextCapitalization.words,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.stateFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  MyTextField(
                      hintText: 'District',
                      controller: authController.districtController,
                      focusNode: authController.districtFocusNode,
                      capitalization: TextCapitalization.words,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.stateFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  MyTextField(
                      hintText: 'State',
                      controller: authController.stateController,
                      focusNode: authController.stateFocusNode,
                      capitalization: TextCapitalization.words,
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                      nextFocus: authController.userNameFocusNode),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: MyTextField(
                            hintText: 'User Name',
                            isEnabled: fromSignIn,
                            isError: authController.isUserNameAvailable == 1
                                ? false
                                : authController.isUserNameAvailable == -1
                                    ? false
                                    : true,
                            controller: authController.userNameController,
                            fillColor: fromSignIn
                                ? null
                                : Colors.black.withOpacity(0.1),
                            focusNode: authController.userNameFocusNode,
                            capitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            onChanged: (value) {
                              authController.setUserNameAvailableStatus(-1);
                            },
                            nextFocus: authController.passwordFocusNode),
                      ),
                      SizedBox(
                        width:
                            fromSignIn ? Dimensions.FONT_SIZE_EXTRA_SMALL : 0,
                      ),
                      fromSignIn
                          ? Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: authController.isUserNameAvailable == 1
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.check_box,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "Available",
                                            style: robotoRegular.copyWith(
                                                color: Colors.green),
                                          )
                                        ],
                                      )
                                    : CustomButton(
                                        margin: EdgeInsets.only(top: 8.0),
                                        // width: Get.width * 0.2,
                                        height: 30,
                                        buttonText: 'Check',
                                        onPressed: () {
                                          authController.verifyUserName();
                                        },
                                      ),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  fromSignIn
                      ? Column(
                          children: [
                            MyTextField(
                                hintText: 'Password',
                                controller: authController.passwordController,
                                focusNode: authController.passwordFocusNode,
                                capitalization: TextCapitalization.words,
                                inputType: TextInputType.visiblePassword,
                                inputAction: TextInputAction.next,
                                isPassword: true,
                                nextFocus:
                                    authController.confirmPasswordFocusNode),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            MyTextField(
                                hintText: 'Confirm Password',
                                controller:
                                    authController.confirmPasswordController,
                                focusNode:
                                    authController.confirmPasswordFocusNode,
                                capitalization: TextCapitalization.words,
                                isPassword: true,
                                inputAction: TextInputAction.next,
                                nextFocus: authController.experienceFocusNode),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                          ],
                        )
                      : SizedBox(),
                  MyTextField(
                    hintText: 'Years of Experience',
                    controller: authController.experienceController,
                    focusNode: authController.experienceFocusNode,
                    capitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Experience in : ',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      )),
                  Row(children: [
                    Expanded(
                        child: CheckboxListTile(
                      title: Text(
                        'Spare Parts & Accessory shoppe',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      value: authController.isCheckedShoppe,
                      contentPadding: EdgeInsets.zero,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) =>
                          authController.setshoppeStatus(status: value),
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: CheckboxListTile(
                      title: Text(
                        'Car Wash',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      value: authController.isCheckedCarWash,
                      contentPadding: EdgeInsets.zero,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) =>
                          authController.setCarWashStatus(status: value),
                    )),
                  ]),
                  Row(
                    children: [
                      Expanded(
                          child: CheckboxListTile(
                        title: Text(
                          'Mechanical',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL),
                        ),
                        value: authController.isCheckedMechanic,
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColor,
                        dense: false,
                        onChanged: (bool value) =>
                            authController.setMechanicStatus(status: value),
                      )),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                          child: CheckboxListTile(
                        title: Text(
                          'Road Side Assistance',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL),
                        ),
                        value: authController.isCheckedQuickHelp,
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColor,
                        dense: false,
                        onChanged: (bool value) =>
                            authController.setQuickHelphStatus(status: value),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Availability',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).disabledColor),
                      )),
                  Row(children: [
                    Expanded(
                        child: RadioListTile<String>(
                      title: Text(
                        'Any Time',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      groupValue:
                          authController.isShiftTime ? 'shift_based' : 'any',
                      value: 'any',
                      contentPadding: EdgeInsets.zero,
                      onChanged: (String value) =>
                          authController.setShiftAvailability(
                              isShiftTime: value == 'shift_based'),
                      activeColor: Theme.of(context).primaryColor,
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: RadioListTile<String>(
                      title: Text(
                        'Shift Time',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      groupValue:
                          authController.isShiftTime ? 'shift_based' : 'any',
                      value: 'shift_based',
                      contentPadding: EdgeInsets.zero,
                      onChanged: (String value) =>
                          authController.setShiftAvailability(
                              isShiftTime: value == 'shiftTime'),
                      activeColor: Theme.of(context).primaryColor,
                      dense: false,
                    )),
                  ]),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Attach verification ID Document',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context).disabledColor),
                          ),
                          !fromSignIn
                              ? CustomButton(
                                  buttonText: "Re-Upload",
                                  width: Get.width * 0.25,
                                  height: 28,
                                  backgroundColor: Colors.black,
                                  icon: Icons.document_scanner_rounded,
                                  fontSize: 12,
                                  onPressed: () {
                                    if (authController.pickedImageList.length >=
                                            0 &&
                                        authController.pickedImageList.length <
                                            3) {
                                      authController.pickRegImage(
                                          singleImage: false);
                                    } else {
                                      showCustomSnackBar(
                                          'Maximum image you can select is 2');
                                    }
                                  },
                                )
                              : SizedBox(),
                        ],
                      ),
                      Container(
                        height: !fromSignIn &&
                                authController.userModel.partnerApplicationId
                                        .imageUrl.length >
                                    0
                            ? 150
                            : 20,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: fromSignIn
                                    ? authController.pickedImageList.length > 0
                                        ? authController
                                                    .pickedImageList.length >
                                                2
                                            ? 2
                                            : authController
                                                    .pickedImageList.length +
                                                1
                                        : 1
                                    : authController
                                                .userModel
                                                .partnerApplicationId
                                                .imageUrl
                                                .length >
                                            0
                                        ? authController
                                                    .userModel
                                                    .partnerApplicationId
                                                    .imageUrl
                                                    .length >
                                                2
                                            ? 2
                                            : authController
                                                .userModel
                                                .partnerApplicationId
                                                .imageUrl
                                                .length
                                        : 0,
                                itemBuilder: ((context, index) {
                                  if (fromSignIn) {
                                    if (index == 0) {
                                      return imagePickerButton(
                                          authController, context);
                                    } else {
                                      return imageHolder(
                                          authController, context, index - 1);
                                    }
                                  } else {
                                    if (authController.pickedImageList.length >
                                        0) {
                                      return imageHolder(
                                          authController, context, index);
                                    } else {
                                      return applicationImage(
                                          authController, context, index);
                                    }
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    buttonText: fromSignIn ? "Sign Up" : "Update",
                    width: Get.width * 0.8,
                    height: 45,
                    onPressed: () {
                      authController.signUp(fromSignIn);
                    },
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }

  Widget imageHolder(
      AuthController authController, BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: Image.file(
              File(authController.pickedImageList[index].path),
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () => authController.removeImage(index),
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
      AuthController authController, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: authController.pickedRegImage != null
                ? Image.file(
                    File(authController.pickedRegImage.path),
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
                if (authController.pickedImageList.length >= 0 &&
                    authController.pickedImageList.length < 3) {
                  authController.pickRegImage(singleImage: false);
                } else {
                  showCustomSnackBar('Maximum image you can select is 2');
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
                  child:
                      Icon(Icons.document_scanner_rounded, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget applicationImage(
      AuthController authController, BuildContext context, int index) {
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
          image: authController.userModel.partnerApplicationId.imageUrl[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
