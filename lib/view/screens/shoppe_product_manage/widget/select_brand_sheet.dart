import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/screens/shoppe/widget/select_models_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBrandSheet extends StatelessWidget {
  SelectBrandSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.96,
        maxChildSize: 0.96,
        expand: false,
        builder: (context, scrollController) {
          return GetBuilder<CreateProductController>(
              builder: (createProductController) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (() => Get.back()),
                          icon: Icon(Icons.arrow_back_ios_new)),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: Get.width * 0.8,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(
                                  Dimensions.RADIUS_DEFAULT),
                              borderSide: new BorderSide(),
                            ),
                            suffixIcon: Icon(
                              Icons.search_rounded,
                            ),
                          ),
                          onChanged: (value) {
                            createProductController.searchMake(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: createProductController.makeList == null ||
                          createProductController.makeList.length == 0
                      ? Center(child: Text("No Result Found"))
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          padding: EdgeInsets.all(10),
                          itemCount: createProductController.makeList.length,
                          itemBuilder: ((context, index) {
                            // if (createProductController.selectedMake[index].name ==
                            //     "GENERAL") {
                            //   return Card(
                            //     child: CheckboxListTile(
                            //       value:
                            //           createProductController.isSelectedCustomBrand,
                            //       onChanged: ((value) => createProductController
                            //           .updateMakeGeneralStatus()),
                            //       secondary: CustomImage(
                            //           image: createProductController
                            //               .selectedMake[index].thumbUrl[0],
                            //           fit: BoxFit.cover,
                            //           width: 35),
                            //       title: Text(createProductController
                            //           .selectedMake[index].name),
                            //       // subtitle: Text('No of models selected : '),
                            //     ),
                            //   );
                            // }
                            return InkWell(
                              onTap: (() {
                                createProductController.getModelList(
                                    createProductController.makeList[index].id);
                                Get.bottomSheet(
                                    SelectModelSheet(
                                        selectedBrandId: createProductController
                                            .makeList[index].id),
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0))),
                                    isScrollControlled: true);
                              }),
                              child: Card(
                                child: ListTile(
                                  leading: CustomImage(
                                      image: createProductController
                                          .makeList[index].thumbUrl[0],
                                      fit: BoxFit.cover,
                                      width: 35),
                                  title: Text(createProductController
                                      .makeList[index].name),
                                  subtitle: Text('No of models selected : ' +
                                      createProductController
                                          .getSelectedModelCount(
                                              createProductController
                                                  .makeList[index].id)
                                          .toString()),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
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
            );
          });
        });
  }
}
