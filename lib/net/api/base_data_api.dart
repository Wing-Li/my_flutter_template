import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

import '../http_utils.dart';

abstract class BaseDataApi {
  /// 基础 Header
  Map<String, String> _getBaseHeaders() {
    return {
      // "Content-Type": "application/json; charset=utf-8",
    };
  }

  /// get 基类方法
  Future<dynamic> get(
    String apiUrl, {
    Map<String, dynamic>? data,
  }) async {
    Map<String, String> headers = _getBaseHeaders();

    Response? response = await httpUtils.get(apiUrl, params: data, headers: headers);

    if (response == null) {
      _errorOpt(response);
      return null;
    } else {
      var dataMap = response.data;
      // 根据不同项目，这里返回自己相应的 data。 ps：dataMap.data["data"]
      return dataMap["data"];
    }
  }

  /// post 基类方法
  Future<dynamic> post(
    String apiUrl, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    Map<String, String> headers = _getBaseHeaders();

    Response? response = await httpUtils.post(
      apiUrl,
      headers: headers,
      queryParameters: queryParameters,
      mapData: data,
    );

    if (response == null) {
      _errorOpt(response);
      return null;
    } else {
      var dataMap = response.data;
      // 根据不同项目，这里返回自己相应的 data。 ps：dataMap.data["data"]
      return dataMap.data;
    }
  }

  /// 上传文件
  dynamic postFile(String api, FormData formData) async {
    Map<String, String> headers = _getBaseHeaders();

    Response? response = await httpUtils.post(api, formData: formData, headers: headers);

    if (response == null) {
      _errorOpt(response);
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
