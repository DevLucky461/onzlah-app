class ChatMsg {
  int user_id;
  String sender_name;
  String message;
  int video_id;

  ChatMsg({
    this.user_id,
    this.sender_name,
    this.message,
    this.video_id,
  });

  factory ChatMsg.fromJson(Map<String, dynamic> json) {
    return ChatMsg(
      user_id: int.parse(json['user_id'].toString()),
      sender_name: json['sender_name'].toString(),
      message: json['message'].toString(),
      video_id: int.parse(json['stream_id'].toString()),
    );
  }
}
