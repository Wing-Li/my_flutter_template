import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter_template/net/api/api_url.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

import 'http_utils.dart';

DataApi dataApi = new DataApi();

class DataApi {
  //私有构造函数
  DataApi._internal();

  //保存单例
  static final DataApi _singleton = DataApi._internal();

  //工厂构造函数
  factory DataApi() => _singleton;

  /// 基础 Header
  Map<String, String> _getBaseHeaders() {
    return {
      "Content-Type": "application/json; charset=utf-8",
    };
  }

  /// get 基类方法
  dynamic get(
      String api, {
        Map<String, dynamic>? data,
        bool isNeedToken = true,
      }) async {
    Map<String, String> headers = _getBaseHeaders();
    headers["up-encode"] = "0";

    Response? response = await httpUtils.get(ApiUrl.BASE_URL + api, params: data, headers: headers);

    if (response == null) {
      return null;
    } else {
      return response.data;
    }
  }

  /// post 基类方法
  dynamic post(
      String api, {
        Map<String, dynamic>? data,
        bool isNeedToken = true,
      }) async {
    Map<String, String> headers = _getBaseHeaders();

    Response? response = await httpUtils.post(ApiUrl.BASE_URL + api, mapData: data, headers: headers);

    if (response == null) {
      return null;
    } else {
      return response.data;
    }
  }

  /// 上传文件
  dynamic postFile(String api, FormData formData) async {
    Map<String, String> headers = _getBaseHeaders();

    Response? response = await httpUtils.post(ApiUrl.BASE_URL + api, formData: formData, headers: headers);

    if (response == null) {
      return null;
    } else {
      return response.data;
    }
  }


  String _TYPE_PHOTO = "TYPE_PHOTO";
  String _TYPE_VIDEO = "TYPE_VIDEO";
  String _TYPE_FILE = "TYPE_FILE";

  Future<String> _uploadBaseFile(String type, String filePath) async {
    try {
      String apiUrl = "";

      String time = DateTime.now().millisecondsSinceEpoch.toString();
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromFileSync(filePath, filename: "${MyUtils.getPathFileName(filePath)}_$time"),
      });
      var result = await postFile(apiUrl, formData);
      MyUtils.log(json.encode(result));

      if (result == null || result["code"] != 200) {
        _errorOpt(result);
        return "";
      }

      return result["data"]["url"];
    } catch (e) {
      MyUtils.log(e);
      return "";
    }
  }

  // =============================================================================================

  /// 请求异常时的基础操作
  _errorOpt(result) {
    // if (result != null && !MyUtils.isProd()) {
    //   ErrorCallBack error = ErrorCallBack.fromJson(result);
    //   MyUtils.showToast("${error?.code} ${error?.error?.msg}");
    // }
  }
}
