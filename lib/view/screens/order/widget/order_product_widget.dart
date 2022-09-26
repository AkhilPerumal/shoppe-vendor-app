import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/service_order_list_model.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderModel order;
  OrderProductWidget({@required this.order});

  @override
  Widget build(BuildContext context) {
    String _addOnText = '';
    order.addOn.forEach((addOn) {
      _addOnText = _addOnText +
          '${(_addOnText.isEmpty) ? '' : ',  '}${addOn.name} (${addOn.price})';
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            image: order.serviceId.thumbURL[0],
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                height: 50, width: 50, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(
                order.serviceId.name,
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              Text('${'quantity'.tr}:',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text(
                order.addOn.length.toString(),
                style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.FONT_SIZE_SMALL),
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(children: [
              Text(
                order.grandTotal.toString(),
                style: robotoMedium,
              ),
              SizedBox(width: 5),
              // orderDetails.discountOnFood > 0
              //     ? Expanded(
              //         child: Text(
              //         PriceConverter.convertPrice(orderDetails.price),
              //         style: robotoMedium.copyWith(
              //           decoration: TextDecoration.lineThrough,
              //           fontSize: Dimensions.FONT_SIZE_SMALL,
              //           color: Theme.of(context).disabledColor,
              //         ),
              //       ))
              //     : Expanded(child: SizedBox()),
            ]),
          ]),
        ),
      ]),
      _addOnText.isNotEmpty
          ? Padding(
              padding:
                  EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Row(children: [
                SizedBox(width: 60),
                Text('${'addons'.tr}: ',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL)),
                Flexible(
                    child: Text(_addOnText,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor,
                        ))),
              ]),
            )
          : SizedBox(),
      Divider(height: Dimensions.PADDING_SIZE_LARGE),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ]);
  }
}
