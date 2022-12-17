class VoteModel {
  int? votesCount;

  VoteModel({this.votesCount});

  VoteModel.fromJson(Map<String, dynamic> json) {
    votesCount = json['votesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['votesCount'] = this.votesCount;
    return data;
  }
}
