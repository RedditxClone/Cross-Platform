// import 'package:flutter/material.dart';
// import 'package:reddit/data/model/auth_model.dart';
// import 'package:reddit/data/model/flair_model.dart';

// class SubredditModel {
//   late String icon;
//   late String description;
//   late String name;
//   late String type;
//   late int usersPermissions;
//   late bool acceptPostingRequests;
//   late bool allowPostCrosspost;
//   late bool collapseDeletedComments;
//   late int commentScoreHideMins;
//   late bool archivePosts;
//   late bool allowMultipleImages;
//   late bool spoilersEnabled;
//   late String suggestedCommentSort;
//   late bool acceptFollowers;
//   late bool over18;
//   late bool allowImages;
//   late bool allowVideos;
//   late bool acceptingRequestsToJoin;
//   late List<dynamic> subTopics;
//   late bool requirePostFlair;
//   late int postTextBodyRule;
//   late bool restrictPostTitleLength;
//   late bool banPostBodyWords;
//   late List<dynamic> postBodyBannedWords;
//   late bool banPostTitleWords;
//   late List<dynamic> postTitleBannedWords;
//   late bool requireWordsInPostTitle;
//   late String postGuidelines;
//   late bool welcomeMessageEnabled;
//   late List<FlairModel> flairList;
//   late List<String> moderators;
//   late List<dynamic> categories;
//   late DateTime createdDate;
//   late List<dynamic> rules;
//   late List<User> joinList;
//   late List<User> bannedUsers;
//   late List<User> mutedUsers;
//   late List<User> approvedUsers;
//   late int notificationType;
//   late String sId;
//   late int iV;
//   late int membersCount;

//   SubredditModel(
//       {icon,
//       description,
//       name,
//       type,
//       usersPermissions,
//       acceptPostingRequests,
//       allowPostCrosspost,
//       collapseDeletedComments,
//       commentScoreHideMins,
//       archivePosts,
//       allowMultipleImages,
//       spoilersEnabled,
//       suggestedCommentSort,
//       acceptFollowers,
//       over18,
//       allowImages,
//       allowVideos,
//       acceptingRequestsToJoin,
//       subTopics,
//       requirePostFlair,
//       postTextBodyRule,
//       restrictPostTitleLength,
//       banPostBodyWords,
//       postBodyBannedWords,
//       banPostTitleWords,
//       postTitleBannedWords,
//       requireWordsInPostTitle,
//       postGuidelines,
//       welcomeMessageEnabled,
//       flairList,
//       moderators,
//       categories,
//       createdDate,
//       rules,
//       joinList,
//       bannedUsers,
//       mutedUsers,
//       approvedUsers,
//       notificationType,
//       sId,
//       membersCount,
//       iV});

//   SubredditModel.fromJson(Map<String, dynamic> json) {
//     if (json['name'] == null) {
//       debugPrint("json['name'] = null");
//     }
//     if (json['type'] == null) {
//       debugPrint("json['type'] = null");
//     }
//     if (json['notificationType'] == null) {
//       debugPrint("json['notificationType'] = null");

//       if (json['__v'] == null) {
//         debugPrint("json['__v'] = null");
//       }
//       if (json['requireWordsInPostTitle'] == null) {
//         debugPrint("json['requireWordsInPostTitle'] = null");
//       }
//       if (json['postGuidelines'] == null) {
//         debugPrint("json['postGuidelines'] = null");
//       }
//       if (json['welcomeMessageEnabled'] == null) {
//         debugPrint("json['welcomeMessageEnabled'] = null");
//       }
//       if (json['requirePostFlair'] == null) {
//         debugPrint("json['requirePostFlair'] = null");
//       }
//       if (json['postTextBodyRule'] == null) {
//         debugPrint("json['postTextBodyRule'] = null");
//       }
//       if (json['restrictPostTitleLength'] == null) {
//         debugPrint("json['restrictPostTitleLength'] = null");
//       }
//       if (json['banPostBodyWords'] == null) {
//         debugPrint("json['banPostBodyWords'] = null");
//       }
//       if (json['usersPermissions'] == null) {
//         debugPrint("json['usersPermissions'] = null");
//       }
//       if (json['acceptPostingRequests'] == null) {
//         debugPrint("json['acceptPostingRequests'] = null");
//       }
//       if (json['allowPostCrosspost'] == null) {
//         debugPrint("json['allowPostCrosspost'] = null");
//       }
//       if (json['collapseDeletedComments'] == null) {
//         debugPrint("json['collapseDeletedComments'] = null");
//       }
//       if (json['commentScoreHideMins'] == null) {
//         debugPrint("json['commentScoreHideMins'] = null");
//       }
//       if (json['archivePosts'] == null) {
//         debugPrint("json['archivePosts'] = null");
//       }
//       if (json['allowMultipleImages'] == null) {
//         debugPrint("json['allowMultipleImages'] = null");
//       }
//       if (json['spoilersEnabled'] == null) {
//         debugPrint("json['spoilersEnabled'] = null");
//       }
//       if (json['suggestedCommentSort'] == null) {
//         debugPrint("json['suggestedCommentSort'] = null");
//       }
//       if (json['acceptFollowers'] == null) {
//         debugPrint("json['acceptFollowers'] = null");
//       }
//       if (json['over18'] == null) {
//         debugPrint("json['over18'] = null");
//       }
//       if (json['allowImages'] == null) {
//         debugPrint("json['allowImages'] = null");
//       }
//       if (json['allowVideos'] == null) {
//         debugPrint("json['allowVideos'] = null");
//       }
//       if (json['acceptingRequestsToJoin'] == null) {
//         debugPrint("json['acceptingRequestsToJoin'] = null");
//       }
//       membersCount = json['membersCount'] ?? 0;
//       name = json['name'];
//       type = json['type'];
//       icon = json['icon'] ?? "placeHolder";
//       description = json['description'] ?? "";
//       usersPermissions = json['usersPermissions'];
//       acceptPostingRequests = json['acceptPostingRequests'];
//       allowPostCrosspost = json['allowPostCrosspost'];
//       collapseDeletedComments = json['collapseDeletedComments'];
//       commentScoreHideMins = json['commentScoreHideMins'];
//       archivePosts = json['archivePosts'];
//       allowMultipleImages = json['allowMultipleImages'];
//       spoilersEnabled = json['spoilersEnabled'];
//       suggestedCommentSort = json['suggestedCommentSort'];
//       acceptFollowers = json['acceptFollowers'];
//       over18 = json['over18'];
//       allowImages = json['allowImages'];
//       allowVideos = json['allowVideos'];
//       acceptingRequestsToJoin = json['acceptingRequestsToJoin'];
//       if (json['subTopics'] != null) {
//         subTopics = [];
//         json['subTopics'].forEach((v) {
//           subTopics.add((v));
//         });
//       }
//       requirePostFlair = json['requirePostFlair'];
//       postTextBodyRule = json['postTextBodyRule'];
//       restrictPostTitleLength = json['restrictPostTitleLength'];
//       banPostBodyWords = json['banPostBodyWords'];
//       if (json['postBodyBannedWords'] != null) {
//         postBodyBannedWords = [];
//         json['postBodyBannedWords'].forEach((v) {
//           postBodyBannedWords.add((v));
//         });
//       }
//       banPostTitleWords = json['banPostTitleWords'];
//       if (json['postTitleBannedWords'] != null) {
//         postTitleBannedWords = [];
//         json['postTitleBannedWords'].forEach((v) {
//           postTitleBannedWords.add((v));
//         });
//       }
//       requireWordsInPostTitle = json['requireWordsInPostTitle'];
//       postGuidelines = json['postGuidelines'];
//       welcomeMessageEnabled = json['welcomeMessageEnabled'];
//       if (json['flairList'] != null) {
//         flairList = [];
//         json['flairList'].forEach((v) {
//           flairList.add((v));
//         });
//       }
//       moderators = json['moderators'] as List<String>?;
//       if (json['categories'] != null) {
//         categories = [];
//         json['categories'].forEach((v) {
//           categories.add((v));
//         });
//       }
//       createdDate = DateTime.parse(json['createdDate']);
//       if (json['rules'] != null) {
//         rules = [];
//         json['rules'].forEach((v) {
//           rules.add((v));
//         });
//       }
//       if (json['joinList'] != null) {
//         joinList = [];
//         json['joinList'].forEach((v) {
//           joinList.add((v));
//         });
//       }
//       if (json['bannedUsers'] != null) {
//         bannedUsers = [];
//         json['bannedUsers'].forEach((v) {
//           bannedUsers.add((v));
//         });
//       }
//       if (json['mutedUsers'] != null) {
//         mutedUsers = [];
//         json['mutedUsers'].forEach((v) {
//           mutedUsers.add((v));
//         });
//       }
//       if (json['approvedUsers'] != null) {
//         approvedUsers = [];
//         json['approvedUsers'].forEach((v) {
//           approvedUsers.add((v));
//         });
//       }
//       notificationType = json['notificationType'];
//       sId = json['_id'];
//       iV = json['__v'];
//     }

//     Map<String, dynamic> toJson() {
//       final Map<String, dynamic> data = <String, dynamic>{};
//       data['name'] = name;
//       data['type'] = type;
//       data['usersPermissions'] = usersPermissions;
//       data['acceptPostingRequests'] = acceptPostingRequests;
//       data['allowPostCrosspost'] = allowPostCrosspost;
//       data['collapseDeletedComments'] = collapseDeletedComments;
//       data['commentScoreHideMins'] = commentScoreHideMins;
//       data['archivePosts'] = archivePosts;
//       data['allowMultipleImages'] = allowMultipleImages;
//       data['spoilersEnabled'] = spoilersEnabled;
//       data['suggestedCommentSort'] = suggestedCommentSort;
//       data['acceptFollowers'] = acceptFollowers;
//       data['over18'] = over18;
//       data['allowImages'] = allowImages;
//       data['allowVideos'] = allowVideos;
//       data['acceptingRequestsToJoin'] = acceptingRequestsToJoin;
//       data['subTopics'] = subTopics.map((v) => v.toJson()).toList();
//       data['requirePostFlair'] = requirePostFlair;
//       data['postTextBodyRule'] = postTextBodyRule;
//       data['restrictPostTitleLength'] = restrictPostTitleLength;
//       data['banPostBodyWords'] = banPostBodyWords;
//       data['postBodyBannedWords'] =
//           postBodyBannedWords.map((v) => v.toJson()).toList();
//       data['banPostTitleWords'] = banPostTitleWords;
//       data['postTitleBannedWords'] =
//           postTitleBannedWords.map((v) => v.toJson()).toList();
//       data['requireWordsInPostTitle'] = requireWordsInPostTitle;
//       data['postGuidelines'] = postGuidelines;
//       data['welcomeMessageEnabled'] = welcomeMessageEnabled;
//       data['flairList'] = flairList.map((v) => v.toJson()).toList();
//       data['moderators'] = moderators;
//       data['categories'] = categories.map((v) => v.toJson()).toList();
//       data['createdDate'] = createdDate.toIso8601String();
//       data['rules'] = rules.map((v) => v.toJson()).toList();
//       data['joinList'] = joinList.map((v) => v.toJson()).toList();
//       data['bannedUsers'] = bannedUsers.map((v) => v.toJson()).toList();
//       data['mutedUsers'] = mutedUsers.map((v) => v.toJson()).toList();
//       data['approvedUsers'] = approvedUsers.map((v) => v.toJson()).toList();
//       data['notificationType'] = notificationType;
//       data['_id'] = sId;
//       data['__v'] = iV;
//       return data;
//     }
//   }

// // import 'package:reddit/data/model/flair_model.dart';

// // class SubredditModel {
// //   late String sId;
// //   late String name;
// //   late String type;
// //   late int usersPermissions;
// //   late bool acceptPostingRequests;
// //   late bool allowPostCrosspost;
// //   late bool collapseDeletedComments;
// //   late int commentScoreHideMins;
// //   late bool archivePosts;
// //   late bool allowMultipleImages;
// //   late bool spoilersEnabled;
// //   late String suggestedCommentSort;
// //   late bool acceptFollowers;
// //   late bool over18;
// //   late bool allowImages;
// //   late bool allowVideos;
// //   late bool acceptingRequestsToJoin;
// //   late List<dynamic> communityTopics;
// //   late bool requirePostFlair;
// //   late int postTextBodyRule;
// //   late bool restrictPostTitleLength;
// //   late bool banPostBodyWords;
// //   late List<dynamic> postBodyBannedWords;
// //   late bool banPostTitleWords;
// //   late List<dynamic> postTitleBannedWords;
// //   late bool requireWordsInPostTitle;
// //   late String postGuidelines;
// //   late bool welcomeMessageEnabled;
// //   late List<FlairModel> flairList;
// //   late List<String> moderators;
// //   late List<dynamic> categories;
// //   late int iV;

// //   SubredditModel(
// //       {required sId,
// //       required name,
// //       required type,
// //       required usersPermissions,
// //       required acceptPostingRequests,
// //       required allowPostCrosspost,
// //       required collapseDeletedComments,
// //       required commentScoreHideMins,
// //       required archivePosts,
// //       required allowMultipleImages,
// //       required spoilersEnabled,
// //       required suggestedCommentSort,
// //       required acceptFollowers,
// //       required over18,
// //       required allowImages,
// //       required allowVideos,
// //       required acceptingRequestsToJoin,
// //       required communityTopics,
// //       required requirePostFlair,
// //       required postTextBodyRule,
// //       required restrictPostTitleLength,
// //       required banPostBodyWords,
// //       required postBodyBannedWords,
// //       required banPostTitleWords,
// //       required postTitleBannedWords,
// //       required requireWordsInPostTitle,
// //       required postGuidelines,
// //       required welcomeMessageEnabled,
// //       required flairList,
// //       required moderators,
// //       required categories,
// //       required iV});

// //   SubredditModel.fromJson(Map<String, dynamic> json) {
// //     sId = json['_id'];
// //     name = json['name'];
// //     type = json['type'];
// //     usersPermissions = json['usersPermissions'];
// //     acceptPostingRequests = json['acceptPostingRequests'];
// //     allowPostCrosspost = json['allowPostCrosspost'];
// //     collapseDeletedComments = json['collapseDeletedComments'];
// //     commentScoreHideMins = json['commentScoreHideMins'];
// //     archivePosts = json['archivePosts'];
// //     allowMultipleImages = json['allowMultipleImages'];
// //     spoilersEnabled = json['spoilersEnabled'];
// //     suggestedCommentSort = json['suggestedCommentSort'];
// //     acceptFollowers = json['acceptFollowers'];
// //     over18 = json['over18'];
// //     allowImages = json['allowImages'];
// //     allowVideos = json['allowVideos'];
// //     acceptingRequestsToJoin = json['acceptingRequestsToJoin'];
// //     if (json['communityTopics'] != null) {
// //       communityTopics = [];
// //       json['communityTopics'].forEach((v) {
// //         communityTopics.add(v);
// //       });
// //     }
// //     requirePostFlair = json['requirePostFlair'];
// //     postTextBodyRule = json['postTextBodyRule'];
// //     restrictPostTitleLength = json['restrictPostTitleLength'];
// //     banPostBodyWords = json['banPostBodyWords'];
// //     if (json['postBodyBannedWords'] != null) {
// //       postBodyBannedWords = [];
// //       json['postBodyBannedWords'].forEach((v) {
// //         postBodyBannedWords.add(v);
// //       });
// //     }
// //     banPostTitleWords = json['banPostTitleWords'];
// //     if (json['postTitleBannedWords'] != null) {
// //       postTitleBannedWords = [];
// //       json['postTitleBannedWords'].forEach((v) {
// //         postTitleBannedWords.add(v);
// //       });
// //     }
// //     requireWordsInPostTitle = json['requireWordsInPostTitle'];
// //     postGuidelines = json['postGuidelines'];
// //     welcomeMessageEnabled = json['welcomeMessageEnabled'];
// //     flairList = [];
// //     if (json['flairList'] != null) {
// //       json['flairList'].forEach((flair) {
// //         flairList.add(FlairModel.fromJson(flair));
// //       });
// //     }
// //     moderators = json['moderators'].cast<String>();
// //     if (json['categories'] != null) {
// //       categories = [];
// //       json['categories'].forEach((v) {
// //         categories.add(v);
// //       });
// //     }
// //     iV = json['__v'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['_id'] = sId;
// //     data['name'] = name;
// //     data['type'] = type;
// //     data['usersPermissions'] = usersPermissions;
// //     data['acceptPostingRequests'] = acceptPostingRequests;
// //     data['allowPostCrosspost'] = allowPostCrosspost;
// //     data['collapseDeletedComments'] = collapseDeletedComments;
// //     data['commentScoreHideMins'] = commentScoreHideMins;
// //     data['archivePosts'] = archivePosts;
// //     data['allowMultipleImages'] = allowMultipleImages;
// //     data['spoilersEnabled'] = spoilersEnabled;
// //     data['suggestedCommentSort'] = suggestedCommentSort;
// //     data['acceptFollowers'] = acceptFollowers;
// //     data['over18'] = over18;
// //     data['allowImages'] = allowImages;
// //     data['allowVideos'] = allowVideos;
// //     data['acceptingRequestsToJoin'] = acceptingRequestsToJoin;
// //     if (communityTopics != null) {
// //       data['communityTopics'] = communityTopics.map((v) => v.toJson()).toList();
// //     }
// //     data['requirePostFlair'] = requirePostFlair;
// //     data['postTextBodyRule'] = postTextBodyRule;
// //     data['restrictPostTitleLength'] = restrictPostTitleLength;
// //     data['banPostBodyWords'] = banPostBodyWords;
// //     if (postBodyBannedWords != null) {
// //       data['postBodyBannedWords'] =
// //           postBodyBannedWords.map((v) => v.toJson()).toList();
// //     }
// //     data['banPostTitleWords'] = banPostTitleWords;
// //     if (postTitleBannedWords != null) {
// //       data['postTitleBannedWords'] =
// //           postTitleBannedWords.map((v) => v.toJson()).toList();
// //     }
// //     data['requireWordsInPostTitle'] = requireWordsInPostTitle;
// //     data['postGuidelines'] = postGuidelines;
// //     data['welcomeMessageEnabled'] = welcomeMessageEnabled;
// //     if (flairList != null) {
// //       data['flairList'] = flairList.map((flair) => flair.toJson()).toList();
// //     }
// //     data['moderators'] = moderators;
// //     if (categories != null) {
// //       data['categories'] =
// //           categories.map((category) => category.toJson()).toList();
// //     }
// //     data['__v'] = iV;
// //     return data;
// //   }
// }
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
    icon = json['icon'];
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
    moderators = json['moderators']as List<dynamic>?;
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
