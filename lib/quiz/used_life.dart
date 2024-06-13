import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:onzlah_app/quiz/model/live_page.dart';

class UsedLife extends StatefulWidget {
  final LiveEvent cur_event;
  final int usedLifeCount;

  UsedLife(this.cur_event, this.usedLifeCount);

  @override
  State<StatefulWidget> createState() => UsedLifeState();
}

class UsedLifeState extends State<UsedLife> {
  void startTimer() {
    Future.delayed(const Duration(seconds: 5), () {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Common.orange_color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getQuestionAns(),
          ),
        ),
      ],
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
                style: TextStyle(color: Colors.black, fontFamily: 'MontserratBold', fontSize: 19.0),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xff00B0FF),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(children: get3rOW())),
              SizedBox(width: 10),
              Text(
                widget.usedLifeCount.toString() + '/3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'MontserratBold',
                    fontSize: 16.0),
              )
            ],
          ),
        ],
      ),
    ));
    lst.add(SizedBox(height: 50));
    lst.add(
      Container(
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          'You have been respawned',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'MontserratRegular',
            fontSize: 15.0,
          ),
        ),
      ),
    );
    lst.add(SizedBox(height: 70));

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
              border: Border.all(color: Colors.black, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SizedBox(width: 50, height: 20),
          ),
        ),
      );
    }

    return lst;
  }
}
