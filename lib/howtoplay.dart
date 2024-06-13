import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/common.dart';

class Howtoplay extends StatefulWidget {
  Howtoplay();
  @override
  createState() => _HowtoplayState();
}

class _HowtoplayState extends State<Howtoplay> {
  var _url;
  final _key = UniqueKey();
  bool isLoading = true;
  _HowtoplayState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: "https://onzlah.live/#how-to-play",
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              )
            ],
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
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
            "How to play",
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
