import 'package:carclenx_vendor_app/data/model/response/feedback_model.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewWidget extends StatelessWidget {
  final FeedbackModel review;
  final bool hasDivider;
  final bool fromRestaurant;
  ReviewWidget(
      {@required this.review,
      @required this.hasDivider,
      @required this.fromRestaurant});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        ClipOval(
          child: CustomImage(
            image: '',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                'Product',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color:
                        Theme.of(context).textTheme.headline1.backgroundColor),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              RatingBar(
                  rating: review.rating.toDouble(),
                  ratingCount: null,
                  size: 15),
              fromRestaurant
                  ? Text(
                      'customer name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: Theme.of(context).textTheme.headline1.color),
                    )
                  : SizedBox(),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(review.description,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      color: Theme.of(context).disabledColor)),
            ])),
      ]),
      hasDivider
          ? Padding(
              padding: EdgeInsets.only(left: 70),
              child: Divider(color: Theme.of(context).disabledColor),
            )
          : SizedBox(),
    ]);
  }
}
