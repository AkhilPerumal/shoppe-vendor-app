import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotAvailableWidget extends StatelessWidget {
  final double fontSize;
  final bool isRestaurant;
  NotAvailableWidget({this.fontSize = 8, this.isRestaurant = false});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: Colors.black.withOpacity(0.6)),
        child: Text(
          isRestaurant ? 'closed_now'.tr : "Out of Stock",
          textAlign: TextAlign.center,
          style:
              robotoRegular.copyWith(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
