import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/order_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_order_details.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  final ProductOrderDetails orderdetails;
  ProductWidget({@required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              image: orderdetails.orderDetails.productDetails.thumbUrl !=
                          null &&
                      orderdetails.orderDetails.productDetails.thumbUrl.length >
                          0
                  ? orderdetails.orderDetails.productDetails.thumbUrl[0]
                  : "",
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                  height: 50, width: 50, fit: BoxFit.cover),
            )),
        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text('✕ ${orderdetails.orderDetails.count}'),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
            child: Text(
          orderdetails.orderDetails.productDetails.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
        )),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Text(
          PriceConverter.convertPrice(orderdetails.total.toDouble()),
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
        ),
      ]),
    );
  }
}
