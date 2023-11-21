import 'dart:collection';

import 'package:my_flutter_template/net/data/yiyan_enity.dart';

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

  Future<YiyanData?> randomYiYan() async {
    Map<String, dynamic> map = HashMap();
    var data = await get(ApiUrl.API_YIYAN, data: map);

    if (data == null) {
      return null;
    } else {
      return YiyanData.fromJson(data);
    }
  }

}
