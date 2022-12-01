/// Email Settings model
class EmailSettings {
  late bool inboxMessages;
  late bool newUserWelcome;
  late bool commentsOnPost;
  late bool repliesToComments;
  late bool upvotesOnPost;
  late bool upvotesOnComments;
  late bool usernameMentions;
  late bool newFollowers;
  EmailSettings({
    required this.inboxMessages,
    required this.newUserWelcome,
    required this.commentsOnPost,
    required this.repliesToComments,
    required this.upvotesOnPost,
    required this.upvotesOnComments,
    required this.usernameMentions,
    required this.newFollowers,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailSettings &&
          other.inboxMessages == inboxMessages &&
          other.newUserWelcome == newUserWelcome &&
          other.commentsOnPost == commentsOnPost &&
          other.repliesToComments == repliesToComments &&
          other.upvotesOnPost == upvotesOnPost &&
          other.upvotesOnComments == upvotesOnComments &&
          other.usernameMentions == usernameMentions &&
          other.newFollowers == newFollowers;
  EmailSettings.fromJson(Map<String, dynamic> json) {
    inboxMessages = json['inboxMessages'];
    newUserWelcome = json['newUserFlair'];
    commentsOnPost = json['commentsOnPost'];
    repliesToComments = json['repliesComments'];
    upvotesOnPost = json['upvotePosts'];
    upvotesOnComments = json['upvoteComments'];
    usernameMentions = json['mentions'];
    newFollowers = json['newFollowers'];
  }

  Map<String, bool> toJson() => {
        'inboxMessages': inboxMessages,
        'newUserFlair': newUserWelcome,
        'commentsOnPost': commentsOnPost,
        'repliesComments': repliesToComments,
        'upvotePosts': upvotesOnPost,
        'upvoteComments': upvotesOnComments,
        'mentions': usernameMentions,
        'newFollowers': newFollowers,
      };

  List<bool> toList() => [
        inboxMessages,
        newUserWelcome,
        commentsOnPost,
        repliesToComments,
        upvotesOnPost,
        upvotesOnComments,
        usernameMentions,
        newFollowers,
      ];
}
