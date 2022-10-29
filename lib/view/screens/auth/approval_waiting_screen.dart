import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalWaitingScreen extends StatelessWidget {
  const ApprovalWaitingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waiting for Approval",
            style: robotoRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Theme.of(context).textTheme.bodyText1.color)),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          Get.find<AuthController>().userModel.partnerApplicationId.status ==
                  "Unapproved"
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: TextButton(
                        onPressed: () {
                          Get.find<AuthController>().setForEditApplication();
                          Get.toNamed(RouteHelper.signUp,
                              arguments: {"fromSignIn": false});
                        },
                        child: Text(
                          "EDIT",
                          style: robotoBold,
                        )),
                  ),
                )
              : SizedBox(),
        ],
        elevation: 0,
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status',
                            style: robotoRegular,
                          ),
                          // Text(
                          //   ':',
                          //   style: robotoRegular,
                          // ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Text(
                              authController.userModel.status != null
                                  ? authController.userModel.status ==
                                          "Unapproved"
                                      ? 'Verifying'.toUpperCase()
                                      : authController.userModel.status
                                          .toUpperCase()
                                  : 'Verifying'.toUpperCase(),
                              style: robotoMedium.copyWith(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController
                                        .userModel.partnerApplicationId.name,
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'User Name : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController.userModel
                                        .partnerApplicationId.username,
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController
                                        .userModel.partnerApplicationId.email,
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Phone : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController.userModel
                                                .partnerApplicationId.phone !=
                                            null
                                        ? authController.userModel
                                            .partnerApplicationId.phone
                                        : "",
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prefered Location : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController
                                        .userModel.partnerApplicationId.place,
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'District & State : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: Get.width * 0.5,
                                    child: Text(
                                      authController.userModel
                                              .partnerApplicationId.district +
                                          ', ' +
                                          authController.userModel
                                              .partnerApplicationId.state,
                                      style: robotoMedium,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Years of Experience : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController.userModel
                                        .partnerApplicationId.experience.total
                                        .toString(),
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Experienced Services : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: Get.width * 0.4,
                                    child: Text(
                                      (authController.userModel.partnerApplicationId
                                                      .experience.carspa ==
                                                  1
                                              ? "Car Wash, "
                                              : "") +
                                          (authController
                                                      .userModel
                                                      .partnerApplicationId
                                                      .experience
                                                      .mechanical ==
                                                  1
                                              ? "Mechanic, "
                                              : "") +
                                          (authController
                                                      .userModel
                                                      .partnerApplicationId
                                                      .experience
                                                      .quickhelp ==
                                                  1
                                              ? "Road Side Assistance, "
                                              : "") +
                                          (authController
                                                      .userModel
                                                      .partnerApplicationId
                                                      .experience
                                                      .shoppe ==
                                                  1
                                              ? "Accessories & Spare Parts, "
                                              : ""),
                                      maxLines: 5,
                                      style:
                                          robotoMedium.copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Working Time : ',
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).disabledColor),
                                  ),
                                  Text(
                                    authController
                                                .userModel
                                                .partnerApplicationId
                                                .availability ==
                                            "any"
                                        ? "Any"
                                        : "Shift Time",
                                    style: robotoMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Attachments",
                                  style: robotoRegular,
                                ),
                                // CustomButton(
                                //   width: Get.width * 0.2,
                                //   height: 25,
                                //   buttonText: "Change",
                                //   fontSize: 14,
                                //   backgroundColor: Colors.black87,
                                //   onPressed: () {},
                                // )
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            authController.userModel.partnerApplicationId
                                        .imageUrl.length >
                                    0
                                ? Row(children: [
                                    CustomImage(
                                      image: authController
                                                      .userModel
                                                      .partnerApplicationId
                                                      .imageUrl !=
                                                  null &&
                                              authController
                                                      .userModel
                                                      .partnerApplicationId
                                                      .imageUrl
                                                      .length >
                                                  0
                                          ? authController.userModel
                                              .partnerApplicationId.imageUrl[0]
                                          : "",
                                      height: 120,
                                      width: 120,
                                    ),
                                    SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    authController
                                                .userModel
                                                .partnerApplicationId
                                                .imageUrl
                                                .length >
                                            1
                                        ? CustomImage(
                                            image: "image",
                                            height: 120,
                                            width: 120,
                                          )
                                        : SizedBox(),
                                  ])
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          'No image attached!',
                                          style: robotoMedium.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.8,
                    child: CustomButton(
                        buttonText: "Logout",
                        onPressed: () {
                          Get.back();
                          Get.dialog(ConfirmationDialog(
                              icon: Images.support,
                              description: 'are_you_sure_to_logout'.tr,
                              isLogOut: true,
                              onYesPressed: () {
                                Get.find<AuthController>().clearSharedData();
                                Get.find<AuthController>().stopLocationRecord();
                                Get.offAllNamed(RouteHelper.getSignInRoute());
                              }));
                        }),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
