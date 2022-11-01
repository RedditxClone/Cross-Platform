/// Model of account settings comming from "user/me/prefs"
class AccountSettingsModel {
  late String countryCode;
  late bool enableFollowers;
  late String gender;
  late bool over18;
  late int numComments;
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
      required this.numComments,
      required this.emailUpvotePost,
      required this.emailUpvoteComment,
      required this.emailMessages,
      required this.defaultCommentSort,
      required this.showFlair});
  AccountSettingsModel.fromJson(Map<String, dynamic> json) {
    print("Account settings from model:");
    print("$json");
    countryCode = json['country_code'];
    enableFollowers = json['enable_followers'];

    over18 = json['over_18'];
    numComments = json['num_comments'];
    emailUpvotePost = json['email_upvote_post'];
    emailUpvoteComment = json['email_upvote_comment'];
    emailMessages = json['email_messages'];
    defaultCommentSort = json['default_comment_sort'];
    showFlair = json['show_flair'];
    gender = json['gender'];
  }
  // Map<String, dynamic> toJson(
  //     {countryCode,
  //     enableFollowers,
  //     gender,
  //     over18,
  //     numComments,
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
  //     'num_comments': numComments,
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

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'enable_followers': enableFollowers,
        'over_18': over18,
        'num_comments': numComments,
        'email_upvote_post': emailUpvotePost,
        'email_upvote_comment': emailUpvoteComment,
        'email_messages': emailMessages,
        'default_comment_sort': defaultCommentSort,
        'show_flair': showFlair,
        'gender': gender,
      };
}
