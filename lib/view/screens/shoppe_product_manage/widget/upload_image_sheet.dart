import 'dart:io';

import 'package:carclenx_vendor_app/controller/create_product_controller.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/view/base/custom_button.dart';
import 'package:carclenx_vendor_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadImageSheet extends StatelessWidget {
  const UploadImageSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.96,
        maxChildSize: 0.96,
        expand: false,
        builder: (context, scrollController) {
          return GetBuilder<CreateProductController>(
              builder: (createProductController) {
            return ListView(
              controller: scrollController,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (() => Get.back()),
                        icon: Icon(Icons.arrow_back_ios)),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomButton(
                        width: 60,
                        height: 30,
                        buttonText: "Upload",
                        onPressed: () {
                          if (createProductController.pickedImageList.length >
                                  0 &&
                              createProductController.pickedImageList.length <
                                  6) {
                            createProductController.imageUploader();
                          }
                        },
                      ),
                    )
                  ],
                ),
                GridView.count(
                    padding: EdgeInsets.all(10),
                    crossAxisSpacing: 10,
                    controller: scrollController,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(
                        createProductController.pickedImageList != null &&
                                createProductController.pickedImageList.length >
                                    0
                            ? createProductController.pickedImageList.length + 1
                            : 1, (index) {
                      if (index == 0) {
                        return imagePickerButton(
                            createProductController, context);
                      } else {
                        return imageHolder(
                            createProductController, context, index - 1);
                      }
                    })),
              ],
            );
          });
        });
  }

  Widget imageHolder(CreateProductController createProductController,
      BuildContext context, int index) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: Image.file(
              File(createProductController.pickedImageList[index].path),
              width: 150,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () => createProductController.removeImage(index),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT)),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget imagePickerButton(
      CreateProductController createProductController, BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: createProductController.pickedImage != null
                ? Image.file(
                    File(createProductController.pickedImage.path),
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: Images.placeholder,
                    height: 120,
                    width: 150,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder,
                        height: 120,
                        width: 150,
                        fit: BoxFit.cover),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                if (createProductController.pickedImageList.length >= 0 &&
                    createProductController.pickedImageList.length < 6) {
                  createProductController.pickImage(singleImage: false);
                } else {
                  showCustomSnackBar('Maximum image you can select is 5');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
