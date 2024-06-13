import 'package:flutter/material.dart';

import 'common/common.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Common.orange_color,
      body: new SafeArea(
        top: true,
        child: SingleChildScrollView(
            padding: new EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Common.pink_dark_color, borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/icon/close.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Terms and Conditions of Participation",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 24,
                      color: Common.pink_dark_color,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "1. Definitions",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "In these Terms and Conditions “OnzLAH!” is defined as the locally produced game show by The Hot Shoe Show & Co Sdn Bhd (“Hotshoes”) where players can play games, earn coins, and redeem prizes. “Program” refers to the OnzLAH! game show. “Player” is defined as an individual register to OnzLAH! games show. “Coins” refers to the coins earned during the Program. ‘Participating Brand’ means product provider or company/persons that are engaged by Hotshoes to supply the “product”. “Platform” refers to accessing online and mobile games through web app, mobile app, and/or other platforms. “Voucher” refers to a voucher in the form of printed or electronic which can be used to redeem the specific items and/or services offered by the Participating Brand.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "2. Introduction",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "These are the terms and conditions applicable to all participants of the Program.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Please read these terms and conditions (the “Terms”) carefully to ensure that you understand and agree to them, as they contain the legal terms and conditions that all participants shall be deemed to have agreed to when registering for the Program. For the avoidance of doubt, capitalized terms set and not defined herein have the same meaning as given to such terms in the Terms of Use. In the event of a conflict between the provision of these Terms and/or the Terms of Use, the provisions of these Terms shall prevail to the extent of such conflict. All participants must adhere to these Terms at all times.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Any references to “we”, “us” or “our” shall be taken as references to the Program. Any references to “you” or “your” shall be taken as references to any player for the Program.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "3. Eligibility",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "When you access our Program, you will need to create an account (“Account”). Only individuals above 18 years of age may register as the Player. Individuals under 18 years of age may take part in the Program with parental or legal guardian consent. If you are under the age of 18, you represent that your parents or legal guardian has reviewed and agreed to these Terms. If you access our Program through a third party platform like Apple or Google and/or a social networking site like Facebook, you are obligated to comply with their terms of service in addition to our Terms. When you register for an account or update the information, you agree to provide us accurate information and that you will keep it up-to-date at all times. If you are under the age of 18, you may never allow anyone else to use your account except your parents or legal guardian. If you have reason to believe that our account is no longer secure, then you must immediately notify us at info@onzlah.live.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "4. Your Obligations",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "4.1 By agreeing to these Terms, the Player:",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "comply with all applicable laws and regulations to the fullest extent when participating in the Program.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "b. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "comply with all instructions issued by OnzLAH! in relation to the Program, and you shall not as part if your participation in the Program, breach any of these terms. ",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "c. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "responsible for all information that you communicate, submit , transmit or otherwise make available during your participation in the Program whether to OnzLAH!.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "d. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "not participate in the Program or permit the participation in the Program in any manner which may adversely affect other customers’ participation in the Program or the goodwill or reputation of OnzLAH! ",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "e. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "not participate in the Program in a fraudulent manner, including but not limited to participation in the Program with more than one customer account or copying another person’s Program entry. ",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "f. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Each Eligible User can only participate with one customer account. participation in the Program shall be deemed to constitute your unconditional and irrevocable acceptance of these Terms, the Terms of Use, and any other such terms as may be notified to you by OnzLAH! from time to time.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "4.2 Where we deems that you have breached of any these Terms, or otherwise fraudulently participated in the Program, we reserve the right to:",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "prevent or restrict access of any Player to the Program, the OnzLAH! mobile application, or any of the OnzLAH! Platforms; or",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "report any activity it suspects to be in violation of any applicable law, statute or regulation to the appropriate authorities and to co-operate with such authorities.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "5. Coins",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Coins will be collected when a Player plays in the Program. Coins collected will be recorded in a Player’s account, for redemption by the Player of qualifying products or services from the Participating Brand subject always to Hotshoes’ right to appoint selected Participating Brand to offer products and/or services for the Programs. Coins cannot be converted to cash or transferred to another player. Coins can be used only for redemption in the Program.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "The Program permits the purchase of Coins and use of the Coins to redeem the products or services that we expressly make available for use in the Program. The purchase of Coins and redemption of products or services is limited to Account holders who are either (a) 18 years of age or older; or (b) under the age of 18 and have the consent of a Parent to make the purchase.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "All purchases of Coins from us are final and non-refundable, except as required by applicable law. By purchasing Coins from us, you represent and warrant that you have the authority and right to use the payment method selected by you and that such payment method has sufficient credit or funds available to complete your purchase. If you believe someone has gained unauthorized access to your Account or used your Account without your permission, you must notify us within 30 days of the charge date by emailing us at info@onzlah.live. We reserve the right to close any account with unauthorized charges.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Coins will be collected when a Player plays in the Program. Coins collected will be recorded in a Player’s account, for redemption by the Player of qualifying products or services from the Participating Brand subject always to Hotshoes’ right to appoint selected Participating Brand to offer products and/or services for the Programs. Coins cannot be converted to cash or transferred to another player. Coins can be used only for redemption in the Program.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "6. Redemption",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "The Player must maintain a minimum of 500 Coins in the Account. The Player with sufficient Coins is eligible to redeem, and you may do so using the various redemption methods implemented in the Program. Redemption orders once accepted by the Program cannot be revoked, cancelled, returned or exchanged, and the affected Coins will not be reinstated. The Program reserves the right to decline redemptions made through any other channels without any notification. the Program gives no representation or warranty with respect to any products and/or services featured in the redemption area. In particular, the Program gives no warranty with respect to the quality of the products and/or services or their suitability for any purpose. However, Player may liaise directly with the Participating Brand according to the redeemed item guideline.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Certain products, which are in the form of Voucher, are valid for use only at Participating Brand. The Voucher is valid for use until the date specified and subject to the terms and conditions (which includes booking requirements, cancellation restrictions, warranties and limitations of liability) therein. If Voucher remains unused after the date specified, the Voucher will lapse and will not be replaced. Cancellation of Voucher will not be accepted to allow reinstatement of Coins. The Voucher is not refundable or exchangeable for cash. In the event that Voucher is in the form of cash vouchers, the recipient will have to bear the difference if purchase of products or services exceeds the Voucher face value. If the purchase amount is less than the Voucher value, the difference will not be paid out to the Player",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Issuance of dining, travel, event or hotel accommodation Voucher does not constitute a reservation. The Player is responsible for notifying and making all reservations. The Program does not accept liability whatsoever (including negligence) with respect to the products supplied or in connection with any Participating Brand’s refusal to accept Vouchers issued by Hotshoes for the purpose of redeeming product. Any disputes’ arising from this is solely between the Player and Participating Brand.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "7. Deduction of Coins",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "The number of Coins published for the product and/or service claimed by a Player will be deducted from the Coin balance of the Player’s account. Hotshoes may also deduct from the Coin balance in a Player’s account, given the following circumstances: -",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Any Coins suspected to be fraudulently recorded; or",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "b. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Any Coins recorded in error; or",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "c. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Any Coins relating to a transaction which is cancelled",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Hotshoes reserves the right to deduct any such Coins as stated above without notifying the Player.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "8. Privacy Policy",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "We are under an obligation to protect the confidentiality, integrity and accessibility of your data, including personal data. Protecting personal data is essential to us, and we are continuously working on ensuring compliance with applicable data protection legislation, including the Personal Data Protection Act (“PDPA”).",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "As a data subject, you have certain rights pursuant to the PDPA. Your rights may be summarised as follows:",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right of access by the data subject. You have the right to gain access to the personal data concerning you that we process.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "b. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right to have incorrect personal data rectified. You have the right to have incorrect personal data about yourself rectified without undue delay.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "c. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right to have personal data erased. You have the right to have your personal data erased at an earlier point in time than when our ordinary erasure takes place, where appropriate.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "d. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right to restriction of data processing. You have the right to restrict our processing of your personal data, where appropriate. In such cases, we may only process your data with your consent or in some very specific situations as outlined in PDPA.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "e. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right to object to personal data processing. In such cases, we may only process your personal data if we are able to demonstrate compelling legitimate grounds for doing so.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "f. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The right to data portability. You have the right to receive your personal data in a structured, commonly used and machine-readable format. You may also request that we transmit your personal data to another data controller without hindrance.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "When we process personal data based on your consent, you have the right to withdraw your consent at any time. Please contact us to withdraw consent for our processing of your personal data.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "We acknowledge that transparency is an ongoing responsibility. Therefore, we will continually review and update this data protection policy in order to ensure our compliance with applicable personal data law from time to time.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Please contact us at info@onzlah.live if you would like to exercise your rights as described above, or if you have questions about our processing of your personal data or this data protection policy.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "If you wish to complain about our processing of personal data, please send an email with the details of your complaint to info@onzlah.live. We will handle your complaint and get back to you.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "9. Limitation of Liability and Release",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "The Player acknowledges and agrees that:",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "9.1. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The Program shall not be responsible to you for any loss, damage, fne, regulatory action, claim or compensation of whatever nature arising from or related to the Program (Liabilities”) including but not limited to (i) your breach of these Terms, (ii) any alleged unauthorised transactions, disruptions, errors, defects or unavailability of the Program. Or (iii) any loss of data or damage to any of your mobile equipment, to the fullest extent permitted by applicable law. In the event that any Liabilities are not excluded by the foregoing in this Clause 9.1, OnzLAH!’s, maximum aggregate liability to you in respect of such Liabilities, whether under all applicable laws of contract, tort or otherwise, shall be MYR100 (or the equivalent value of such amount in the currency of your jurisdiction), to the fullest extent permitted by applicable law.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "9.2 ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The Program does not make any warranty or representation or undertaking on the performance and capability of the Platform, the Program and/or any software or hardware the Program, or the reliability or quality of the underlying telecommunication network accessed by you using the Program.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "10. Governing Law",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "These Terms are governed by the law in force in Malaysia. All legal actions in connection with these Terms shall be bought in the state or federal courts located in Malaysia.",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "11. Miscellaneous",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "11.1 ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Hotshoes reserve the sole right to alter, modify, add to or otherwise vary these Terms from time to time, and in such manner as Hotshoes deems appropriate. In the event of variation of these Terms, if you continue to participate in the Program thereafter, you shall be bound by the Terms as so amended and shall be deemed to have accepted the Terms as so amended.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "11.2 ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "You may not use any technological or other means (such as by cheating or using bugs or glitches in the Program, or by using third party tools or software) to use the Program in a way that is not within the spirit of fair play or these Terms. You specifically agree that you will not",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "a. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Use the Program for fraudulent or abusive purposes (including, without limitation, by using the Program to impersonate any person or entity, or otherwise misrepresent our affiliation with a person, entity or our Program);",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "b. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Disguise, anonymize or hide your IP address or the source of any content that you may upload;",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "c. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Interfere with or disrupt the Program or serves or networks that provide the Program;",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "d. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Attempt to decompile, reverse engineer, disassemble or hack any of the Program, or to defeat or overcome any of the encryption technologies or security measures or data transmitted, processes or stored by us;",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "e. ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "Do anything else that is not within the spirit of fair play or the Terms.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "11.3 ",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            "The Program may contain links to third party websites or resources. We provide these links only as a convenience and are not responsible for the content, products, or services on or available from those websites or resources or links displayed on such websites. You acknowledge sole responsibility for and assume all risk arising from, your use of any third party websites or resources.",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Common.pink_dark_color,
                    ),
                    margin: const EdgeInsets.only(left: 70.0, right: 70, top: 20),
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "CLOSE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
