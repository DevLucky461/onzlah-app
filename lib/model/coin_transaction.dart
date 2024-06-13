class CoinTransaction {
  int id;
  String transaction_type;
  int transaction_value;
  int user_id;
  String created_at;

  CoinTransaction({
    this.id,
    this.transaction_type,
    this.transaction_value,
    this.user_id,
    this.created_at,
  });

  factory CoinTransaction.fromJson(Map<String, dynamic> json) {
    return CoinTransaction(
      id: int.parse(json['id'].toString()),
      transaction_type: json['transaction_type'].toString(),
      transaction_value: json['transaction_value'],
      user_id: int.parse(json['user_id'].toString()),
      created_at: json['created_at'].toString(),
    );
  }

  static getList(json) {
    var tagObjJson = json['transactions'] as List;
    List<CoinTransaction> _tags =
        tagObjJson.map((tagJson) => CoinTransaction.fromJson(tagJson)).toList();
    return _tags;
  }
}
