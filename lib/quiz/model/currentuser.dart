class CurrentUser {
  int id;
  String name;
  String referral;
  int coins;
  int life;

  CurrentUser({
    this.id,
    this.name,
    this.referral,
    this.coins,
    this.life,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['id'],
      name: json['name'],
      referral: json['referral_code'],
      coins: json['coins'],
      life: json['life'],
    );
  }
}
