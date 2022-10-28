import 'package:carclenx_vendor_app/controller/order_controller.dart';
import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';
import 'package:carclenx_vendor_app/helper/price_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/view/base/confirmation_dialog.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/screens/service_order/widget/verify_delivery_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCheckListSheet extends StatelessWidget {
  VerifyCheckListSheet();
  List<AddOn> selectedAddons;
  int total_amount;

  bool isAddOnAvailable = true;

  @override
  Widget build(BuildContext context) {
    isAddOnAvailable = selectedAddons != null && selectedAddons.length > 0;
    return Container(
      height: isAddOnAvailable ? Get.height * 0.5 : Get.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: GetBuilder<OrderController>(builder: (orderController) {
        total_amount = orderController.selectedOrder.serviceId.price;
        selectedAddons = orderController.selectedOrder.addOn
            .where((element) => element.isSelected == true)
            .toList();
        selectedAddons.forEach(
          (element) {
            total_amount = element.price + total_amount;
          },
        );
        return Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isAddOnAvailable
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("No Addon Service picked by customer"),
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: selectedAddons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              title: Text(selectedAddons[index].name),
                              trailing: Text(PriceConverter.convertPrice(
                                  double.tryParse(
                                      selectedAddons[index].price.toString()))),
                            );
                          },
                        ),
                      ),
                CustomButton(
                  buttonText:
                      PriceConverter.convertPrice(total_amount.toDouble()) +
                          " Payable",
                  onPressed: () {
                    Get.dialog(ConfirmationDialog(
                        icon: Images.warning,
                        title: 'Are you sure',
                        description: PriceConverter.convertPrice(
                                total_amount.toDouble()) +
                            ' is the payable amount. You sure to continue.',
                        onYesPressed: () {
                          orderController
                              .generateHappyCode(
                                  addons: selectedAddons,
                                  category:
                                      orderController.selectedOrder.category)
                              .then((value) {
                            if (value) {
                              Get.back();
                              Get.back();
                              Get.bottomSheet(
                                  VerifyDeliverySheet(
                                    verify: true,
                                    orderAmount: total_amount.toDouble(),
                                    cod: orderController
                                            .selectedOrder.paymentStatus ==
                                        'COD',
                                  ),
                                  isScrollControlled: true);
                            }
                          });
                        }));
                  },
                )
              ],
            ));
      }),
    );
  }
}
