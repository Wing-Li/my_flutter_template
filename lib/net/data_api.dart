import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_flutter_template/net/api/api_url.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

import 'data/user_info.dart';
import 'http_utils.dart';

DataApi dataApi = new DataApi();

class DataApi {
  //私有构造函数
  DataApi._internal();

  //保存单例
  static DataApi _singleton = new DataApi._internal();

  //工厂构造函数
  factory DataApi() => _singleton;

  /// 基础 Header
  Map<String, String> _getBaseHeaders() {
    return {};
    //
    // String deviceType = Platform.isIOS ? "ios" : 'android';
    // String appVersion = '1.0.0';
    // String authorization = "";
    //
    // return {
    //   "Content-Type": "application/json; charset=utf-8",
    //   "Accept": "application/json",
    //   "Accept-Version": "1.0.0",
    //   "Accept-Encoding": "gzip",
    //   "dtype": deviceType,
    //   "app-version": appVersion,
    //   "country": "us",
    //   "Authorization": authorization,
    // };
  }

  /// get 基类方法
  dynamic get(String api, {Map<String, dynamic> data, bool isNeedToken = true}) async {
    Map<String, String> headers = _getBaseHeaders();

    Response response = await httpUtils.get(ApiUrl.BASE_URL + api, params: data, headers: headers);
    return response == null ? null : response.data;
  }

  /// post 基类方法
  dynamic post(String api, {Map data, FormData formData, bool isNeedToken = true}) async {
    Map<String, String> headers = _getBaseHeaders();

    HashMap<String, dynamic> map;
    if (data != null) {
      map = HashMap<String, dynamic>();
      map["data"] = data;
    }

    Response response = await httpUtils.post(ApiUrl.BASE_URL + api, queryParameters: map, formData: formData, headers: headers);
    return response == null ? null : response?.data;
  }

  /// 上传文件
  dynamic postFile(String api, FormData formData) async {
    Map<String, String> headers = _getBaseHeaders();

    Response response = await httpUtils.post(ApiUrl.BASE_URL + api, formData: formData, headers: headers);
    return response == null ? null : response?.data;
  }

  /// 请求异常时的基础操作
  _errorOpt(result) {
    if (result == null) return;
    // KDIX_ErrorCallBack error = KDIX_ErrorCallBack.fromJson(result);
    MyUtils.showToast(msg: "${result.toString()}");
  }

  // Future<UserData> getUserInfo({int userId}) async {
  //   try {
  //     if (userId == null) userId = KDIX_UserModel.user.userInfo.userId;
  //     Map<String, dynamic> map = {};
  //     map["user_id"] = userId;
  //     var result = await post(KDIX_API.getUserInfo, data: map);
  //     MyUtils.log(json.encode(result));
  //
  //     if (result == null || result["code"] != 200) {
  //       _errorOpt(result);
  //       return null;
  //     }
  //
  //     return KDIX_UserInfoModel.fromJson(result)?.data;
  //   } catch (e) {
  //     MyUtils.log(e);
  //     return null;
  //   }
  // }
}
