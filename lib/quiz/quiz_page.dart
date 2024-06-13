import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/live.dart';
import 'package:onzlah_app/quiz/model/answer.dart';

import 'model/live_page.dart';

class QuestionQuiz extends StatefulWidget {
  final LiveEvent cur_event;
  final int currenttime;
  final OnTimeUp callTimeUp;

  QuestionQuiz(this.cur_event, this.currenttime, this.callTimeUp);

  @override
  State<StatefulWidget> createState() => QuestionQuizState();
}

class QuestionQuizState extends State<QuestionQuiz> {
  int endTime;
  int ansID = -1;
  int intSelIndex = -1;
  CountdownTimerController controller;

  void startTimer() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (widget.currenttime + 2);
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    widget.callTimeUp.call(ansID);
  }

  @override
  void dispose() {
    controller.dispose();
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Common.pink_dark_color,
            Common.orange_color,
          ],
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getQuestionAns(),
        ),
      ),
    );
  }

  getQuestionAns() {
    List<Widget> lst = [];
    List<Answer> ans = [];
    ans.addAll(widget.cur_event.currentquestion.answer);

    lst.add(SizedBox(height: 80));
    lst.add(Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 100,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CountdownTimer(
            controller: controller,
            endTime: endTime,
            onEnd: onEnd,
            widgetBuilder: (context, time) {
              if (time == null) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer,
                      color: Common.orange_color,
                    ),
                    Text(
                      " 00",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'MontserratBold', fontSize: 18.0),
                    ),
                  ],
                );
              } else {
                return Text(
                  (time.sec.toString().length == 1
                      ? ("0" + time.sec.toString())
                      : time.sec.toString()),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'MontserratBold', fontSize: 18.0),
                );
              }
            },
            textStyle: TextStyle(color: Colors.black, fontFamily: 'MontserratBold', fontSize: 19.0),
          ),
        ),
      ),
    ));
    lst.add(SizedBox(height: 30));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          'Question ' + widget.cur_event.order + '/8',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Common.orange_color,
            fontFamily: 'MontserratBold',
            fontSize: 16.0,
          ),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          widget.cur_event.currentquestion.question,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'MontserratBold',
            fontSize: 20.0,
          ),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    for (int i = 0; i < ans.length; i++) {
      lst.add(
        GestureDetector(
          onTap: () {
            if (!Live.ConnectedToQuiz) {
              return;
            }
            setState(() {
              ansID = ans[i].id;
              //print('User selected :'+ansID.toString());
              intSelIndex = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: intSelIndex == i
                    ? Common.AppColor
                    : (!Live.ConnectedToQuiz ? Colors.grey[300] : Colors.white),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        String.fromCharCode(i + 65) + ".      ",
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'MontserratRegular', fontSize: 20.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ans[i].answer,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'MontserratRegular', fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return lst;
  }
}
