import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewerScreen extends StatefulWidget {
  final bool isPrivacyPolicy;
  HtmlViewerScreen({@required this.isPrivacyPolicy});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
// Reference to webview controller
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    String _data = widget.isPrivacyPolicy
        ? 'https://carclenx.com/privacy-policy'
        : 'https://carclenx.com/car-washing-car-detailing-shop-car-parts-mobile/';
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.isPrivacyPolicy ? 'privacy_policy'.tr : 'About us'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          child: WebView(
            initialUrl: _data,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // Get reference to WebView controller to access it globally
              _controller = webViewController;
            },
            javascriptChannels: <JavascriptChannel>[
              // Set Javascript Channel to WebView
              _extractDataJSChannel(context),
            ].toSet(),
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              // In the final result page we check the url to make sure  it is the last page.
              if (url.contains('/privacy-policy')) {
                _controller.runJavascript(
                    "(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
              }
            },
          ),
        ),
      ),
    );
  }

  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Flutter',
      onMessageReceived: (JavascriptMessage message) {
        String pageBody = message.message;
        print('page body: $pageBody');
      },
    );
  }
}
