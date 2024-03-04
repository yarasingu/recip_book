import 'package:dio/dio.dart';
import 'package:myapp/consts.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService.internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }
  HTTPService.internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",
    };
    if(bearerToken != null){
      headers["Authorization"] = "Bearer $bearerToken";
    }
    final options = BaseOptions(
        baseUrl: API_BASE_URL,
        headers: headers,
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });
    _dio.options = options;
  }

  Future<Response?> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    }
    catch (e) {

      return null;
    }
  }
}
