import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class Redeem extends StatefulWidget {
  @override
  _RedeemState createState() => new _RedeemState();
}

class _RedeemState extends State<Redeem> with SingleTickerProviderStateMixin {
  final logout = Logout();
  WebViewController webView;

  Future<String> get _id async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    } else {
      await Future.delayed(Duration(seconds: 1));

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
              initialUrl: Common.ApiUrl + 'viewRedeemPage/' + snapshot.data,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                webView = controller;
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
