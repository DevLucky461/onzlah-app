import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';

import 'common/api.dart';
import 'common/logout.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => new _FAQState();
}

class MyItem {
  MyItem({this.isExpanded, this.header, this.body});

  bool isExpanded;
  var header;
  var body;
}

class _FAQState extends State<FAQ> {
  final logout = Logout();

  @override
  void initState() {
    getUser();

    super.initState();
  }

  getUser() async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
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
        body: new SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Common.profile_start_color,
                  Common.profile_end_color,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Everything you need to know so you can OnzLAH like a pro.",
                    style: TextStyle(
                      fontFamily: 'MontserratRegular',
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  "My Profile",
                  style: TextStyle(
                    color: Common.pink_dark_color,
                    fontSize: 18,
                    fontFamily: 'MontserratBold',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I deactivate my account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'MontserratBold',
                        color: Colors.black,
                      ),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          'You won’t be able to deactivate/delete your OnzLAH! Account. You may simply not use your account if you no longer want or are able to play on OnzLAH!',
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular')),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "I forgot my username/password, what should I do?",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'MontserratBold',
                        color: Colors.black,
                      ),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Step 1: Fill in your email at the login page and click on “Forgot Password",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'MontserratRegular',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Step 2: Fill up your email and click the “Send” button.",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'MontserratRegular',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "You will receive confirmation email to reset your password.",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'MontserratRegular',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How can I change/update the information in my profile?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "Go to the profile tab at the menu bar bottom right and you may change/update your information accordingly.",
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Why did I not receive my verification code?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                        "Make sure you have keyed in the correct email.",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                      )
                    ],
                  ),
                ),
                Text(
                  "Coins",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'MontserratBold',
                    color: Common.AppColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Do coins expire?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("There is no expiration date for the coins.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Where can I check my coins balance?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("You may check your coins balance at your profile page.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How to earn coins?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "Play the game, ensure you make it to the final question and find out if you are among the lucky ones! Coins will be split evenly among the winners and auto debited to your account after the game ends.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I exchange coins for Host Gift?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Step 1 : During the live, click on “Gift” to see all stickers under Gift.",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Step 2 : Choose your favorite stickers, check on many coins you can exchange it for.",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Step 3 : Click “Send”.",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How to use coins that you have collected?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You can use the coins you have collected to redeem exciting rewards from the redeem tab at the bottom menu bar.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Can I change my coins to cash/ transfer to another account?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "No, Coins cannot be converted to cash or transferred to another player.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Text(
                  "Referral Code",
                  style: TextStyle(
                    color: Common.AppColor,
                    fontSize: 18,
                    fontFamily: 'MontserratBold',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Do lives expire?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("Accrued lives will never expire.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Where can I check my lives balance?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("You may check your remaining lives at your profile page.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Can I exchange my live to coins / transfer to another account?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "Life is not exchangeable for coins and transferrable to other accounts.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What is the point for “lives”?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "Lives can be used for you to continue playing the game when you answered wrongly.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How to use live that you have collected?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You can use them maximum 3 times per event, used right after each question that you answered wrongly.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What is the maximum number of life I can have?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("There is no maximum number of life when you play OnzLAH!.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What is the purpose of referral code?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "Purpose of the referral code is to introduce your friends and families to this app, and let them register their account using your referral codes. You will get 1 life for each account referenced using your referral code.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I use my referral code?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("Go to your profile and click on “My Referral Code”.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Where can I get my referral code?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("Tap on profile > My referral code > Copy > Send it to your friend.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Text(
                  "Engagements",
                  style: TextStyle(
                    color: Common.AppColor,
                    fontSize: 18,
                    fontFamily: 'MontserratBold',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What is the leaderboard for?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "A leaderboard on which the scores of the leading competitors are displayed.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I check the leaderboard?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("Go to home page and click on the trophy icon on top.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Whats the purpose of the leaderboard?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "To allow you to see your friend’s progress and to promote competitiveness. You can only see accounts that you have added as friends on the leaderboard.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What is the scan button for?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You can use the scan button to add friends, as an alternative to the search friend function.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How can I contact OnzLAH?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "You may contact OnzLAH! by:",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "*E-mail to info@onzlah.live",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "*Drop us a message via https://www.facebook.com/OnzLAH.live",
                              style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Redemption",
                  style: TextStyle(
                    color: Common.AppColor,
                    fontSize: 18,
                    fontFamily: 'MontserratBold',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I view my redeemed rewards?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You may view your rewards when you click “My Redeems” at your Redeem Page.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I view my redeemed rewards?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You may view your rewards when you click “My Redeems” at your Redeem Page.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "I accidentally redeem duplicate rewards. What should I do?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("You may email to info@onzlah.live to cancel the duplicated rewards.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "How do I know if a product (rewards) is still available?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "There will be an indicator on the Reward page on the remaining reward count.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "What if the rewards I've received appear to be different from the description?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "We select image that we hope most accurately reflect the color and shape of products alongside the product specification, but, depending on your screen resolution, or the manufacturer that supplies the product there may be small variations in colour, such as a slightly lightly shaded between the actual product and how it appear when viewed on the website.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Do the rewards have an expiry date?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "You may check the reward’s expiry date by going to the My Reward section on the Reward tab. Each of the reward’s expiry date is recorded in the details.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "If my reward expires, can I refund/exchange coins or extend my reward period?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "If your reward is expired,  it will not be refunded / exchanged / extended and replaced.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Can I cancel the reward redemption or exchange for another reward after redemption is confirmed?",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text("Redemption cannot be cancelled, exchanged or refunded.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    //tilePadding: EdgeInsets.all(20),
                    title: Text(
                      "Is there a limit to the number of reward redemption? (grab)",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'MontserratBold', color: Colors.black),
                    ),
                    childrenPadding: EdgeInsets.all(15),
                    children: [
                      Text(
                          "There is no limit to reward redemption subject to availability. However each redemption must be made separately.",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, fontFamily: 'MontserratRegular'))
                    ],
                  ),
                ),
              ],
            ),
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
          child: Image.asset(
            'assets/icon/left-arrow.png',
            height: 14,
          ),
        ),
        Expanded(
          child: Text(
            "FAQs",
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
