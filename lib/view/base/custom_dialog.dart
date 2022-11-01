import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

CustomDialog(
    {String title = "Loading",
    String descriptions = "Please wait...",
    bool isLoading = false,
    bool isCompleted = false,
    String buttonText = "Continue",
    VoidCallback onPressed}) async {
  showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(
              context: Get.context,
              buttonText: buttonText,
              descriptions: descriptions,
              title: title,
              isLoading: isLoading,
              onPressed: onPressed),
        );
      });
  if (isCompleted) {
    Navigator.of(Get.context).pop();
  }
}

contentBox(
    {BuildContext context,
    String title,
    String descriptions,
    String buttonText,
    bool isLoading = false,
    VoidCallback onPressed}) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding),
        margin: EdgeInsets.only(top: Constants.avatarRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: robotoBold.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              descriptions,
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            isLoading ? CustomLoader() : SizedBox(),
            SizedBox(
              height: 22,
            ),
            onPressed != null && !isLoading
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(
                          buttonText,
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                : SizedBox(),
          ],
        ),
      ),
      // bottom part
      Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset(Images.logo)),
          )), // top part
    ],
  );
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
