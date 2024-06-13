import 'dart:convert';

import 'package:flutter/material.dart';

import 'beOurPartner.dart';
import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';
import 'editPassword.dart';
import 'editProfile.dart';
import 'faq.dart';
import 'profile/coinsTransaction.dart';
import 'referral.dart';
import 'shareFeedback.dart';
import 'termsCondition.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  final logout = Logout();
  String _userPicture = "", _userName = "", userID = "";
  int userLife = 0, userCoins = 0;

  //int _userCoinst = 0, _userLifeInt = 0;

  @override
  void initState() {
    getUser();

    super.initState();
  }

  getUser() async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (mounted) {
      if (body['message'] != null) {
        logout.run(context);
      } else {
        setState(() {
          _userPicture = body['user']['picture'].toString();
          _userName = body['user']['name'].toString();
          userLife = body['user']['life'];
          userCoins = body['user']['coins'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Common.profile_start_color, Common.profile_end_color],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.network(
                          Common.BaseUrl + _userPicture,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
                              (loadingProgress == null)
                                  ? child
                                  : Center(child: CircularProgressIndicator()),
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/img/profile-icon-unlit.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        width: MediaQuery.of(context).size.width - 140,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Text(
                                "Version 1.0.7",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MontserratRegular',
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _userName ?? "No Username",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'MontserratBold',
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => CoinsTransaction()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image.asset('assets/img/coins.png'),
                                ),
                                Text(
                                  numberFormatter(userCoins),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MontserratBold',
                                      fontSize: 19.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Image.asset('assets/img/lifes.png'),
                              ),
                              Text(
                                numberFormatter(userLife) == "" ? "0" : numberFormatter(userLife),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'MontserratBold',
                                    fontSize: 19.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Edit Profile",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPassword()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Edit Password ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Referral()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Referral Code ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("FAQs",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BeOurPartner()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Be Our Partner",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShareFeedback()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Share Feedback",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TermsConditions()));
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Terms & Conditions",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratSemiBold',
                            )),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
              Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    // user must tap button!
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text('Logout'),
                        content: new SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                  'This action will make you exit the app. Do you want to logout?'),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                            color: Common.pink_dark_color,
                            child: Text('Logout'),
                            onPressed: () {
                              logout.restart(context);
                            },
                          ),
                          FlatButton(
                            color: Common.orange_color,
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'MontserratSemiBold',
                          ),
                        ),
                        Image.asset(
                          'assets/icon/right-arrow.png',
                          height: 15,
                        )
                      ],
                    )),
              ),
            ],
          )
        ],
      )),
    );
  }
}
