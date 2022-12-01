/// Model of account settings comming from "user/me/prefs"
class AccountSettingsModel {
  late String countryCode;
  late bool enableFollowers;
  late String gender;
  late bool over18;
  late bool emailUpvotePost;
  late bool emailUpvoteComment;
  late bool emailMessages;
  late int defaultCommentSort;
  late bool showFlair;
  AccountSettingsModel(
      {required this.countryCode,
      required this.enableFollowers,
      required this.gender,
      required this.over18,
      required this.emailUpvotePost,
      required this.emailUpvoteComment,
      required this.emailMessages,
      required this.defaultCommentSort,
      required this.showFlair});

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountSettingsModel &&
          countryCode == other.countryCode &&
          enableFollowers == other.enableFollowers &&
          gender == other.gender &&
          over18 == other.over18 &&
          emailUpvotePost == other.emailUpvotePost &&
          emailUpvoteComment == other.emailUpvoteComment &&
          emailMessages == other.emailMessages &&
          defaultCommentSort == other.defaultCommentSort &&
          showFlair == other.showFlair;

  /// Map settings comming from web services to the model.
  /// The repository (account_settings_repository) calls this function
  AccountSettingsModel.fromJson(Map<String, dynamic> json) {
    print("Account settings from model:");
    print("$json");
    countryCode = json['countryCode'] == "" ? "EG" : json['countryCode'];
    enableFollowers = json['allowFollow'];

    over18 = json['adultContent'];
    emailUpvotePost = json['upvotePosts'];
    emailUpvoteComment = json['upvoteComments'];
    gender = json['gender'] == "" ? "male" : json['gender'];
    // ???
    emailMessages = json['email_messages'] ?? false;
    defaultCommentSort = json['default_comment_sort'] ?? 0;
    showFlair = json['show_flair'] ?? false;
  }
  // Trial to update only certain settings
  // Map<String, dynamic> toJson(
  //     {countryCode,
  //     enableFollowers,
  //     gender,
  //     over18,
  //     emailUpvotePost,
  //     emailUpvoteComment,
  //     emailMessages,
  //     defaultCommentSort,
  //     showFlair}) {
  //   Map<String, dynamic> map = {};
  //   // print("Account settings from model:");
  //   // print("$json");
  //   ({
  //     'country_code': countryCode,
  //     'enable_followers': enableFollowers,
  //     'over_18': over18,
  //     'email_upvote_post': emailUpvotePost,
  //     'email_upvote_comment': emailUpvoteComment,
  //     'email_messages': emailMessages,
  //     'default_comment_sort': defaultCommentSort,
  //     'show_flair': showFlair,
  //     'gender': gender,
  //   }).forEach((k, v) {
  //     if (v != null) map[k] = v;
  //   });
  //   return map;
  // }
  /// Map settings from model to Json to be sent to web services.
  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "allowFollow": enableFollowers,
        "adultContent": over18,
        "upvotePosts": emailUpvotePost,
        "upvoteComments": emailUpvoteComment,
        "gender": gender,
        // ??
        "email_messages": emailMessages,
        "default_comment_sort": defaultCommentSort,
        "show_flair": showFlair,
      };
}
