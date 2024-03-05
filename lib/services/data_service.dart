import 'package:myapp/models/recip.dart';
import 'package:myapp/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  
  final HTTPService _httpService = HTTPService();

  factory DataService(){
    return _singleton;
  }
  DataService._internal();

  Future<List<Recip>?> getrecip() async{
    String path  = "recipes/";
    var response = await _httpService.get(path);
    if(response?.statusCode == 200 && response?.data != null){
      List data = response?.data["recipes"];
      List<Recip> recipes = data.map((e) => Recip.fromJson(e)).toList();
      return recipes;
    }else{
      return null;
    }
  }
}