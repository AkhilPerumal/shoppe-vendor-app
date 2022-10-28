import 'package:carclenx_vendor_app/controller/shoppe_controller.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductModelSheet extends StatelessWidget {
  const ProductModelSheet({Key key}) : super(key: key);

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
                    "Selected Models",
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
                    itemCount: shoppeController.modelList.length,
                    controller: scrollController,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          leading: CustomImage(
                              image:
                                  shoppeController.modelList[index].thumbUrl !=
                                          null
                                      ? shoppeController
                                          .modelList[index].thumbUrl[0]
                                      : "",
                              fit: BoxFit.cover,
                              width: 35),
                          title: Text(shoppeController.modelList[index].name),
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
