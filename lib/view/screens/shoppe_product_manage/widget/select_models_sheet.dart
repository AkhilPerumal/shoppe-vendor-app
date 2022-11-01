import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectModelSheet extends StatelessWidget {
  SelectModelSheet({@required this.selectedBrandId});
  final String selectedBrandId;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.96,
        maxChildSize: 0.96,
        expand: false,
        builder: (context, scrollController) {
          return GetBuilder<CreateProductController>(
            builder: (createProductController) {
              return Container(
                height: Get.height * 0.9,
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: (() => Get.back()),
                            icon: Icon(Icons.arrow_back_ios_new)),
                        TextButton.icon(
                            onPressed: (() {
                              List<String> idList = [];
                              createProductController.modelList
                                  .forEach((element) {
                                idList.add(element.id);
                              });
                              createProductController.selectModel(
                                  idList: idList,
                                  status: !createProductController
                                      .checkallModelSelected());
                            }),
                            icon: Icon(
                                createProductController.checkallModelSelected()
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded),
                            label: Text(
                                createProductController.checkallModelSelected()
                                    ? "Clear All"
                                    : "Select All"))
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: createProductController.modelList.length,
                          itemBuilder: ((context, index) {
                            return CheckboxListTile(
                              secondary: CustomImage(
                                  image: createProductController
                                      .modelList[index].thumbUrl[0],
                                  fit: BoxFit.contain,
                                  width: 80),
                              title: Text(createProductController
                                  .modelList[index].name),
                              value: createProductController
                                  .modelList[index].isSelected,
                              onChanged: (bool value) {
                                createProductController.selectModel(idList: [
                                  createProductController.modelList[index].id
                                ], status: value);
                              },
                            );
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomButton(
                        width: Get.width * 0.8,
                        buttonText: 'Done',
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
