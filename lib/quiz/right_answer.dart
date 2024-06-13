import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/quiz/model/answer.dart';
import 'package:onzlah_app/quiz/model/live_page.dart';

class RightAnswer extends StatefulWidget {
  final LiveEvent cur_event;

  RightAnswer(this.cur_event);

  @override
  State<StatefulWidget> createState() => RightAnswerState();
}

class RightAnswerState extends State<RightAnswer> {
  void startTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: MediaQuery.of(context).size.width,
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
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 1.5,
                margin: EdgeInsets.only(top: 50),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getQuestionAns(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getQuestionAns() {
    List<Widget> lst = [];
    List<Answer> ans = [];
    ans.addAll(widget.cur_event.currentquestion.answer);

    lst.add(SizedBox(height: 40));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Common.green_blue_color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
            Text(
              ' Yes, you got it right!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'MontserratBold',
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
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
            fontSize: 18.0,
          ),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    for (int i = 0; i < ans.length; i++) {
      lst.add(
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 80,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ans[i].status.toLowerCase().trim() == 'correct'
                  ? Common.green_blue_color
                  : Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      String.fromCharCode(i + 65) + ".      ",
                      style: TextStyle(
                          color: ans[i].status.toLowerCase().trim() == 'correct'
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'MontserratRegular',
                          fontSize: 16.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ans[i].answer,
                      style: TextStyle(
                          color: ans[i].status.toLowerCase().trim() == 'correct'
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'MontserratRegular',
                          fontSize: 16.0),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      ans[i].percent,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: ans[i].status.toLowerCase().trim() == 'correct'
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'MontserratRegular',
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    lst.add(SizedBox(height: 50));

    return lst;
  }
}
