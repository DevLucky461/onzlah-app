import 'dart:async';
import 'dart:convert';
import 'dart:math';

// import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/quiz/model/currentquestion.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';
import 'home.dart';
import 'quiz/bonus_coin.dart';
import 'quiz/chatting.dart';
import 'quiz/congrats.dart';
import 'quiz/game_over.dart';
import 'quiz/gift_page.dart';
import 'quiz/model/chat_msg.dart';
import 'quiz/model/live_page.dart';
import 'quiz/model/messages.dart';
import 'quiz/model/sticker.dart';
import 'quiz/model/winner.dart';
import 'quiz/only_ans.dart';
import 'quiz/only_question.dart';
import 'quiz/quiz_page.dart';
import 'quiz/right_answer.dart';
import 'quiz/share_page.dart';
import 'quiz/use_live_yes_no.dart';
import 'quiz/used_life.dart';
import 'quiz/user_count.dart';
import 'quiz/wrong_answer.dart';

class Live extends StatefulWidget {
  static bool ConnectedToQuiz = false;

  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live>
    with TickerProviderStateMixin /*, AutomaticKeepAliveClientMixin<Live>*/ {
  final logout = Logout();
  List<Message> chat = [];
  TextEditingController _chatController = TextEditingController();
  GlobalKey<ChattingState> _chatState = new GlobalKey<ChattingState>();
  GlobalKey<GiftState> _giftState = new GlobalKey<GiftState>();

  bool isJoined = false;
  bool optionClick = false;

  bool showSticker = true;
  int intCardNo = 0;

  final int giftPosCount = 8;
  final int giftPosLines = 4;

  List<AnimationController> controllers = [];
  List<Animation<Offset>> offset = [];

  List<List<String>> lstImage = [];

  // VideoPlayerController _videoPlayerController;
  BetterPlayerController _betterPlayerController;

  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    initGifts();
    initController();

    post = getData();

    super.initState();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Common.VideoLink,
      liveStream: true,
    );
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            aspectRatio: 9 / 16,
            autoPlay: true,
            looping: true,
            fullScreenByDefault: false,
            fit: BoxFit.cover,
            autoDispose: true,
            showPlaceholderUntilPlay: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                enableFullscreen: false,
                enableMute: false,
                enableProgressText: false,
                enableProgressBar: false,
                enableProgressBarDrag: false,
                enablePlayPause: false,
                enableSkips: false,
                enablePlaybackSpeed: false,
                enableSubtitles: false,
                enableQualities: false,
                enablePip: false,
                enableRetry: false,
                enableAudioTracks: false,
                showControls: false,
                showControlsOnInitialize: false)),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  void dispose() {
    // if (_videoPlayerController != null) _videoPlayerController.dispose();
    if (_betterPlayerController != null) _betterPlayerController.dispose();
    if (socket != null) {
      socket.clearListeners();
      socket.dispose();
    }

    controllers.forEach((element) => element.dispose());

    super.dispose();
  }

  initializePlayer() {
    // _videoPlayerController = VideoPlayerController.network(Common.VideoLink)
    //   ..initialize().then((_) {
    //     setState(() {
    //       _videoPlayerController.play();
    //     });
    //   });
    // _videoPlayerController.setLooping(true);
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   Common.VideoLink,
    //   liveStream: true,
    // );
    // _betterPlayerController = BetterPlayerController(
    //     BetterPlayerConfiguration(
    //         autoPlay: true,
    //         looping: true,
    //         fullScreenByDefault: false,
    //         fit: BoxFit.fitWidth,
    //         autoDispose: true),
    //     betterPlayerDataSource: betterPlayerDataSource);
  }

  void initController() {
    controllers.clear();
    for (int i = 0; i < giftPosCount * giftPosLines; i++) {
      controllers.add(AnimationController(vsync: this, duration: Duration(seconds: 4)));
      controllers[i].reverseDuration = Duration(microseconds: 1);
      offset.add(Tween<Offset>(
        begin: Offset.zero,
        end: Offset(0.0, -40),
      ).animate(controllers[i]));

      controllers[i].addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          controllers[i].reverse();
        }
      });
    }
  }

  sendMessage(String msg) async {
    var data = {
      'message': msg,
      'video_id': cur_event.event.id,
    };

    var res = await CallApi().postData(data, 'send-message');
    var body = json.decode(res.body);
    print(body);
  }

  Socket socket;

  void init() {
    print('init called...');
    initializePlayer();
    if (socket != null) {
      print('Socket not null');
    }
    try {
      // Dart client
      socket = io(
          Common.socketUrl,
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .build());
      socket.connect();

      socket.on('receivecount', (count) {
        print('receivecount: ' + count.toString());
        setState(() {
          cur_event.usercount = count;
        });
      });

      socket.on('receive-sticker', (data) {
        print('receive-sticker: ' + data.toString());
        setState(() {
          cur_event.stickercount = cur_event.stickercount + 1;
        });
        start(data['img_link']);
      });

      socket.on('user enter the chat', (username) {
        print('user enter the chat: ' + username.toString());
        if (username.toString().contains(" and other "))
          showMsg(username.toString() + " have entered the chat");
        else
          showMsg(username.toString() + " has entered the chat");
      });

      socket.on('user-disconnects', (username) {
        print('user-disconnects: ' + username.toString());
        if (username.toString().contains(" and other "))
          showMsg(username.toString() + " have left the chat");
        else
          showMsg(username.toString() + " has left the chat");
      });

      socket.on('pop-quiz', (username) {
        print('pop-quiz: ' + username.toString());
        if (Home.PageIndex != 1) {
          return;
        }
        getQuestion();
      });

      socket.on('pop-result', (question_id) {
        print('pop-result: ' + question_id.toString());
        if (Home.PageIndex != 1) {
          return;
        }

        getScorePercentage(question_id.toString());
      });

      socket.on('pop-scoreboard-mobile', (data) {
        print('pop-scoreboard-mobile: ' + data.toString());
        if (Home.PageIndex != 1) {
          return;
        }
        Winner winner = Winner.fromJson(json.decode(data));
        bool foundAsWinner = false;

        for (int i = 0; i < winner.user_id.length; i++) {
          if (winner.user_id[i] == cur_event.currentuser.id) {
            foundAsWinner = true;
            break;
          }
        }

        if (foundAsWinner) {
          cur_event.currentuser.coins = cur_event.currentuser.coins + int.parse(winner.prize_money);
          setState(() {});
          showCongratsDialog(false, winner.prize_money);
        } else {
          showCongratsDialog(true, '0');
        }
      });

      socket.onConnect((_) {
        var send = [
          cur_event.currentuser.id,
          cur_event.event.id,
          cur_event.currentuser.name,
          'user',
          'mobile'
        ];
        socket.emit('user_connected', send);
      });

      // socket.on('messages', (jsonData) async {
      //   print('messages data' + jsonData);
      // });

      socket.on('mobile_messages', (data) {
        print('mobile_messages: ' + data);
        ChatMsg msg = ChatMsg.fromJson(json.decode(data));
        setState(() {
          cur_event.lstMsg.add(Message(
              user_id: msg.user_id,
              message: msg.message,
              name: msg.sender_name,
              video_id: msg.video_id));
        });
        _chatState.currentState.updateChat(cur_event.lstMsg);
      });

      socket.onDisconnect((_) => print('Socket disconnect'));
    } catch (e) {
      //print(e);
    }
  }

  getScorePercentage(String question_id) async {
    var data = {
      'question_id': question_id,
    };

    var res = await CallApi().postData(data, 'get-score-percentage');
    var body = json.decode(res.body);
    for (int i = 0; i < cur_event.currentquestion.answer.length; i++)
      cur_event.currentquestion.answer[i].percent = body['percentage'][i];
    if (!Live.ConnectedToQuiz || jsonDataLastQuest == null || cur_event.status == 'disabled') {
      showOnlyAns();
    } else {
      if (jsonDataLastQuest['stats'] != null) {
        if (jsonDataLastQuest['stats'].toString().toLowerCase().trim() == 'correct') {
          showRightAns();
        } else {
          showWrongAns(selID, jsonDataLastQuest['used_life']);
        }
      } else {
        showWrongAns(selID, jsonDataLastQuest['used_life']);
      }
    }
  }

  LiveEvent cur_event;

  double deltaX = 0.0;

  _horizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      deltaX = deltaX + details.delta.dx;
    });
  }

  void _horizontalDragEnd(DragEndDetails details) {
    setState(() {
      deltaX = -deltaX > (MediaQuery.of(context).size.width - 80) / 2
          ? -MediaQuery.of(context).size.width + 80
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          cur_event = snapshot.data;

          if (chat.isEmpty) chat.addAll(cur_event.lstMsg);
          if (Common.liveEnabled && isJoined && cur_event.firstTime) {
            cur_event.firstTime = false;
            showFirstTime();
          }

          return (Common.liveEnabled
              ? (isJoined
                  ? Container(
                      color: Colors.black87,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          // _videoPlayerController.value.isInitialized
                          // _betterPlayerController.isVideoInitialized()
                          //     ?
                          // SizedBox.expand(
                          // child: SizedBox(
                          //       width: _videoPlayerController
                          //               .value.size?.width ??
                          //           0,
                          //       height: _videoPlayerController
                          //               .value.size?.height ??
                          //           0,
                          //       child:
                          //           VideoPlayer(_videoPlayerController),
                          //     ),
                          // )
                          // : Center(
                          //     child: CircularProgressIndicator(
                          //         valueColor: AlwaysStoppedAnimation(
                          //             Common.AppColor))),

                          Container(
                            child: BetterPlayer(
                              controller: _betterPlayerController,
                            ),
                          ),
                          Positioned(
                            child: UserCount(cur_event),
                            top: 20,
                            left: 15,
                          ),
                          Visibility(
                            visible: !optionClick,
                            child: Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    optionClick = true;
                                    intCardNo = Common.Gift;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/img/livestream/giftbox.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ),
                              bottom: 15,
                              right: 5,
                            ),
                          ),
                          Visibility(
                            visible: !optionClick,
                            child: Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    optionClick = true;
                                    intCardNo = Common.Share;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/img/livestream/arrow_right.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ),
                              bottom: 90,
                              right: 5,
                            ),
                          ),
                          Visibility(
                            visible: !optionClick,
                            child: Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    optionClick = true;
                                    intCardNo = Common.Setting;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/img/livestream/ellipses.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ),
                              bottom: 165,
                              right: 5,
                            ),
                          ),
                          GestureDetector(
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 10,
                                  left: 5,
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 80,
                                      height: 250,
                                      child: Text('')),
                                ),
                                Visibility(
                                  visible: !optionClick,
                                  child: Positioned(
                                    bottom: 10,
                                    left: deltaX < 0 ? 5 + deltaX : 5,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 80,
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Chatting(
                                            _chatState,
                                            chat,
                                            cur_event.currentuser.id,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width:
                                                    (MediaQuery.of(context).size.width - 80) - 110,
                                                child: TextField(
                                                  controller: _chatController,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: 'Say Something',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFFAAAAAA),
                                                      fontFamily: 'MontserratRegular',
                                                      fontSize: 14.0,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  if (_chatController.text.trim().isEmpty) {
                                                    return;
                                                  }
                                                  if (_chatState.currentState.selectedUser == null)
                                                    sendMessage(_chatController.text.trim());
                                                  else {
                                                    sendMessage('@' +
                                                        _chatState.currentState.selectedUser +
                                                        ' ' +
                                                        _chatController.text.trim());
                                                    _chatState.currentState.selectedUser = null;
                                                    _chatState.currentState.selectedUserId = -1;
                                                  }

                                                  _chatController.text = "";
                                                  FocusScope.of(context).unfocus();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(40),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.centerLeft,
                                                      end: Alignment.centerRight,
                                                      colors: [
                                                        Common.orange_color,
                                                        Common.pink_light_color
                                                      ],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'SEND',
                                                      style: TextStyle(
                                                        color: Common.pink_dark_color,
                                                        fontFamily: 'MontserratBold',
                                                        fontSize: 19.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onHorizontalDragUpdate: (details) => _horizontalDragUpdate(details),
                            onHorizontalDragEnd: (details) => _horizontalDragEnd(details),
                          ),
                          Visibility(
                            visible: optionClick && intCardNo == Common.Share,
                            child: Positioned(
                              bottom: 0,
                              child: Share(cur_event.currentuser.referral, (bool opt) {
                                setState(() {
                                  optionClick = opt;
                                });
                              }),
                            ),
                          ),
                          Visibility(
                            visible: optionClick && intCardNo == Common.Gift,
                            child: Positioned(
                              bottom: 0,
                              child: Gift(_giftState, cur_event.event.id, cur_event.sticker,
                                  cur_event.currentuser.coins, (bool opt) {
                                setState(() {
                                  optionClick = opt;
                                });
                              }, (Sticker sticker, int coins) {
                                setState(() {
                                  cur_event.currentuser.coins = coins;
                                });
                                sendStickerSocket(sticker);
                              }),
                            ),
                          ),
                          Visibility(
                            visible: optionClick && intCardNo == Common.Setting,
                            child: Positioned(
                              bottom: 0,
                              child: Container(
                                height: 160,
                                color: Colors.black87,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Options',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontFamily: 'MontserratBold',
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showSticker = !showSticker;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Stack(
                                                  alignment: AlignmentDirectional.center,
                                                  children: [
                                                    Icon(Icons.crop_square_sharp,
                                                        color: Colors.white, size: 30),
                                                    !showSticker
                                                        ? Icon(Icons.done,
                                                            size: 25, color: Color(0xffFF4DC2))
                                                        : Container(),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Disable Sticker Effect',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                      fontFamily: 'MontserratBold',
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width - 20,
                                              height: 1,
                                              color: Colors.white70),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text('Your Lives: ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0,
                                                    fontFamily: 'MontserratBold',
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Image.asset(
                                                'assets/img/lifes.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(cur_event.currentuser.life.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0,
                                                    fontFamily: 'MontserratBold',
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            optionClick = false;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.clear,
                                                size: 20,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Stack(children: buildGifts()),
                        ],
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        color: Common.AppColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 6,
                          // ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/img/livestream/live-logo.png',
                                  height: 120,
                                ),
                                SizedBox(height: 100),
                                Text(
                                  'LIVE is ongoing now!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'MontserratBold',
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    init();
                                    setState(() {
                                      isJoined = true;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [Common.orange_color, Common.pink_light_color]),
                                    ),
                                    margin:
                                        const EdgeInsets.only(left: 40.0, right: 40, bottom: 50),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'CLICK TO JOIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'MontserratBold',
                                        color: Common.AppColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              : Container(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Our Live is not available now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Please come back at 12:00PM later!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
        } else {
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Common.AppColor)),
          );
        }
      },
    );
  }

  Sticker sticker;
  Future<LiveEvent> post;

  Future<LiveEvent> getData() async {
    var data;
    var res = await CallApi().postData(data, 'live-init');
    if (res.body.toString().contains('Token has expired')) {
      logout.run(context);
    } else {
      var body = json.decode(res.body);

      LiveEvent event = LiveEvent.fromJson(body);

      return event;
    }
  }

  // void hideChatPart() {
  //   setState(() {
  //     showChat = false;
  //   });
  // }
  //
  // void showChatPart() {
  //   setState(() {
  //     showChat = true;
  //   });
  // }

  void sendStickerSocket(Sticker sticker) {
    var send = {
      'img_link': sticker.src,
      'stickcount': 1,
      'username': cur_event.currentuser.name,
      'stickername': sticker.sticker_name
    };

    print('data for send sticker' + send.toString());

    socket.emit('send-sticker', send);
  }

  getQuestion() async {
    var data = {
      'event_id': cur_event.event.id,
    };
    var res = await CallApi().postData(data, 'get-quiz-state');
    if (res.body.toString().contains('Token has expired')) {
      logout.run(context);
    } else {
      var body = json.decode(res.body);
      if (body['question'] != null) {
        CurrentQuestion ques = CurrentQuestion.fromJson(body['question']);
        int currenttime = body['currenttime'];
        cur_event.currentquestion = ques;
        cur_event.order = body['order'];
        cur_event.status = body['status'];
        if (body['order'] == '1') {
          Live.ConnectedToQuiz = true;
        }
        showQuestionDialog(currenttime);
      }
    }
  }

  showUseLives(int usedLifeCount) {
    print('showUseLives: ' + usedLifeCount.toString());
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
            // makes widget fullscreen
            child: Scaffold(
          backgroundColor: Colors.black26,
          body: UseLiveYN(usedLifeCount, cur_event, (bool used) {
            Navigator.pop(context);
            if (used) {
              callUserLife();
            } else {
              setState(() {
                Live.ConnectedToQuiz = false;
              });
            }
          }),
        ));
      },
    );
  }

  showFirstTime() {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Scaffold(
          backgroundColor: Colors.black26,
          body: BonusCoin(),
        );
      },
    );
  }

  showWrongAns(int selID, int usedLifeCount) {
    print('showWrongAns: ' + usedLifeCount.toString());
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
          // makes widget fullscreen
          child: Scaffold(
            backgroundColor: Colors.black26,
            body: WrongAnswer(
              usedLifeCount,
              () {
                Navigator.pop(context);
                setState(() {
                  Live.ConnectedToQuiz = false;
                });
              },
              selID,
              cur_event,
              () {
                Navigator.pop(context);
                showUseLives(usedLifeCount);
              },
            ),
          ),
        );
      },
    );
  }

  showRightAns() {
    print('showRightAns: ' + cur_event.currentquestion.question);
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
            // makes widget fullscreen
            child: Scaffold(
          backgroundColor: Colors.black26,
          body: RightAnswer(cur_event),
        ));
      },
    );
  }

  showOnlyAns() {
    print('showOnlyAns: ' + cur_event.currentquestion.question);
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
            // makes widget fullscreen
            child: Scaffold(
          backgroundColor: Colors.black26,
          body: OnlyAnswer(cur_event),
        ));
      },
    );
  }

  showUsedDialog(int usedLifeCount) {
    print('showUsedDialog: ' + usedLifeCount.toString());
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
          // makes widget fullscreen
          child: Scaffold(
            backgroundColor: Colors.black26,
            body: UsedLife(cur_event, usedLifeCount),
          ),
        );
      },
    );
  }

  var jsonDataLastQuest;
  int selID = 0;

  void callAPIUpdateScore(int selID) async {
    this.selID = selID;
    var data = {
      'event_id': cur_event.event.id,
      'answer_id': selID == -1 ? null : selID,
      'question_id': cur_event.currentquestion.id,
    };
    var res = await CallApi().postData(data, 'score-update');
    if (res.body.toString().contains('Token has expired')) {
      logout.run(context);
    } else {
      jsonDataLastQuest = json.decode(res.body);
      int life = jsonDataLastQuest['life'];
      setState(() {
        cur_event.currentuser.life = life;
      });
    }
  }

  void showQuestionDialog(int currenttime) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6),
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
            // makes widget fullscreen
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: cur_event.status == "pass"
              ? QuestionQuiz(
                  cur_event,
                  currenttime,
                  (int selId) {
                    Navigator.pop(context);
                    print("QuestionQuiz: " + Live.ConnectedToQuiz.toString());
                    if (!Live.ConnectedToQuiz) {
                      return;
                    }
                    callAPIUpdateScore(selId);
                  },
                )
              : OnlyQuestion(cur_event, currenttime),
        ));
      },
    );
  }

  void callUserLife() async {
    var data = {
      'event_id': cur_event.event.id,
    };
    var res = await CallApi().postData(data, 'use-life');
    if (res.body.toString().contains('Token has expired')) {
      logout.run(context);
    } else {
      var jsonData = json.decode(res.body);
      if (null != jsonData['success'] && jsonData['success'].toString() == 'true') {
        cur_event.currentuser.life = jsonData['remaining_life'];
        showUsedDialog(jsonData['used_life']);
      } else {
        setState(() {
          Live.ConnectedToQuiz = false;
        });
      }
    }
  }

  void showCongratsDialog(bool loose, String winCoins) {
    if (!mounted) return;
    showGeneralDialog(
      context: context,
      // barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 200),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
          // makes widget fullscreen
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: loose ? GameOver() : Congrats(winCoins),
          ),
        );
      },
    );
  }

  buildGifts() {
    List<Widget> lst = [];
    for (int i = 0; i < giftPosLines; i++)
      for (int j = 0; j < giftPosCount; j++)
        lst.add(
          Positioned(
            bottom: -70,
            right: 5.0 + giftPosLines % 5 + 80 / giftPosCount * j,
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
              child: SlideTransition(
                position: offset[i * giftPosCount + j],
                child: Image.network(
                  lstImage[i][j],
                  height: 20.0,
                  width: 20.0,
                ),
              ),
            ),
          ),
        );

    return lst;
  }

  Random random = new Random();

  void start(String imgUrl) {
    if (!showSticker) {
      return;
    }
    int i;
    int j = 0;
    do {
      i = random.nextInt(giftPosCount * giftPosLines);
      j++;
    } while (controllers[i].status != AnimationStatus.dismissed && j < giftPosCount * giftPosLines);
    if (controllers[i].status != AnimationStatus.dismissed) return;
    if (!imgUrl.contains('http')) imgUrl = Common.BaseUrl + imgUrl;

    int line = (i / giftPosCount).floor();
    lstImage[line][i % giftPosCount] = imgUrl;

    controllers[i].forward();
  }

  void initGifts() {
    lstImage.clear();
    List<String> list = [];
    for (int i = 0; i < giftPosCount; i++) list.add('');
    for (int i = 0; i < giftPosLines; i++) lstImage.add(list);
  }
}

typedef OnCloseCall(bool opt);

typedef OnStickerSend(Sticker sticker, int coin);

typedef OnTimeUp(int selId);

typedef OnUseLivesClick();

typedef OnUseLivesUseClick(bool used);

typedef OnUserNoActionLockUser();
