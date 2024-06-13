import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';

class Congrats extends StatefulWidget {
  final String winCoins;

  Congrats(this.winCoins);

  @override
  State<StatefulWidget> createState() => CongratsState();
}

class CongratsState extends State<Congrats> {
  Timer _timer;

  void startTimer() {
    _timer = new Timer(const Duration(milliseconds: 10), () {
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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          // alignment: AlignmentDirectional.bottomCenter,
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height-100,
                  child: Image.asset(
                    'assets/img/congratulations-card.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Image.asset(
              'assets/img/gift-love.png',
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "CONGRATULATIONS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Common.pink_dark_color, fontSize: 32, fontFamily: 'MontserratBold'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Common.pink_dark_color,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  Text(
                    'You just win',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'MontserratBold', fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    numberFormatter(int.parse(widget.winCoins)) + ' COINS',
                    style: TextStyle(
                      color: Common.orange_color,
                      fontFamily: 'MontserratBold',
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
