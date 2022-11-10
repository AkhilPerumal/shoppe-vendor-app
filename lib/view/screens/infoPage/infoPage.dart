import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/screens/infoPage/widgets/aboutUs.dart';
import 'package:carclenx_vendor_app/view/screens/infoPage/widgets/pnp.dart';
import 'package:carclenx_vendor_app/view/screens/infoPage/widgets/tnc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  InformationPage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F4F7),
        // appBar: AppBar(
        //   title: Text(title,
        //       style: mediumFont(Colors.black),
        //   ),
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios,size: 15,),
        //     color: Theme.of(context).textTheme.bodyText1.color,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   backgroundColor: Theme.of(context).cardColor,
        //   elevation: 0,
        // ),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.profile_bg),
                  fit: BoxFit.cover,
                ),
              ),
              height: Get.height * 0.25,
              child: Column(children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: new IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text(
                    title,
                    style: robotoRegular.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  centerTitle: true,
                  // actions: [
                  //   IconButton(
                  //     icon: Image.network(
                  //       'https://res.cloudinary.com/carclenx-pvt-ltd/image/upload/v1650608062/Icons/Home/P_Search_80-removebg-preview_etr5jn.png',
                  //       width: 25,
                  //     ),
                  //     onPressed: () {
                  //       // Get.to(() => NewSearchScreen()).then((value) =>
                  //       //     Get.find<PexaSearchController>().isLoad.value =
                  //       // false);
                  //       // Get.to(SearchScreen());
                  //     },
                  //   ),
                  //   IconButton(
                  //     icon: Image.network(
                  //       'https://res.cloudinary.com/carclenx-pvt-ltd/image/upload/v1650606101/Icons/Home/P_Bell_80_vkc8dk.png',
                  //       width: 25,
                  //     ),
                  //     onPressed: () {
                  //       // Get.to(CartScreen());
                  //     },
                  //   ),
                  // ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      height: Get.height * 0.1,
                      width: Get.width,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.logo,
                            height: 80,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                'PEXA',
                                style: robotoBold.copyWith(
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'PARTNER',
                                style: robotoBold.copyWith(
                                  color: Colors.black,
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppConstants.APP_VERSION,
                                style: robotoMedium.copyWith(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                )
              ]),
            ),
            title == 'About Us'
                ? AboutUs()
                : title == 'Privacy and Policy'
                    ? PrivacyAndPolicy()
                    : title == 'Terms and Conditions'
                        ? Terms()
                        : SizedBox()
          ]),
        ));
  }
}
