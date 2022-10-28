import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ApprovalWaitingScreen extends StatelessWidget {
  const ApprovalWaitingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Waiting for Approval"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: robotoRegular,
                  ),
                  // Text(
                  //   ':',
                  //   style: robotoRegular,
                  // ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'Verifying'.toUpperCase(),
                      style: robotoMedium.copyWith(color: Colors.green),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(
              height: Dimensions.PADDING_SIZE_LARGE,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'User Name',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'User Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Email',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Phone',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Prefered Location',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Location',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'District & State',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Years of Experience',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Experienced Services',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Working Time',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            ':',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor),
                          ),
                          Text(
                            'Name',
                            style: robotoMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
