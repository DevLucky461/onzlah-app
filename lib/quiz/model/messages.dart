class Message {
  int id;
  int user_id;
  String message;
  String name;
  int video_id;

  Message({this.id, this.user_id, this.message, this.video_id, this.name});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: int.parse(json['id'].toString()),
      user_id: int.parse(json['user_id'].toString()),
      message: json['message'].toString(),
      video_id: int.parse(json['video_id'].toString()),
      name: getName(json['users']),
    );
  }

  static getName(var json) {
    return json['name'] != null ? json['name'].toString() : 'null';
  }

  static getList(json) {
    var tagObjJson = json['message'] as List;
    List<Message> _tags = tagObjJson.map((tagJson) => Message.fromJson(tagJson)).toList();
    return _tags;
  }
}
