import 'package:reddit/helper/dio.dart';

class SignupWebService {
  Future signup(String password,String username,String email) async {
    var res = await DioHelper.postData(url: '/api/auth/signup', data: {
      "password": password,
      "name": username,
      "email": email,
    });
    return res;
  }
}
