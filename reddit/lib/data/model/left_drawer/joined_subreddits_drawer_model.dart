class JoinedSubredditsDrawerModel {
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
  List<FlairList>? flairList;
  List<String>? moderators;
  List<String>? categories;
  int? iV;
  String? description;

  JoinedSubredditsDrawerModel(
      {this.sId,
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
      this.iV,
      this.description});

  JoinedSubredditsDrawerModel.fromJson(Map<String, dynamic> json) {
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
    if (json['flairList'] != null) {
      flairList = <FlairList>[];
      json['flairList'].forEach((v) {
        flairList!.add(new FlairList.fromJson(v));
      });
    }
    moderators = json['moderators'].cast<String>();
    categories = json['categories'].cast<String>();
    iV = json['__v'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.flairList != null) {
      data['flairList'] = this.flairList!.map((v) => v.toJson()).toList();
    }
    data['moderators'] = this.moderators;
    data['categories'] = this.categories;
    data['__v'] = this.iV;
    data['description'] = this.description;
    return data;
  }
}

class FlairList {
  String? text;
  String? backgroundColor;
  String? textColor;

  FlairList({this.text, this.backgroundColor, this.textColor});

  FlairList.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['backgroundColor'] = this.backgroundColor;
    data['textColor'] = this.textColor;
    return data;
  }
}
