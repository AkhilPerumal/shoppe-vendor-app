import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Refer",
        isBackButtonExist: true,
      ),
      body: Column(children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(children: []),
        ))
      ]),
    );
  }
}
