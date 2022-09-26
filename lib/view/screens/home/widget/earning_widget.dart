import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class EarningWidget extends StatelessWidget {
  final String title;
  final double amount;
  EarningWidget({@required this.title, @required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Text(
        title,
        style: robotoMedium.copyWith(
            fontSize: Dimensions.FONT_SIZE_SMALL,
            color: Theme.of(context).cardColor),
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
      Text(
        PriceConverter.convertPrice(amount != null ? amount : 0.0).toString(),
        style: robotoMedium.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: Theme.of(context).cardColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    ]));
  }
}
