import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/product_details_model.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/helper/route_helper.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_alert_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/discount_tag.dart';
import 'package:carclenx_vendor_app/view/base/rating_bar.dart';
import 'package:carclenx_vendor_app/view/screens/error_screens.dart/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProductWidget extends StatelessWidget {
  MyProductWidget({Key key, @required this.productDetails}) : super(key: key);
  ProductDetails productDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Get.find<ShoppeController>().setProduct(productDetails);
        Get.toNamed(RouteHelper.myProductDetails);
      }),
      child: Card(
          child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[Get.isDarkMode ? 700 : 300],
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        child: CustomImage(
                          image: productDetails.thumbUrl.length > 0
                              ? productDetails.thumbUrl[0]
                              : '',
                          height: 65,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      DiscountTag(
                        discount: double.parse((PriceConverter
                                .percentageCalculationWithDiscountAmount(
                                    double.parse(
                                        productDetails.price.toString()),
                                    double.parse(
                                        productDetails.offerPrice.toString()))))
                            .ceilToDouble(),
                        discountType: 'percent',
                        freeDelivery: false,
                      ),
                      productDetails.quantity > 0
                          ? SizedBox()
                          : NotAvailableWidget(isRestaurant: false),
                    ]),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            productDetails.name,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          RatingBar(
                            rating: double.parse(
                                productDetails.ratings.average.toString()),
                            size: 12,
                            ratingCount: productDetails.ratings != null
                                ? (productDetails.ratings.oneStar.count +
                                    productDetails.ratings.twoStar.count +
                                    productDetails.ratings.threeStar.count +
                                    productDetails.ratings.fourStar.count +
                                    productDetails.ratings.fiveStar.count)
                                : 0.0,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Row(children: [
                            Text(
                              PriceConverter.convertPrice(double.parse(
                                  productDetails.offerPrice.toString())),
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL),
                            ),
                            SizedBox(
                                width: productDetails.offerPrice > 0
                                    ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                                    : 0),
                            productDetails.offerPrice > 0
                                ? Text(
                                    PriceConverter.convertPrice(double.parse(
                                        productDetails.price.toString())),
                                    style: robotoMedium.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color: Theme.of(context).disabledColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : SizedBox(),
                          ]),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Row(children: [
                            Text(
                              'Quantity : ',
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL),
                            ),
                            SizedBox(
                                width: productDetails.offerPrice > 0
                                    ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                                    : 0),
                            Text(
                              productDetails.quantity.toString(),
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL),
                            ),
                            SizedBox(
                                width: productDetails.offerPrice > 0
                                    ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                                    : 0),
                            Text(
                              'available',
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).disabledColor,
                              ),
                            )
                          ]),
                        ]),

                    //   Row(
                    //     children: [
                    //       IconButton(
                    //         onPressed: () {
                    //           // TODO: add productDetails
                    //           // Get.toNamed(RouteHelper.getProductRoute(productDetails));
                    //         },
                    //         icon: Icon(Icons.edit, color: Colors.blue),
                    //       ),
                    //       SizedBox(
                    //         width: Dimensions.PADDING_SIZE_SMALL,
                    //       ),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.delete_forever, color: Colors.red),
                    //       ),
                    //     ],
                    //   ),
                  ]),
                  Row(
                    children: [
                      Text(
                        'Status',
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Icon(
                        Icons.radio_button_checked,
                        size: 16,
                        color: productDetails.status == 1
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  )
                ]),
          ),
        ]),
      )),
    );
  }
}
