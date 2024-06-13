import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'common/api.dart';

class NotiSetting extends StatefulWidget {
  @override
  _NotiSettingState createState() => new _NotiSettingState();
}

class _NotiSettingState extends State<NotiSetting> {
  bool update_news_status_email = false,
      update_news_status_app = false,
      items_reddem_email = false,
      items_reddem_app = false,
      live_schedule_email = false,
      live_schedule_app = false,
      live_start_email = false,
      live_start_app = false,
      coins_won_email = false,
      coins_won_app = false,
      friend_request_email = false,
      friend_request_app = false,
      friend_request_approve_email = false,
      friend_request_approve_app = false,
      referral_code_email = false,
      referral_code_app = false;

  _getData() async {
    var data;
    var res = await CallApi().postData(data, 'getNotiSettingsData');
    var body = json.decode(res.body);

    for (var bodys in body['notiSetting']) {
      if (bodys['setting'] == "Update latest news" && bodys['email'] == "true") {
        setState(() {
          update_news_status_email = true;
        });
      }

      if (bodys['setting'] == "Update latest news" && bodys['in_app'] == "true") {
        setState(() {
          update_news_status_app = true;
        });
      }

      if (bodys['setting'] == "New items to redeem" && bodys['email'] == "true") {
        items_reddem_email = true;
      }

      if (bodys['setting'] == "New items to redeem" && bodys['in_app'] == "true") {
        items_reddem_app = true;
      }

      if (bodys['setting'] == "Update Live schedule" && bodys['email'] == "true") {
        live_schedule_email = true;
      }

      if (bodys['setting'] == "Update Live schedule" && bodys['in_app'] == "true") {
        live_schedule_app = true;
      }

      if (bodys['setting'] == "Before Live start" && bodys['email'] == "true") {
        live_start_email = true;
      }

      if (bodys['setting'] == "Before Live start" && bodys['in_app'] == "true") {
        live_start_app = true;
      }

      if (bodys['setting'] == "Coins you’ve won" && bodys['email'] == "true") {
        coins_won_email = true;
      }

      if (bodys['setting'] == "Coins you’ve won" && bodys['in_app'] == "true") {
        coins_won_app = true;
      }

      if (bodys['setting'] == "Friend request" && bodys['email'] == "true") {
        friend_request_email = true;
      }

      if (bodys['setting'] == "Friend request" && bodys['in_app'] == "true") {
        friend_request_app = true;
      }

      if (bodys['setting'] == "Your friend request approved" && bodys['email'] == "true") {
        friend_request_approve_email = true;
      }

      if (bodys['setting'] == "Your friend request approved" && bodys['in_app'] == "true") {
        friend_request_approve_app = true;
      }

      if (bodys['setting'] == "Referral code has been used" && bodys['email'] == "true") {
        referral_code_email = true;
      }

      if (bodys['setting'] == "Referral code has been used" && bodys['in_app'] == "true") {
        referral_code_app = true;
      }
    }
    //print(update_news_status_email);
  }

  _postData(key, value, dataValue) async {
    var data = {'key': key, 'type': value, 'data': dataValue};

    var res = await CallApi().postData(data, 'postNotiSettingsData');
    var body = json.decode(res.body);
  }

  @override
  void initState() {
    _getData();

    super.initState();
  }

  var _titlestyle =
      TextStyle(fontSize: 16, fontFamily: 'NunitoSansSemiBold', fontWeight: FontWeight.w900);
  var _normalstyle =
      TextStyle(fontSize: 16, fontFamily: 'NunitoSansSemiBold', fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/header-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: BackNavigation(),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "EMAIL",
                        textAlign: TextAlign.center,
                        style: _titlestyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "IN-APP",
                          textAlign: TextAlign.center,
                          style: _titlestyle,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Update latest news",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: update_news_status_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                update_news_status_email = val;
                                _postData("Update latest news", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: update_news_status_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                update_news_status_app = val;
                                _postData("Update latest news", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "New items to redeem",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: items_reddem_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                items_reddem_email = val;
                                _postData("New items to redeem", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: items_reddem_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                items_reddem_app = val;
                                _postData("New items to redeem", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Update Live schedule",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: live_schedule_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                live_schedule_email = val;
                                _postData("Update Live schedule", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: live_schedule_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                live_schedule_app = val;
                                _postData("Update Live schedule", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Before Live start",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: live_start_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                live_start_email = val;
                                _postData("Before Live start", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: live_start_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                live_start_app = val;
                                _postData("Before Live start", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Coins you’ve won",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: coins_won_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                coins_won_email = val;
                                _postData("Coins you’ve won", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: coins_won_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                coins_won_app = val;
                                _postData("Coins you’ve won", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Friend request",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: friend_request_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                friend_request_email = val;
                                _postData("Friend request", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: friend_request_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                friend_request_app = val;
                                _postData("Friend request", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Your friend request approved",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: friend_request_approve_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                friend_request_approve_email = val;
                                _postData("Your friend request approved", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: friend_request_approve_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                friend_request_approve_app = val;
                                _postData("Your friend request approved", "in_app", val);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Referral code has been used",
                        style: _normalstyle,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: referral_code_email,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                referral_code_email = val;
                                _postData("Referral code has been used", "email", val);
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(width: 3, color: Colors.black)),
                          margin: EdgeInsets.all(5),
                          child: FlutterSwitch(
                            activeColor: Color(0xff12FAA5),
                            valueFontSize: 12,
                            toggleSize: 30,
                            value: referral_code_app,
                            borderRadius: 0,
                            padding: 8.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                _postData("Referral code has been used", "in_app", val);
                                referral_code_app = val;
                              });
                            },
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
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
            "NOTIFICATION SETTING",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'MontserratExtraBold',
                fontSize: 24.0,
                decoration: TextDecoration.none,
                color: Color(0xffFFEF41)),
          ),
        ),
      ],
    );
  }
}
