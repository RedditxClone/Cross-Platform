// class SignInModel {
//   late String _type;
//   late String _message;
//   late Data _data;
//
//   SignInModel(
//       {required String type, required String message, required Data data}) {
//     _type = type;
//     _message = message;
//     _data = data;
//   }
//   //setters and getter for data memebers
//   String get type => _type;
//   set type(String type) => _type = type;
//   String get message => _message;
//   set message(String message) => _message = message;
//   Data get data => _data;
//   set data(Data data) => _data = data;

//   SignInModel.fromJson(Map<String, dynamic> json) {
//     _type = json['type'];
//     _message = json['message'];
//     _data = json['data'] != null
//         ? Data.fromJson(json['data'])
//         : Data(
//             user: User(
//               userId: '',
//               name: '',
//               email: '',
//               imageUrl: '',
//               address: '',
//               role: '',
//             ),
//             accessToken: '',
//             refreshToken: '',
//           );
//   }
// }

// class Data {
//   late User _user;
//   late String _accessToken;
//   late String _refreshToken;

//   Data(
//       {required User user,
//       required String accessToken,
//       required String refreshToken}) {
//     _user = user;
//     _accessToken = accessToken;
//     _refreshToken = refreshToken;
//   }

//   User get user => _user;
//   set user(User user) => _user = user;
//   String get accessToken => _accessToken;
//   set accessToken(String accessToken) => _accessToken = accessToken;
//   String get refreshToken => _refreshToken;
//   set refreshToken(String refreshToken) => _refreshToken = refreshToken;

//   Data.fromJson(Map<String, dynamic> json) {
//     _user = json['user'] != null
//         ? User.fromJson(json['user'])
//         : User(
//             userId: '',
//             name: '',
//             email: '',
//             imageUrl: '',
//           );
//     _accessToken = json['accessToken'];
//     _refreshToken = json['refreshToken'];
//   }
// }

class User {
  late String? userId;
  late String? name;
  late String? email;
  late String? imageUrl;
  late String? accessToken;
  // final String? userId, name, email, imageUrl;
  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.imageUrl});
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['userName'];
    email = json['email'];
    imageUrl = json['icon'];
  }
}
