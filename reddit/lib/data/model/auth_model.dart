class User {
  late String? type;
  late String userId;
  late String?
      username; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be the username
  late String? email;
  late String?
      profilePic; //in case of google or facebook user it will be taken from the google or facebook and in case of reddit sign in it will be null

  late String token;
  String? coverPic;
  late String? serverAuthCode;
  late String? gender; //could be null if the user didn't choose
  late Map<String, dynamic> interests;
  late String displayName;
  late String about;
  User(
      {required this.userId,
      required this.username,
      required this.displayName,
      required this.email,
      required this.coverPic,
      required this.profilePic});
  User.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    username = json['username'];
    email = json['email'];
    profilePic = json['profilePhoto'];
    token = json['token'];
    coverPic = json['coverPhoto'];
    type = json['authType'];
    gender = json['gender'];
    displayName = json['displayName'];
    about = json['about'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profilePhoto': profilePic,
      'token': token,
      'authType': type,
      '_id': userId,
      'gender': gender,
      displayName = json['displayName'] == '' ? json['username'] : json['displayName'];
      'about': about
    };
  }
}

class UserData {
  static User? user;

  ///This function is used to set the user data after the user has signed up or signed in
  ///It should be called only once
  static initUser(Map<String, dynamic> json) {
    UserData.user = User.fromJson(json);
  }
}
