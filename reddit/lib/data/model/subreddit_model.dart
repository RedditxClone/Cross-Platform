import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/flair_model.dart';

class SubredditModel {
  String? icon;
  String? description;
  int? memberCount;
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
  List<dynamic>? subTopics;
  bool? requirePostFlair;
  int? postTextBodyRule;
  bool? restrictPostTitleLength;
  bool? banPostBodyWords;
  List<dynamic>? postBodyBannedWords;
  bool? banPostTitleWords;
  List<dynamic>? postTitleBannedWords;
  bool? requireWordsInPostTitle;
  String? postGuidelines;
  bool? welcomeMessageEnabled;
  List<FlairModel>? flairList;
  List<dynamic>? moderators;
  List<dynamic>? categories;
  DateTime? createdDate;
  List<dynamic>? rules;
  List<dynamic>? joinList;
  List<dynamic>? bannedUsers;
  List<dynamic>? mutedUsers;
  List<dynamic>? approvedUsers;
  int? notificationType;
  String? sId;
  int? iV;

  SubredditModel(
      {name,
      type,
      usersPermissions,
      acceptPostingRequests,
      allowPostCrosspost,
      collapseDeletedComments,
      commentScoreHideMins,
      archivePosts,
      allowMultipleImages,
      spoilersEnabled,
      suggestedCommentSort,
      acceptFollowers,
      over18,
      allowImages,
      allowVideos,
      acceptingRequestsToJoin,
      subTopics,
      requirePostFlair,
      postTextBodyRule,
      restrictPostTitleLength,
      banPostBodyWords,
      postBodyBannedWords,
      banPostTitleWords,
      postTitleBannedWords,
      requireWordsInPostTitle,
      postGuidelines,
      welcomeMessageEnabled,
      flairList,
      moderators,
      categories,
      createdDate,
      rules,
      joinList,
      bannedUsers,
      mutedUsers,
      approvedUsers,
      notificationType,
      sId,
      iV});

  SubredditModel.fromJson(Map<String, dynamic> json) {
    icon = kIsWeb
        ? (json['icon'] == null || json['icon'] == ''
            ? null
            : imagesUrl + json['icon'])
        : json['icon'];
    description = json['description'];
    memberCount = json['memberCount'];
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
    allowImages = json['allowImages'] ?? true;
    allowVideos = json['allowVideos'] ?? true;
    acceptingRequestsToJoin = json['acceptingRequestsToJoin'];
    subTopics = json['subTopics'] as List<dynamic>?;
    requirePostFlair = json['requirePostFlair'];
    postTextBodyRule = json['postTextBodyRule'];
    restrictPostTitleLength = json['restrictPostTitleLength'];
    banPostBodyWords = json['banPostBodyWords'];
    postBodyBannedWords = json['postBodyBannedWords'] as List<dynamic>?;
    banPostTitleWords = json['banPostTitleWords'];
    postTitleBannedWords = json['postTitleBannedWords'] as List<dynamic>?;
    requireWordsInPostTitle = json['requireWordsInPostTitle'];
    postGuidelines = json['postGuidelines'];
    welcomeMessageEnabled = json['welcomeMessageEnabled'];
    flairList = [];
    if (json['flairList'] != null) {
      json['flairList'].forEach((flair) {
        flairList!.add(FlairModel.fromJson(flair));
      });
    }
    moderators = json['moderators'] as List<dynamic>?;
    categories = json['categories'] as List<dynamic>?;
    createdDate = json['createdDate'] != null
        ? DateTime.tryParse(json['createdDate']) ?? DateTime.now()
        : DateTime.now();
    rules = json['rules'] as List<dynamic>?;
    joinList = json['joinList'] as List<dynamic>?;
    memberCount = joinList == null ? 0 : joinList!.length;
    bannedUsers = json['bannedUsers'] as List<dynamic>?;
    mutedUsers = json['mutedUsers'] as List<dynamic>?;
    approvedUsers = json['approvedUsers'] as List<dynamic>?;
    notificationType = json['notificationType'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['usersPermissions'] = usersPermissions;
    data['acceptPostingRequests'] = acceptPostingRequests;
    data['allowPostCrosspost'] = allowPostCrosspost;
    data['collapseDeletedComments'] = collapseDeletedComments;
    data['commentScoreHideMins'] = commentScoreHideMins;
    data['archivePosts'] = archivePosts;
    data['allowMultipleImages'] = allowMultipleImages;
    data['spoilersEnabled'] = spoilersEnabled;
    data['suggestedCommentSort'] = suggestedCommentSort;
    data['acceptFollowers'] = acceptFollowers;
    data['over18'] = over18;
    data['allowImages'] = allowImages;
    data['allowVideos'] = allowVideos;
    data['acceptingRequestsToJoin'] = acceptingRequestsToJoin;
    data['subTopics'] = subTopics;
    data['requirePostFlair'] = requirePostFlair;
    data['postTextBodyRule'] = postTextBodyRule;
    data['restrictPostTitleLength'] = restrictPostTitleLength;
    data['banPostBodyWords'] = banPostBodyWords;
    data['postBodyBannedWords'] = postBodyBannedWords;
    data['banPostTitleWords'] = banPostTitleWords;
    data['postTitleBannedWords'] = postTitleBannedWords;
    data['requireWordsInPostTitle'] = requireWordsInPostTitle;
    data['postGuidelines'] = postGuidelines;
    data['welcomeMessageEnabled'] = welcomeMessageEnabled;
    data['flairList'] = flairList;
    data['moderators'] = moderators;
    data['categories'] = categories;
    data['createdDate'] = createdDate;
    data['rules'] = rules;
    data['joinList'] = joinList;
    data['bannedUsers'] = bannedUsers;
    data['mutedUsers'] = mutedUsers;
    data['approvedUsers'] = approvedUsers;
    data['notificationType'] = notificationType;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
