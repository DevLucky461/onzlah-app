import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';
import 'homeslider.dart';
import 'leaderboard.dart';
import 'live.dart';
import 'myFriends.dart';
import 'notification.dart';
import 'profile.dart';
import 'redeem.dart';

class Home extends StatefulWidget {
  static int PageIndex = 0;

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final logout = Logout();
  int _currentIndex = 0;

  Widget _currentHeader = HomeAppHeader();

  PageController _pageController = PageController(keepPage: true);

  Timer timer;

  getUser() async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    }
  }

  @override
  void initState() {
    checkForLiveState();
    timer = Timer.periodic(Duration(seconds: 60), (t) => checkForLiveState());

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  checkForLiveState() async {
    var data;
    var res = await CallApi().postData(data, 'enable-livestream');
    var body = json.decode(res.body);
    if (body['message'] == "Token has expired") {
      logout.run(context);
    } else {
      bool enabled = body['status'].toString() == 'enable';
      enabled = true;
      if (enabled != Common.liveEnabled) {
        setState(() {
          Common.liveEnabled = enabled;
        });
      }
    }
  }

  _onPageChanged(int index) {
    setState(() {
      Home.PageIndex = index;
      _currentIndex = index;
    });
  }

  _onItemTap(int index) {
    print("Page index: " + index.toString());
    switch (index) {
      case 0:
        _currentHeader = HomeAppHeader();
        _pageController.jumpToPage(index);
        break;
      case 1:
        _currentHeader = LiveAppHeader();
        // _currentHeader = null;
        _pageController.jumpToPage(index);
        break;
      case 2:
        // _currentHeader = RedeemAppHeader();
        _currentHeader = null;
        _pageController.jumpToPage(index);
        break;
      case 3:
        _currentHeader = ProfileAppHeader();
        _pageController.jumpToPage(index);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure you want to quit?'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Common.AppColor,
                    ),
                    child: Text('Quit'),
                    onPressed: () => exit(0),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Colors.black,
                    ),
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
        child: Scaffold(
          appBar: _currentIndex != 1 && _currentIndex != 2
              ? AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Common.AppColor,
                    ),
                  ),
                  title: _currentHeader == null ? HomeAppHeader() : _currentHeader,
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Common.orange_color,
            // unselectedItemColor: Colors.black,
            // selectedItemColor: Common.AppColor,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Common.pink_dark_color,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Common.pink_light_color,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/img/BtmNaviIcon/home_icon_unlit.png', height: 40),
                activeIcon: Image.asset('assets/img/BtmNaviIcon/home_icon_lit.png', height: 40),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                    Common.liveEnabled
                        ? 'assets/img/BtmNaviIcon/live_icon_unlit_enable.png'
                        : 'assets/img/BtmNaviIcon/live_icon_unlit.png',
                    height: 40),
                activeIcon: Image.asset(
                    Common.liveEnabled
                        ? 'assets/img/BtmNaviIcon/live_icon_lit_enable.png'
                        : 'assets/img/BtmNaviIcon/live_icon_lit.png',
                    height: 40),
                label: 'LIVE',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/img/BtmNaviIcon/redeem_icon_unlit.png', height: 40),
                activeIcon: Image.asset('assets/img/BtmNaviIcon/redeem_icon_lit.png', height: 40),
                label: 'REDEEM',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/img/BtmNaviIcon/profile_icon_unlit.png', height: 40),
                activeIcon: Image.asset('assets/img/BtmNaviIcon/profile_icon_lit.png', height: 40),
                label: 'PROFILE',
              ),
            ],
            onTap: _onItemTap,
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              HomeSlider(),
              Live(),
              Redeem(),
              Profile(),
            ],
          ),
        ));
  }
}

class HomeAppHeader extends StatefulWidget {
  _HomeAppHeaderState createState() => new _HomeAppHeaderState();
}

class _HomeAppHeaderState extends State<HomeAppHeader> {
  final logout = Logout();

  Future<String> get _count async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    } else {
      var data2 = {
        'id': body['user']['id'].toString(),
      };

      var res2 = await CallApi().postData(data2, 'notification_count');
      var body_count = json.decode(res2.body);

      return body_count['noti_count'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/img/onzlah-logo.png', width: 100),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Leaderboard()));
                },
                child: Image.asset(
                  'assets/icon/leaderboard.png',
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              // SizedBox(width: 30),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => Qr()));
              //   },
              //   child: Image.asset(
              //     'assets/icon/qr.png',
              //     height: 24,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyFriends()));
                },
                child: Image.asset(
                  'assets/icon/friends.png',
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => NotificationPage()));
                },
                child: Stack(children: [
                  Image.asset(
                    'assets/icon/bell.png',
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  FutureBuilder(
                    future: _count,
                    builder: (BuildContext context, AsyncSnapshot snapshot) =>
                        snapshot.hasData && snapshot.data.toString() != '0'
                            ? Positioned(
                                right: 0,
                                child: Icon(Icons.circle, size: 12, color: Colors.red),
                              )
                            : SizedBox(),
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class LiveAppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image.asset('assets/img/onzlah-logo.png', width: 70),
        Expanded(
          child: Text(
            "Live",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 16.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}

class RedeemAppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/img/onzlah-logo.png', width: 70),
        Expanded(
          child: Text(
            "REDEEM",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'MontserratExtraBold',
                fontSize: 32.0,
                decoration: TextDecoration.none,
                color: Color(0xffFFEF41)),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}

class ProfileAppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/img/livestream/live-logo.png', width: 40),
        Expanded(
          child: Text(
            "PROFILE",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratBold',
              fontSize: 22.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
