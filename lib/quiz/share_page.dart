import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/live.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';

class Share extends StatefulWidget {
  final OnCloseCall callback;
  final String referral;

  Share(this.referral, this.callback);

  @override
  State<StatefulWidget> createState() => ShareState();
}

class ShareState extends State<Share> {
  List<String> shareOption = [];
  String LinkToShare;
  String MsgToShare;

  @override
  void initState() {
    shareOption.add('assets/img/livestream/facebook.png');
    shareOption.add('assets/img/livestream/whatsapp.png');
    shareOption.add('assets/img/livestream/twitter.png');
    shareOption.add('assets/img/livestream/chain.png');

    LinkToShare =
        "https://play.google.com/store/apps/details?id=com.onzlah.live\nhttps://apps.apple.com/us/app/onzlah/id1557183411";

    MsgToShare =
        "OnzLAH! is live right now! Join me at https://www.onzlah.live/\nSign up with my referral code " +
            widget.referral +
            " and get 5,000 coins!\n#PlayEarnSpend with OnzLAH!";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.black38,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return Container(
                  width: 30,
                );
              },
              shrinkWrap: true,
              itemCount: shareOption.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.callback.call(false);
                    switch (index) {
                      case 0: //Facebook
                        shareToFB();
                        break;
                      case 1: // Whatsapp
                        shareToWA();
                        break;
                      case 2: //Twitter
                        shareToTwitter();
                        break;
                      case 3: //Copy Link
                        Clipboard.setData(new ClipboardData(text: LinkToShare + "\n" + MsgToShare));
                        showMsg('Copied to Clipboard');
                        break;
                    }
                  },
                  child: Image.asset(
                    shareOption[index],
                    height: 50,
                    width: 50,
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Share to...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontFamily: 'MontserratBold',
                  )),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () {
                widget.callback.call(false);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.clear,
                      size: 25,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> shareToFB() async {
    File file = await getImageFileFromAssets("img/onzlah-main.png");

    String response = await SocialShare.shareFacebookStory(
      file.path,
      "#ffffff",
      "#000000",
      LinkToShare + "\n" + MsgToShare,
      appId: "520976824956520",
    );
  }

  Future<void> shareToWA() async {
    String response = await SocialShare.shareWhatsapp(LinkToShare + "\n" + MsgToShare);
  }

  Future<void> shareToTwitter() async {
    String response = await SocialShare.shareTwitter(
      MsgToShare,
      url: LinkToShare,
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    return file;
  }
}
