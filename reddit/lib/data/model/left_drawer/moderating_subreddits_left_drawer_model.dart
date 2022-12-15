class ModeratingSubredditsDrawerModel {
  List<String>? subTopics;
  List<String>? bannedUsers;
  int? notificationType;
  String? sId;
  String? name;
  String? type;
  int? usersPermissions;
  bool? acceptPostingRequests;
  bool? allowPostCrosspost;
  bool? collapseDeletedComments;
  int? commentScoreHideMins;
  bool? archivePosts;
  bool? allowMultipleImages;
  bool? spoilersEnabled;
  String? suggestedCommentSort;
  bool? acceptFollowers;
  bool? over18;
  bool? allowImages;
  bool? allowVideos;
  bool? acceptingRequestsToJoin;
  List<String>? communityTopics;
  bool? requirePostFlair;
  int? postTextBodyRule;
  bool? restrictPostTitleLength;
  bool? banPostBodyWords;
  List<String>? postBodyBannedWords;
  bool? banPostTitleWords;
  List<String>? postTitleBannedWords;
  bool? requireWordsInPostTitle;
  String? postGuidelines;
  bool? welcomeMessageEnabled;
  List<String>? flairList;
  List<String>? moderators;
  List<String>? categories;
  String? createdDate;
  List<String>? rules;
  List<String>? joinList;
  List<String>? panedUsers;
  List<String>? mutedUsers;
  List<String>? approvedUsers;
  int? iV;

  ModeratingSubredditsDrawerModel(
      {this.subTopics,
      this.bannedUsers,
      this.notificationType,
      this.sId,
      this.name,
      this.type,
      this.usersPermissions,
      this.acceptPostingRequests,
      this.allowPostCrosspost,
      this.collapseDeletedComments,
      this.commentScoreHideMins,
      this.archivePosts,
      this.allowMultipleImages,
      this.spoilersEnabled,
      this.suggestedCommentSort,
      this.acceptFollowers,
      this.over18,
      this.allowImages,
      this.allowVideos,
      this.acceptingRequestsToJoin,
      this.communityTopics,
      this.requirePostFlair,
      this.postTextBodyRule,
      this.restrictPostTitleLength,
      this.banPostBodyWords,
      this.postBodyBannedWords,
      this.banPostTitleWords,
      this.postTitleBannedWords,
      this.requireWordsInPostTitle,
      this.postGuidelines,
      this.welcomeMessageEnabled,
      this.flairList,
      this.moderators,
      this.categories,
      this.createdDate,
      this.rules,
      this.joinList,
      this.panedUsers,
      this.mutedUsers,
      this.approvedUsers,
      this.iV});

  ModeratingSubredditsDrawerModel.fromJson(Map<String, dynamic> json) {
    subTopics = json['subTopics'].cast<String>();
    bannedUsers = json['bannedUsers'].cast<String>();
    notificationType = json['notificationType'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    usersPermissions = json['usersPermissions'];
    acceptPostingRequests = json['acceptPostingRequests'];
    allowPostCrosspost = json['allowPostCrosspost'];
    collapseDeletedComments = json['collapseDeletedComments'];
    commentScoreHideMins = json['commentScoreHideMins'];
    archivePosts = json['archivePosts'];
    allowMultipleImages = json['allowMultipleImages'];
    spoilersEnabled = json['spoilersEnabled'];
    suggestedCommentSort = json['suggestedCommentSort'];
    acceptFollowers = json['acceptFollowers'];
    over18 = json['over18'];
    allowImages = json['allowImages'];
    allowVideos = json['allowVideos'];
    acceptingRequestsToJoin = json['acceptingRequestsToJoin'];
    communityTopics = json['communityTopics'].cast<String>();
    requirePostFlair = json['requirePostFlair'];
    postTextBodyRule = json['postTextBodyRule'];
    restrictPostTitleLength = json['restrictPostTitleLength'];
    banPostBodyWords = json['banPostBodyWords'];
    postBodyBannedWords = json['postBodyBannedWords'].cast<String>();
    banPostTitleWords = json['banPostTitleWords'];
    postTitleBannedWords = json['postTitleBannedWords'].cast<String>();
    requireWordsInPostTitle = json['requireWordsInPostTitle'];
    postGuidelines = json['postGuidelines'];
    welcomeMessageEnabled = json['welcomeMessageEnabled'];
    flairList = json['flairList'].cast<String>();
    moderators = json['moderators'].cast<String>();
    categories = json['categories'].cast<String>();
    createdDate = json['createdDate'];
    rules = json['rules'].cast<String>();
    joinList = json['joinList'].cast<String>();
    panedUsers = json['panedUsers'].cast<String>();
    mutedUsers = json['mutedUsers'].cast<String>();
    approvedUsers = json['approvedUsers'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTopics'] = this.subTopics;
    data['bannedUsers'] = this.bannedUsers;
    data['notificationType'] = this.notificationType;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['usersPermissions'] = this.usersPermissions;
    data['acceptPostingRequests'] = this.acceptPostingRequests;
    data['allowPostCrosspost'] = this.allowPostCrosspost;
    data['collapseDeletedComments'] = this.collapseDeletedComments;
    data['commentScoreHideMins'] = this.commentScoreHideMins;
    data['archivePosts'] = this.archivePosts;
    data['allowMultipleImages'] = this.allowMultipleImages;
    data['spoilersEnabled'] = this.spoilersEnabled;
    data['suggestedCommentSort'] = this.suggestedCommentSort;
    data['acceptFollowers'] = this.acceptFollowers;
    data['over18'] = this.over18;
    data['allowImages'] = this.allowImages;
    data['allowVideos'] = this.allowVideos;
    data['acceptingRequestsToJoin'] = this.acceptingRequestsToJoin;
    data['communityTopics'] = this.communityTopics;
    data['requirePostFlair'] = this.requirePostFlair;
    data['postTextBodyRule'] = this.postTextBodyRule;
    data['restrictPostTitleLength'] = this.restrictPostTitleLength;
    data['banPostBodyWords'] = this.banPostBodyWords;
    data['postBodyBannedWords'] = this.postBodyBannedWords;
    data['banPostTitleWords'] = this.banPostTitleWords;
    data['postTitleBannedWords'] = this.postTitleBannedWords;
    data['requireWordsInPostTitle'] = this.requireWordsInPostTitle;
    data['postGuidelines'] = this.postGuidelines;
    data['welcomeMessageEnabled'] = this.welcomeMessageEnabled;
    data['flairList'] = this.flairList;
    data['moderators'] = this.moderators;
    data['categories'] = this.categories;
    data['createdDate'] = this.createdDate;
    data['rules'] = this.rules;
    data['joinList'] = this.joinList;
    data['panedUsers'] = this.panedUsers;
    data['mutedUsers'] = this.mutedUsers;
    data['approvedUsers'] = this.approvedUsers;
    data['__v'] = this.iV;
    return data;
  }
}
