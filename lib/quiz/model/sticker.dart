class Sticker {
  int id;
  String sticker_name;
  String src;
  String sticker_cost;

  Sticker({
    this.id,
    this.sticker_name,
    this.src,
    this.sticker_cost,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) {
    return Sticker(
      id: json['id'],
      sticker_name: json['sticker_name'],
      src: json['src'],
      sticker_cost: json['sticker_cost'],
    );
  }

  static getList(json) {
    var tagObjJson = json['sticker'] as List;
    List<Sticker> _tags = tagObjJson.map((tagJson) => Sticker.fromJson(tagJson)).toList();
    return _tags;
  }
}
