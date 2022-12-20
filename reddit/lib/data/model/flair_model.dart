class FlairModel {
  late String fId;
  late String text;
  late String backgroundColor;
  late String textColor;

  FlairModel(
      {required fId,
      required text,
      required backgroundColor,
      required textColor});

  FlairModel.fromJson(Map<String, dynamic> json) {
    fId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = fId;
    data['text'] = text;
    data['backgroundColor'] = backgroundColor;
    data['textColor'] = textColor;
    return data;
  }
}
