import 'dart:collection';

import '../data/user_data.dart';
import 'api_url.dart';
import 'base_data_api.dart';

DataApi dataApi = DataApi();

class DataApi extends BaseDataApi {
  //私有构造函数
  DataApi._internal();

  //保存单例
  static final DataApi _singleton = DataApi._internal();

  //工厂构造函数
  factory DataApi() => _singleton;

  Future<UserData?> login(
    String userName,
    String passWord,
  ) async {
    Map<String, dynamic> map = HashMap();
    map["userName"] = userName;
    map["passWord"] = passWord;

    UserData? userData = await post<UserData>(ApiUrl.API_LOGIN, data: map);

    if (userData == null) {
      return null;
    } else {
      return userData;
    }
  }
}
