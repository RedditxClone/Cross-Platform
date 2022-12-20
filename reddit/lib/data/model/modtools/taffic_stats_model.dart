/// Model of account settings comming from "user/me/prefs"
class TrafficStats {
  late String date;
  late int joined;
  late String left;
  TrafficStats({required this.date, required this.joined, required this.left});

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrafficStats &&
          date == other.date &&
          joined == other.joined &&
          left == other.left;

  /// Map settings comming from web services to the model.
  /// The repository (account_settings_repository) calls this function
  TrafficStats.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    joined = json['joined'];
    left = json['left'];
  }
}
