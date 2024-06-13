import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => new _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  WebViewController webView;
  final logout = Logout();

  Future<String> get _id async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    } else {
      await Future.delayed(Duration(milliseconds: 100));

      return body['user']['id'].toString();
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _id,
        builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
            ? WebView(
                initialUrl: Common.ApiUrl + 'viewMainPage/' + snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  webView = controller;
                },
                onPageFinished: (initialUrl) {
                  webView.evaluateJavascript(
                      "document.getElementsByClassName('main-header-bg')[0].style.display='none';");
                  webView.evaluateJavascript(
                      "document.getElementsByClassName('footer-pos')[0].style.display='none';");
                  webView.evaluateJavascript(
                      "document.getElementsByClassName('scroller')[0].style.height = '100%';");
                },
              )
            : Center(child: CircularProgressIndicator()));
  }
}
