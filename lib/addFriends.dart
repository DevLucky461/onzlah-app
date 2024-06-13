import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => new _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BackNavigation(),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Common.AppColor,
            ),
          ),
        ),
        body: FutureBuilder(
            future: _id,
            builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                ? WebView(
                    initialUrl: Common.ApiUrl + 'viewMyFriendsAddFriend/' + snapshot.data,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      webView = controller;
                    },
                  )
                : Center(child: CircularProgressIndicator())));
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
          child: Image.asset(
            'assets/icon/left-arrow.png',
            height: 20,
          ),
        ),
        Expanded(
          child: Text(
            "Search Friend",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'MontserratExtraBold',
                fontSize: 16.0,
                decoration: TextDecoration.none,
                color: Color(0xffFFEF41)),
          ),
        ),
      ],
    );
  }
}
