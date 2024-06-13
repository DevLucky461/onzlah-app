import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';

class GameOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      child: Image.asset(
                        'assets/img/livestream/loser_splash.png',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      ),
                    )),
              ],
            ),
            Positioned(
              top: 30,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.clear,
                        size: 25,
                      )),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/img/livestream/loser-balloon.png',
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'GAME OVER',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Common.pink_dark_color, fontSize: 44, fontFamily: 'MontserratBold'),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                "Sorry, You didn't get the question correct. Please try again next time!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Common.pink_dark_color, fontFamily: 'MontserratBold', fontSize: 17.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
