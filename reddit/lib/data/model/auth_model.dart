class User {
  late String? type;
  late String? userId;
  late String?
      name; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be the username
  late String? email;
  late String?
      profilePic; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be null
  String? accessToken;
  String? coverPic;
  late String? serverAuthCode;
  late String? gender; //could be null if the user didn't choose
  late Map<String, dynamic> interests;
  late String displayName;
  User(
      {required this.userId,
      required this.name,
      required this.displayName,
      required this.email,
      required this.coverPic,
      required this.profilePic});
  User.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    name = json['username'];
    email = json['email'];
    profilePic = json['profilePhoto'];
    coverPic = json['coverPhoto'];
    // accessToken = json['accessToken'];
    type = json['authType'];
    // serverAuthCode = json['serverAuthCode'];
    gender = json['gender'];
    displayName = json['displayName'];
  }
}

class UserData {
  static User? user;

  ///This function is used to set the user data after the user has signed up or signed in
  ///It should be called only once
  static initUser(User? user) {
    UserData.user = user;
  }
}
