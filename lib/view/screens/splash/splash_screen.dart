import 'dart:async';

import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:connectivity/connectivity.dart';
import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Timer(Duration(seconds: 1), () async {
      // if (Get.find<SplashController>().configModel.maintenanceMode) {
      //   Get.ofnamed(RouteHelper.getUpdateRoute(false));
      // } else {
      if (Get.find<AuthController>().isLoggedIn()) {
        await Get.find<AuthController>()
            .getProfile(userID: Get.find<AuthController>().getUserId())
            .then((value) async {
          if (Get.find<AuthController>().userModel.partnerApplicationId ==
              null) {
            Get.find<AuthController>().updateToken();
            await Get.find<AuthController>()
                .getWorkerWorkDetails()
                .then((value) => Get.offNamed(RouteHelper.getInitialRoute()));
          } else {
            if (Get.find<AuthController>().userModel.partnerApplicationId !=
                    null &&
                Get.find<AuthController>()
                        .userModel
                        .partnerApplicationId
                        .status ==
                    "Approved") {
              Get.find<AuthController>().updateToken();
              await Get.find<AuthController>()
                  .getWorkerWorkDetails()
                  .then((value) => Get.offNamed(RouteHelper.getInitialRoute()));
            } else {
              Get.offNamed(RouteHelper.approvalWaiting);
            }
          }
        });
      } else {
        Get.offNamed(RouteHelper.getSignInRoute());
      }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(Images.logo, width: 150),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Image.asset(Images.logo_name, width: 150),
            //Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25), textAlign: TextAlign.center),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text('suffix_name'.tr,
                style: robotoMedium, textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }
}
