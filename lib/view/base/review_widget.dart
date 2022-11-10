import 'package:carclenx_vendor_app/data/model/response/feedback_model.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewWidget extends StatelessWidget {
  final String productName;
  final String rating;
  final String description;
  final String productImage;

  final bool hasDivider;
  ReviewWidget({
    @required this.hasDivider,
    @required this.productName,
    @required this.rating,
    @required this.description,
    @required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[Get.isDarkMode ? 800 : 200],
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Column(children: [
        Row(
          children: [
            Text(
              "Review",
              style: robotoRegular.copyWith(
                  color: Theme.of(context).disabledColor),
            )
          ],
        ),
        SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),
        Row(children: [
          ClipOval(
            child: CustomImage(
              image: productImage,
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
                  productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: Theme.of(context)
                          .textTheme
                          .headline1
                          .backgroundColor),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                RatingBar(
                    rating: double.parse(rating), ratingCount: null, size: 15),
                // fromRestaurant
                //     ? Text(
                //         'customer name',
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //         style: robotoMedium.copyWith(
                //             fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                //             color: Theme.of(context).textTheme.headline1.color),
                //       )
                //     : SizedBox(),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(description != null ? description : "No comments",
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: Theme.of(context).disabledColor)),
              ])),
        ]),
        // hasDivider
        //     ? Padding(
        //         padding: EdgeInsets.only(left: 70),
        //         child: Divider(color: Theme.of(context).disabledColor),
        //       )
        //     : SizedBox(),
      ]),
    );
  }
}
