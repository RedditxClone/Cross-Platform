class GoogleSignInModel {
  late String _type;
  late String _message;
  late Data _data;

  GoogleSignInModel(
      {required String type, required String message, required Data data}) {
    _type = type;
    _message = message;
    _data = data;
  }
  //setters and getter for data memebers
  String get type => _type;
  set type(String type) => _type = type;
  String get message => _message;
  set message(String message) => _message = message;
  Data get data => _data;
  set data(Data data) => _data = data;

  GoogleSignInModel.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _message = json['message'];
    _data = json['data'] != null
        ? Data.fromJson(json['data'])
        : Data(
            user: User(
              userId: '',
              firstName: '',
              lastName: '',
              email: '',
              imageUrl: '',
              address: '',
              role: '',
            ),
            accessToken: '',
            refreshToken: '',
          );
  }
}

class Data {
  late User _user;
  late String _accessToken;
  late String _refreshToken;

  Data(
      {required User user,
      required String accessToken,
      required String refreshToken}) {
    _user = user;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  User get user => _user;
  set user(User user) => _user = user;
  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get refreshToken => _refreshToken;
  set refreshToken(String refreshToken) => _refreshToken = refreshToken;

  Data.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null
        ? User.fromJson(json['user'])
        : User(
            userId: '',
            firstName: '',
            lastName: '',
            email: '',
            imageUrl: '',
            address: '',
            role: '');
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }
}

class User {
  late String _userId;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _imageUrl;
  late dynamic _address;
  late String _role;

  User(
      {required String userId,
      required String firstName,
      required String lastName,
      required String email,
      required String imageUrl,
      required String address,
      required String role}) {
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _imageUrl = imageUrl;
    _address = address;
    _role = role;
  }

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get email => _email;
  set email(String email) => _email = email;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;
  dynamic get address => _address;
  set address(dynamic address) => _address = address;
  String get role => _role;
  set role(String role) => _role = role;

  User.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _imageUrl = json['imageUrl'];
    _address = json['address'];
    _role = json['role'];
  }
}
