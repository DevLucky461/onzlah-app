import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/live.dart';
import 'package:onzlah_app/quiz/model/live_page.dart';

class UseLiveYN extends StatefulWidget {
  final LiveEvent cur_event;
  final OnUseLivesUseClick callback;
  final int usedLifeCount;

  UseLiveYN(this.usedLifeCount, this.cur_event, this.callback);

  @override
  State<StatefulWidget> createState() => UseLiveYNState();
}

class UseLiveYNState extends State<UseLiveYN> {
  Timer _timer;

  void startTimer() {
    _timer = new Timer(const Duration(seconds: 10), () {
      widget.callback.call(true);
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
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Common.orange_color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getQuestionAns(),
          ),
        ),
      ),
    );
  }

  getQuestionAns() {
    List<Widget> lst = [];

    lst.add(SizedBox(height: 30));
    lst.add(Container(
      width: MediaQuery.of(context).size.width - 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/img/lifes.png',
                height: 20,
                width: 20,
              ),
              SizedBox(width: 10),
              Text(
                widget.cur_event.currentuser.life.toString(),
                style: TextStyle(color: Colors.black, fontFamily: 'MontserratBold', fontSize: 18.0),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(children: get3rOW())),
              SizedBox(width: 10),
              Text(
                widget.usedLifeCount.toString() + '/3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'MontserratBold',
                    fontSize: 15.0),
              )
            ],
          ),
        ],
      ),
    ));
    lst.add(SizedBox(height: 30));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          'To continue the quiz after you answered wrong, you can revive maximum 3 times in a round using your Life.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'MontserratRegular',
              fontSize: 16.0),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 100,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: const <TextSpan>[
              TextSpan(
                text: 'Do you want to use ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'MontserratBold',
                    fontSize: 17.0),
              ),
              TextSpan(
                text: '1 Life ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Common.pink_dark_color,
                    fontFamily: 'MontserratBold',
                    fontSize: 17.0),
              ),
              TextSpan(
                text: 'to revive your journey?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'MontserratBold',
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    lst.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.callback.call(true);
            },
            child: Container(
              width: 60,
              height: 60,
              // padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Common.green_blue_color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child: Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              )),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              widget.callback.call(false);
            },
            child: Container(
              width: 60,
              height: 60,
              // padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(child: Icon(Icons.clear, size: 40)),
            ),
          ),
        ],
      ),
    );
    lst.add(SizedBox(height: 20));

    return lst;
  }

  get3rOW() {
    List<Widget> lst = [];
    for (int i = 0; i < 3; i++) {
      lst.add(
        Container(
          width: 25,
          height: 18,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: getColor(i, widget.usedLifeCount),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SizedBox(
              width: 50,
              height: 20,
            ),
          ),
        ),
      );
    }

    return lst;
  }
}
