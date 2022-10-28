import '../web_services/dio.dart';

class EmailSettingsReposity {

  
  Future<Map<String, bool>> getEmailSettings(userId) async {
    try {
      var query = {"userId": userId};
      var emailSettings = await DioHelper.getData(
          url: "api/emailSettings?userId=$userId", query: query);
      print(emailSettings);
      return emailSettings;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<bool> setInboxMessagesSettings(InboxMessagesSettings) async {
    try {
      await DioHelper.postData(
          url: "inboxMessagesSettings", data: InboxMessagesSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setChatRequests(ChatRequests) async {
    try {
      await DioHelper.postData(url: "ChatRequests", data: ChatRequests);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setNewUserWelcome(NewUserWelcome) async {
    try {
      await DioHelper.postData(url: "NewUserWelcome", data: NewUserWelcome);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setCommentsOnYourPostsSettings(
      CommentsOnYourPostsSettings) async {
    try {
      await DioHelper.postData(
          url: "api/CommentsOnYourPostsSettings",
          data: CommentsOnYourPostsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setRepliesToYourCommentsSettings(
      RepliesToYourCommentsSettings) async {
    try {
      await DioHelper.postData(
          url: "RepliesToYourCommentsSettings",
          data: RepliesToYourCommentsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setUpvotesOnYourPostsSettings(UpvotesOnYourPostsSettings) async {
    try {
      await DioHelper.postData(
          url: "UpvotesOnYourPostsSettings", data: UpvotesOnYourPostsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setUpvotesOnYourCommentsSettings(
      UpvotesOnYourCommentsSettings) async {
    try {
      await DioHelper.postData(
          url: "UpvotesOnYourCommentsSettings",
          data: UpvotesOnYourCommentsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setUsernameMentionsSettings(UsernameMentionsSettings) async {
    try {
      await DioHelper.postData(
          url: "UsernameMentionsSettings", data: UsernameMentionsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setNewFollowersSettings(NewFollowersSettings) async {
    try {
      await DioHelper.postData(
          url: "NewFollowersSettings", data: NewFollowersSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setDailyDigestSettings(DailyDigestSettings) async {
    try {
      await DioHelper.postData(
          url: "DailyDigestSettings", data: DailyDigestSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setWeeklyRecapSettings(WeeklyRecapSettings) async {
    try {
      await DioHelper.postData(
          url: "WeeklyRecapSettings", data: WeeklyRecapSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setCommunityDiscoverySettings(CommunityDiscoverySettings) async {
    try {
      await DioHelper.postData(
          url: "CommunityDiscoverySettings", data: CommunityDiscoverySettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setUnsubscribeFromAllEmailsSettings(
      UnsubscribeFromAllEmailsSettings) async {
    try {
      await DioHelper.postData(
          url: "UnsubscribeFromAllEmailsSettings",
          data: UnsubscribeFromAllEmailsSettings);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
