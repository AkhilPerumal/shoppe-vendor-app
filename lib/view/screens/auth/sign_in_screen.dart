import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:carclenx_vendor_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _countryDialCode = "+91";
    _nameController.text = "akhil.dev.vendor";
    _passwordController.text = "akhil.dev.vendor";

    // _nameController.text = Get.find<AuthController>().getUserName() ?? '';
    // _passwordController.text =
    //     Get.find<AuthController>().getUserPassword() ?? '';

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Center(
              child: SizedBox(
                width: 1170,
                child: GetBuilder<AuthController>(builder: (authController) {
                  return Column(children: [
                    Column(
                      children: [
                        Image.asset(Images.logo, width: 100),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Image.asset(Images.logo_name, width: 100),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('sign_in'.tr.toUpperCase(),
                          style: robotoBlack.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                    ),
                    // SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 800 : 200],
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Column(children: [
                          CustomTextField(
                            hintText: 'user_name'.tr,
                            controller: _nameController,
                            focusNode: _phoneFocus,
                            prefixIcon: Icons.person,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.name,
                            divider: false,
                          ),
                          CustomTextField(
                            hintText: 'password'.tr,
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            onSubmit: (text) => GetPlatform.isWeb
                                ? _login(
                                    authController,
                                    _nameController,
                                    _passwordController,
                                    _countryDialCode,
                                    context,
                                  )
                                : null,
                          ),
                        ]),
                      ),
                    ),
                    // SizedBox(height: 10),
                    // Row(children: [
                    //   Expanded(
                    //     child: ListTile(
                    //       onTap: () => authController.toggleRememberMe(),
                    //       leading: Checkbox(
                    //         activeColor: Theme.of(context).primaryColor,
                    //         value: authController.isActiveRememberMe,
                    //         onChanged: (bool isChecked) =>
                    //             authController.toggleRememberMe(),
                    //       ),
                    //       title: Text('remember_me'.tr),
                    //       contentPadding: EdgeInsets.zero,
                    //       dense: true,
                    //       horizontalTitleGap: 0,
                    //     ),
                    //   ),
                    //   // TextButton(
                    //   //   onPressed: () =>
                    //   //       Get.toNamed(RouteHelper.getForgotPassRoute()),
                    //   //   child: Text('${'forgot_password'.tr}?'),
                    //   // ),
                    // ]),
                    SizedBox(height: 50),
                    !authController.isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              buttonText: 'sign_in'.tr,
                              onPressed: () => _login(
                                  authController,
                                  _nameController,
                                  _passwordController,
                                  _countryDialCode,
                                  context),
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        buttonText: "Join Up As Pexa Partner",
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          Get.toNamed(RouteHelper.signUp,
                              arguments: {"fromSignIn": true});
                        },
                      ),
                    ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     minimumSize: Size(1, 40),
                    //   ),
                    //   onPressed: () async {
                    //     Get.toNamed(RouteHelper.signUp);
                    //   },
                    //   child: RichText(
                    //       text: TextSpan(children: [
                    //     TextSpan(
                    //         text: '${'join_as_a'.tr} ',
                    //         style: robotoRegular.copyWith(
                    //             color: Theme.of(context).disabledColor)),
                    //     TextSpan(
                    //         text: 'Pexa Partner',
                    //         style: robotoMedium.copyWith(
                    //             color: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyText1
                    //                 .color)),
                    //   ])),
                    // ),
                    // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  ]);
                }),
              ),
            ),
          ),
        ),
      )),
    );
  }

  void _login(
      AuthController authController,
      TextEditingController nameCtlr,
      TextEditingController passCtlr,
      String countryCode,
      BuildContext context) async {
    String _name = nameCtlr.text.trim();
    String _password = passCtlr.text.trim();

    bool _isValid = false;

    if (_name.isEmpty) {
      showCustomSnackBar('enter_name'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController.login(_name, _password).then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNameAndPassword(_name, _password);
          } else {
            authController.clearUserNameAndPassword();
          }
          await Get.find<AuthController>()
              .getProfile(userID: authController.userModel.id)
              .then((value) {
            if (authController.userModel.partnerApplicationId != null) {
              if (authController.userModel.status == "Approved") {
                Get.find<AuthController>().getWorkerWorkDetails().then(
                    (value) => Get.offAllNamed(RouteHelper.getInitialRoute()));
              } else {
                Get.offNamed(RouteHelper.approvalWaiting);
              }
            } else {
              Get.find<AuthController>().getWorkerWorkDetails().then(
                  (value) => Get.offAllNamed(RouteHelper.getInitialRoute()));
            }
          });
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }

    /*print('------------1');
    final _imageData = await Http.get(Uri.parse('https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png'));
    print('------------2');
    String _stringImage = base64Encode(_imageData.bodyBytes);
    print('------------3 {$_stringImage}');
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString('image', _stringImage);
    print('------------4');
    Uint8List _uintImage = base64Decode(_sp.getString('image'));
    authController.setImage(_uintImage);
    //await _thetaImage.writeAsBytes(_imageData.bodyBytes);
    print('------------5');*/
  }
}
