class Event {
  int id;
  String event_name;
  String event_description;
  String event_host_name;
  String event_start_date;
  String event_end_date;
  int event_coins_prize_pool;
  String event_image_url;
  String stream_key;
  String question_state;

  Event(
      {this.id,
      this.event_name,
      this.event_description,
      this.event_host_name,
      this.event_start_date,
      this.event_end_date,
      this.event_coins_prize_pool,
      this.event_image_url,
      this.stream_key,
      this.question_state});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      event_name: json['event_name'],
      event_description: json['event_description'],
      event_host_name: json['event_host_name'],
      event_start_date: json['event_start_date'],
      event_end_date: json['event_end_date'],
      event_coins_prize_pool: json['event_coins_prize_pool'],
      event_image_url: json['event_image_url'],
      stream_key: json['stream_key'],
      question_state: json['question_state'],
    );
  }
}
