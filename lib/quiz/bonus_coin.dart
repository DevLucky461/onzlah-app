import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';

class BonusCoin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BonusCoinState();
}

class BonusCoinState extends State<BonusCoin> {
  Timer _timer;

  void startTimer() {
    _timer = new Timer(const Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'CONGRATULATIONS',
              style: TextStyle(
                color: Common.pink_dark_color,
                fontFamily: 'MontserratExtraBold',
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You got everything correct!",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MontserratBold',
                      color: Common.pink_dark_color,
                    ),
                  ),
                  // TextSpan(
                  //   text: "500 COINS",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontFamily: 'NunitoSansExtraBold',
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // TextSpan(
                  //   text: " today for logging into our LIVE",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontFamily: 'NunitoSansBold',
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: getScreenWidth(context) - 40,
              padding: EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: Common.pink_dark_color,
              ),
              child: Column(
                children: [
                  Text(
                    "You just won",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MontserratBold',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '100,000 COINS',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'MontserratBold',
                      color: Common.orange_color,
                    ),
                  )
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       intCardNo = Common.Share;
            //     });
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.black87,
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     padding: EdgeInsets.all(10),
            //     child: Image.asset(
            //       'assets/img/livestream/arrow_right.png',
            //       height: 35,
            //       width: 35,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // TextButton(
            //   child: Container(
            //     width: double.infinity,
            //     padding: EdgeInsets.all(9.0),
            //     decoration: BoxDecoration(
            //       color: Colors.yellow,
            //       border: Border.all(
            //         color: Colors.black,
            //         width: 4.0,
            //       ),
            //     ),
            //     child: Text(
            //       'OKAY',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 24,
            //         fontFamily: 'MontserratExtraBold',
            //         color: Colors.black87,
            //       ),
            //     ),
            //   ),
            //   onPressed: () => Navigator.pop(context),
            // ),
          ],
        ),
      ),
    );
  }
}
