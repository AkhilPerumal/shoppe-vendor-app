import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe_product_manage/widget/product_model_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';

class ProductBrandSheet extends StatelessWidget {
  const ProductBrandSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.96,
        maxChildSize: 0.96,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (() => Get.back()),
                      icon: Icon(Icons.arrow_back_ios_new)),
                  Text(
                    "Selected Brands",
                    style: robotoBold.copyWith(fontSize: 16),
                  ),
                  SizedBox()
                ],
              ),
              Expanded(
                child:
                    GetBuilder<ShoppeController>(builder: (shoppeController) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: shoppeController.makeList.length,
                    controller: scrollController,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: (() {
                          shoppeController.getModelList(
                              shoppeController.makeList[index].id);
                          Get.bottomSheet(ProductModelSheet(),
                              backgroundColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0))),
                              isScrollControlled: true);
                        }),
                        child: Card(
                          child: ListTile(
                            leading: CustomImage(
                                image:
                                    shoppeController.makeList[index].thumbUrl !=
                                            null
                                        ? shoppeController
                                            .makeList[index].thumbUrl[0]
                                        : "",
                                fit: BoxFit.cover,
                                width: 35),
                            title: Text(shoppeController.makeList[index].name),
                            subtitle: Text('No of models selected : ' +
                                shoppeController.selectedProduct.modelId.length
                                    .toString()),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ],
          );
        });
  }
}
