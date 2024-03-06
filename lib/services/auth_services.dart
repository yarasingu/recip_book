import 'package:myapp/models/users.dart';
import 'package:myapp/services/http_service.dart';

class AuthServices {
  static final AuthServices _singleton = AuthServices.internal();

  Users? users;

  final _httpservice = HTTPService();
  factory AuthServices() {
    return _singleton;
  }
  AuthServices.internal();

  Future<bool> login(String username, String password) async {
    try {
      var resposnce = await _httpservice.post("auth/login", {
        "username": username,
        "password": password,
      });
      if (resposnce?.statusCode == 200 && resposnce?.data != null) {
        users = Users.fromJson(resposnce?.data);
        _httpservice.setup(bearerToken: users?.token);
        return true;
      }
    } catch (e) {
      
        print(e);
      
    }
    return false;
  }
}
