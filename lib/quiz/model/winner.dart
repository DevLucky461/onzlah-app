class Winner {
  List<int> user_id;
  String prize_money;

  Winner({this.user_id, this.prize_money});

  factory Winner.fromJson(Map<String, dynamic> json) {
    return Winner(
      user_id: json['user_id'].cast<int>(),
      prize_money: json['prize_money'].toString(),
    );
  }
}
