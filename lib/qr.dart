import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class Qr extends StatefulWidget {
  @override
  _QrState createState() => new _QrState();
}

class _QrState extends State<Qr> {
  final logout = Logout();
  InAppWebViewController _webViewController;

  checkPermissions() async {
    var camerastatus = await Permission.camera.status;
    var microphonestatus = await Permission.microphone.status;
    var accessMediaLocationStatus = await Permission.accessMediaLocation.status;
    print(camerastatus);

    if (camerastatus.isGranted == false) {
      await Permission.camera.request();
    }

    if (microphonestatus.isGranted == false) {
      await Permission.microphone.request();
    }

    if (accessMediaLocationStatus.isGranted == false) {
      await Permission.accessMediaLocation.request();
    }

    if (camerastatus.isDenied == true) {
      await Permission.camera.request();
    }

    if (microphonestatus.isDenied == true) {
      await Permission.microphone.request();
    }

    if (accessMediaLocationStatus.isDenied == true) {
      await Permission.accessMediaLocation.request();
    }
  }

  @override
  void initState() {
    checkPermissions();

    super.initState();
  }

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
              ? InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(Common.ApiUrl + 'qrmobile/' + snapshot.data)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      // debuggingEnabled: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  androidOnPermissionRequest: (InAppWebViewController controller, String origin,
                      List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources, action: PermissionRequestResponseAction.GRANT);
                  })
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
          child: Image.asset(
            'assets/icon/left-arrow.png',
            height: 20,
          ),
        ),
        Expanded(
          child: Text(
            "Scan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratBold',
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
