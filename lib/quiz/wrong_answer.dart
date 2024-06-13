import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/live.dart';

import 'model/answer.dart';
import 'model/live_page.dart';

class WrongAnswer extends StatefulWidget {
  final LiveEvent cur_event;
  final OnUseLivesClick callback;
  final int selID;
  final int usedLifeCount;
  final OnUserNoActionLockUser callBackLock;

  WrongAnswer(this.usedLifeCount, this.callBackLock, this.selID, this.cur_event, this.callback);

  @override
  State<StatefulWidget> createState() => WrongAnswerState();
}

class WrongAnswerState extends State<WrongAnswer> {
  void startTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) Navigator.pop(context);
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
      // margin: EdgeInsets.all(5.0),
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
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getQuestionAns(),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 20),
            //   child: Container(
            //     width: 50,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         color: Color(0xffFF0000), border: Border.all(color: Colors.black, width: 2)),
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Center(child: Icon(Icons.clear, size: 40)),
            //     ),
            //   ),
            // )
          ],
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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFFF4848),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  'Oh no, you got it wrong!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'MontserratBold', fontSize: 18.0),
                ),
              ],
            ),
            widget.usedLifeCount >= 3
                ? Container()
                : GestureDetector(
                    onTap: () {
                      widget.callback.call();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Click HERE to revive now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0,
                            color: Colors.white,
                            fontFamily: 'MontserratBold',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
    lst.add(SizedBox(height: 40));
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
              color: ans[i].status.trim().toLowerCase() == 'correct'
                  ? Common.green_blue_color
                  : widget.selID == ans[i].id
                      ? Color(0xFFFF4848)
                      : Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      String.fromCharCode(i + 65) + ".      ",
                      style: TextStyle(
                          color: ans[i].status.trim().toLowerCase() == 'correct'
                              ? Colors.white
                              : widget.selID == ans[i].id
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
                          color: ans[i].status.trim().toLowerCase() == 'correct'
                              ? Colors.white
                              : widget.selID == ans[i].id
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
                          color: ans[i].status.trim().toLowerCase() == 'correct'
                              ? Colors.white
                              : widget.selID == ans[i].id
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
    lst.add(SizedBox(height: 30));

    return lst;
  }
}
