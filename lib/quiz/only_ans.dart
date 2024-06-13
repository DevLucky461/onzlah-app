import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/quiz/model/answer.dart';
import 'package:onzlah_app/quiz/model/live_page.dart';

class OnlyAnswer extends StatefulWidget {
  final LiveEvent cur_event;

  OnlyAnswer(this.cur_event);

  @override
  State<StatefulWidget> createState() => OnlyAnswerState();
}

class OnlyAnswerState extends State<OnlyAnswer> {
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color(0xffFFEF41), border: Border.all(color: Color(0xff7624FF), width: 1)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
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
    List<Answer> ans = [];
    ans.addAll(widget.cur_event.currentquestion.answer);

    lst.add(SizedBox(height: 80));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          'Sorry! You are disqualified from the current quiz. Stay on with us until the end of the live, and check out the hints for our next live session!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontFamily: 'NunitoSansSemiBold', fontSize: 18.0),
        ),
      ),
    );
    lst.add(SizedBox(height: 10));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          'Question ' + widget.cur_event.order + '/8',
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black87, fontFamily: 'MontserratBold', fontSize: 17.0),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          widget.cur_event.currentquestion.question,
          style: TextStyle(color: Colors.black, fontFamily: 'MontserratBold', fontSize: 19.0),
        ),
      ),
    );
    lst.add(SizedBox(height: 15));
    for (int i = 0; i < ans.length; i++) {
      lst.add(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 80,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: ans[i].status.toLowerCase().trim() == 'correct'
                    ? Color(0xff00FE45)
                    : Colors.white,
                border: Border.all(color: Colors.black, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      String.fromCharCode(i + 65) + ".      ",
                      style: TextStyle(
                          color: Colors.black54, fontFamily: 'MontserratBold', fontSize: 17.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ans[i].answer,
                      style: TextStyle(
                          color: Colors.black54, fontFamily: 'MontserratBold', fontSize: 17.0),
                    ),
                  ),
                  Container(
                    width: 45,
                    child: Text(
                      ans[i].percent,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.black54, fontFamily: 'MontserratBold', fontSize: 17.0),
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
