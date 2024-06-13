import 'currentquestion.dart';
import 'currentuser.dart';
import 'event.dart';
import 'messages.dart';
import 'sticker.dart';

class LiveEvent {
  int stickercount;
  int usercount;
  CurrentUser currentuser;
  Event event;
  List<Sticker> sticker;
  CurrentQuestion currentquestion;
  String order;
  List<Message> lstMsg;
  bool firstTime;
  String status;

  LiveEvent({
    this.stickercount,
    this.currentuser,
    this.event,
    this.sticker,
    this.currentquestion,
    this.order,
    this.lstMsg,
    this.firstTime,
    this.status,
  });

  factory LiveEvent.fromJson(Map<String, dynamic> json) {
    return LiveEvent(
      order: json['order'] != null ? json['order'] : '0',
      stickercount: json['stickercount'] == null ? 0 : json['stickercount'],
      currentuser: CurrentUser.fromJson(json['currentuser']),
      event: json['event'] == null ? Event() : Event.fromJson(json['event']),
      sticker: Sticker.getList(json),
      currentquestion: json['currentquestion'] == null
          ? null
          : CurrentQuestion.fromJson(json['currentquestion']),
      lstMsg: Message.getList(json),
      firstTime: json['firsttime'] == null ? false : json['firsttime'],
      status: json['status'] != null ? json['status'] : 'disabled',
    );
  }
}
