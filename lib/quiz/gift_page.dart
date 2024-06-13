import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/api.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/live.dart';
import 'package:onzlah_app/quiz/model/sticker.dart';

class Gift extends StatefulWidget {
  final Key key;
  final List<Sticker> sticker;
  final int coin;
  final OnCloseCall callback;
  final OnStickerSend stickerCallback;
  final int eventID;

  Gift(this.key, this.eventID, this.sticker, this.coin, this.callback, this.stickerCallback);

  @override
  State<StatefulWidget> createState() => GiftState(coin);
}

class GiftState extends State<Gift> {
  int selectIndex = -1;

  bool click = false;
  int coin;

  GiftState(this.coin);

  void sendSticker(Sticker sticker) async {
    setState(() {
      click = true;
    });
    var data = {
      'sticker_id': sticker.id,
      'event_id': widget.eventID,
    };

    var res = await CallApi().postData(data, 'sticker-update');

    var body = json.decode(res.body);
    int userCoin = body['usercoin'];
    if (mounted) {
      setState(() {
        coin = userCoin;
        click = false;
      });
      widget.stickerCallback.call(sticker, coin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Gift',
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
                      size: 20,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 150,
              child: ListView.builder(
                itemCount: widget.sticker.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      selectIndex == index ? Colors.deepPurple : Colors.transparent,
                                  width: 2)),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: Common.BaseUrl + widget.sticker[index].src,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                width: 80,
                                height: 80,
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(widget.sticker[index].sticker_name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontFamily: 'NunitoSansExtraBold',
                                      )),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(widget.sticker[index].sticker_cost,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 10.0,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/coins.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        coin.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratSemiBold',
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.coin < 0) {
                        showMsg('Not enough coins to send stickers');
                        return;
                      }
                      if (selectIndex != -1) {
                        sendSticker(widget.sticker[selectIndex]);
                      }
                    },
                    child: click
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Common.orange_color, Common.pink_light_color],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                              child: Text(
                                'SEND',
                                style: TextStyle(
                                  color: Common.pink_dark_color,
                                  fontFamily: 'MontserratBold',
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
