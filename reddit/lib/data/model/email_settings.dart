/// Email Settings model
class EmailSettings {
  late bool inboxMessages;
  late bool chatRequests;
  late bool newUserWelcome;
  late bool commentsOnPost;
  late bool repliesToComments;
  late bool upvotesOnPost;
  late bool upvotesOnComments;
  late bool usernameMentions;
  late bool newFollowers;
  late bool dailyDigest;
  late bool weeklyRecap;
  late bool communityDiscovery;
  late bool unsubscribeEmails;
  EmailSettings({
    required this.inboxMessages,
    required this.chatRequests,
    required this.newUserWelcome,
    required this.commentsOnPost,
    required this.repliesToComments,
    required this.upvotesOnPost,
    required this.upvotesOnComments,
    required this.usernameMentions,
    required this.newFollowers,
    required this.dailyDigest,
    required this.weeklyRecap,
    required this.communityDiscovery,
    required this.unsubscribeEmails,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailSettings &&
          other.inboxMessages == inboxMessages &&
          other.chatRequests == chatRequests &&
          other.newUserWelcome == newUserWelcome &&
          other.commentsOnPost == commentsOnPost &&
          other.repliesToComments == repliesToComments &&
          other.upvotesOnPost == upvotesOnPost &&
          other.upvotesOnComments == upvotesOnComments &&
          other.usernameMentions == usernameMentions &&
          other.newFollowers == newFollowers &&
          other.dailyDigest == dailyDigest &&
          other.weeklyRecap == weeklyRecap &&
          other.communityDiscovery == communityDiscovery &&
          other.unsubscribeEmails == unsubscribeEmails;

  EmailSettings.fromJson(Map<String, dynamic> json) {
    inboxMessages = json['inbox_messages'];
    chatRequests = json['chat_requests'];
    newUserWelcome = json['new_user_welcome'];
    commentsOnPost = json['comments_on_post'];
    repliesToComments = json['replies_to_comments'];
    upvotesOnPost = json['upvotes_on_post'];
    upvotesOnComments = json['upvotes_on_comments'];
    usernameMentions = json['username_mentions'];
    newFollowers = json['new_followers'];
    dailyDigest = json['daily_digest'];
    weeklyRecap = json['weekly_recap'];
    communityDiscovery = json['community_discovery'];
    unsubscribeEmails = json['unsubscribe_emails'];
  }

  Map<String, bool> toJson() => {
        'inbox_messages': inboxMessages,
        'chat_requests': chatRequests,
        'new_user_welcome': newUserWelcome,
        'comments_on_post': commentsOnPost,
        'replies_to_comments': repliesToComments,
        'upvotes_on_post': upvotesOnPost,
        'upvotes_on_comments': upvotesOnComments,
        'username_mentions': usernameMentions,
        'new_followers': newFollowers,
        'daily_digest': dailyDigest,
        'weekly_recap': weeklyRecap,
        'community_discovery': communityDiscovery,
        'unsubscribe_emails': unsubscribeEmails,
      };

  List<bool> toList() => [
        inboxMessages,
        chatRequests,
        newUserWelcome,
        commentsOnPost,
        repliesToComments,
        upvotesOnPost,
        upvotesOnComments,
        usernameMentions,
        newFollowers,
        dailyDigest,
        weeklyRecap,
        communityDiscovery,
        unsubscribeEmails,
      ];
}
