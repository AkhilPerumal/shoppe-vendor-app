import 'dart:async';
import 'dart:io';

import 'package:carclenx_vendor_app/view/base/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyAndPolicy extends StatefulWidget {
  PrivacyAndPolicy({Key key}) : super(key: key);

  @override
  State<PrivacyAndPolicy> createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  final Completer<WebViewController> _completController =
      Completer<WebViewController>();
  WebViewController _myController;
  int position = 1;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      height: _height,
      child: IndexedStack(
        index: position,
        children: [
          WebView(
            initialUrl: 'https://carclenx.com/privacy-policy',
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            zoomEnabled: false,
            onWebViewCreated: (WebViewController webViewController) async {
              _completController.future.then((value) => _myController = value);
              _completController.complete(webViewController);
            },
            onPageStarted: (url) {
              print("Navigated to : " + url);
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (url) async {
              print("page completed");
              setState(() {
                position = 0;
              });
              _myController.runJavascript(
                  "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none';");
              _myController.runJavascript(
                  "document.getElementsByClassName('page-header')[0].style.display='none';");
              _myController.runJavascript(
                  "document.getElementById('kopa-page-header').style.display='none'");
              _myController.runJavascript(
                  "document.getElementById('bottom-sidebar').style.display='none'");
              _myController.runJavascript(
                  "document.getElementById('back-top').style.display='none'");
              _myController.runJavascript(
                  "document.getElementById('floatBtn-1').style.display='none'");
              _myController.runJavascript(
                  "document.getElementsByTagName('header').style.display='none'");
              _myController.runJavascript(
                  "document.getElementsByTagName('footer').style.display='none'");
              _myController.runJavascript(
                  "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none'");

              var html = await _myController.runJavascriptReturningResult(
                  "window.document.getElementById('upside-page-content')[0];");

              print(html);
            },
            onProgress: (progress) {
              print('WebView is loading (progress : $progress%)');

              // if (progress == 100) {
              //   isLoading = false;
              //   setState(() {});
              // } else {
              //   isLoading = true;
              //   setState(() {});
              // }
            },
            navigationDelegate: (NavigationRequest request) {
              // if (request.url.endsWith(".com/")) {
              //   if (kDebugMode) {
              //     print('blocking navigation to $request}');
              //   }
              //   return NavigationDecision.prevent;
              // }
              if (kDebugMode) {
                print('allowing navigation to $request');
              }
              return NavigationDecision.navigate;
            },
          ),
          LoadingScreen(),
        ],
      ),
    );
  }
}
