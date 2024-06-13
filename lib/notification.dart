import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  WebViewController webView;
  final logout = Logout();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaeaea),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Common.AppColor,
          ),
        ),
        title: BackNavigation(),
      ),
      body: FutureBuilder(
          future: _id,
          builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
              ? WebView(
                  initialUrl: Common.ApiUrl + 'notifications/' + snapshot.data,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    webView = controller;
                  },
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}

class BackNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/icon/left-arrow.png'),
        ),
        Expanded(
          child: Text(
            "Notifications",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 16.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ),
      ],
    );
  }
}
