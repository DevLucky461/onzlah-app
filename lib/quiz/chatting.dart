import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/quiz/model/messages.dart';

class Chatting extends StatefulWidget {
  final Key key;
  final List<Message> chat;
  final int user_id;

  Chatting(this.key, this.chat, this.user_id);

  @override
  State<StatefulWidget> createState() => ChattingState(chat);
}

class ChattingState extends State<Chatting> {
  ScrollController lstController = ScrollController();
  List<Message> chat;

  int selectedUserId = -1;
  String selectedUser;

  ChattingState(this.chat);

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      () {
        try {
          lstController.jumpTo(lstController.position.maxScrollExtent);
        } catch (e) {
          //print(e);
        }
      },
    );
    return Column(
      children: [
        Container(
          height: 170,
          margin: EdgeInsets.all(2),
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: ListView.separated(
              controller: lstController,
              separatorBuilder: (context, index) {
                return Container(
                  height: 8,
                );
              },
              shrinkWrap: true,
              itemCount: chat.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (chat[index].user_id == widget.user_id) {
                      if (selectedUserId != -1)
                        setState(() {
                          selectedUserId = -1;
                          selectedUser = null;
                        });
                    } else {
                      if (selectedUserId != chat[index].user_id)
                        setState(() {
                          selectedUserId = chat[index].user_id;
                          selectedUser = chat[index].name;
                        });
                      else
                        setState(() {
                          selectedUserId = -1;
                          selectedUser = null;
                        });
                    }
                  },
                  child: Text(
                    (chat[index].user_id == widget.user_id ? "You" : chat[index].name) +
                        ": " +
                        chat[index].message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontFamily: 'NunitoSansSemiBold',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(3),
          child: selectedUser != null
              ? Text("Reply to " + selectedUser,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15.0,
                    fontFamily: 'NunitoSansSemiBold',
                    fontStyle: FontStyle.italic,
                  ))
              : SizedBox(),
        ),
      ],
    );
  }

  void updateChat(List<Message> lstmsg) {
    chat.clear();
    chat.addAll(lstmsg);
    setState(() {
      // chat = [...chat, message];
      // lstController.jumpTo(lstController.position.maxScrollExtent);
    });
    // print('chat length' + chat.length.toString());
  }
}
