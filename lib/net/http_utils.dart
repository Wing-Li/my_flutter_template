import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_template/utils/my_utils.dart';
import 'package:my_flutter_template/view/loading_widget.dart';
import 'package:path_provider/path_provider.dart';

HttpUtils httpUtils = new HttpUtils();

class HttpUtils {
  //保存单例
  static HttpUtils _singleton = new HttpUtils._internal();

  //工厂构造函数
  factory HttpUtils() => _singleton;

  //单例模式

  Dio _dio;

  HttpUtils._internal() {
    if (null == _dio) {
      _dio = new Dio();
//      _dio.options.baseUrl = Api.BASE_URL;
      _dio.options.connectTimeout = 60 * 1000;
      _dio.options.sendTimeout = 5 * 60 * 1000;
      _dio.options.receiveTimeout = 5 * 60 * 1000;
    }
  }

  /// url ：网络请求地址
  /// parasm : 请求参数
  /// get 请求
  Future get(
    String url, {
    Map<String, dynamic> params,
    Map<String, dynamic> headers,
    bool isAddLoading = false,
    BuildContext context,
    String loadingText,
  }) async {
    Response response;

    //显示 加载中的 loading
    if (isAddLoading) {
      showLoading(context, loadingText);
    }

    try {
      _dio.options.headers = headers;

      if (!MyUtils.isProd()) {
        StringBuffer buffer = StringBuffer();
        buffer.write("\nUrl: $url");
        buffer.write("\nHeaders: $headers");
        buffer.write("\nParameter: $params");
        MyUtils.log(buffer.toString());
      }

      if (params != null) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.get(url);
      }
      disMissLoadingDialog(isAddLoading, context);

      if (response.statusCode == 200) {
        return response;
      } else {
        MyUtils.showToast(msg: handleError(response.statusCode));
        response.data = null;
        return response;
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      MyUtils.showToast(msg: handleError(e));
      disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  /// url ：网络请求地址
  /// formData : 请求参数
  /// post 请求
  Future post(
    String url, {
    FormData formData,
    Map<String, dynamic> queryParameters,
    List<Map<String, dynamic>> parameterList,
    Map<String, dynamic> headers,
    bool isAddLoading = false,
    BuildContext context,
    String loadingText,
  }) async {
    Response response;

    // Directory documentsDir = await getApplicationDocumentsDirectory();
    // String documentsPath = documentsDir.path;
    // var dir = new Directory("$documentsPath/cookies");
    // await dir.create();
    // _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //显示 加载中的 loading
    if (isAddLoading) {
      showLoading(context, loadingText);
    }

    try {
      _dio.options.headers = headers;

      if (!MyUtils.isProd()) {
        StringBuffer buffer = StringBuffer();
        buffer.write("\nUrl: $url");
        buffer.write("\nHeaders: ${json.encode(headers)}");
        buffer.write("\nFormData: $formData");
        buffer.write("\nParameter: ${json.encode(queryParameters)}");
        MyUtils.log(buffer.toString());
      }

      if (formData != null) {
        response = await _dio.post(url, data: formData);
      } else if (queryParameters != null) {
        response = await _dio.post(url, data: json.encode(queryParameters));
      } else {
        response = await _dio.post(url);
      }
      disMissLoadingDialog(isAddLoading, context);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      disMissLoadingDialog(isAddLoading, context);
      print(e.response.data);
      return e.response;
    }
  }

  void disMissLoadingDialog(bool isAddLoading, BuildContext context) {
    if (isAddLoading) {
      Navigator.of(context).pop();
    }
  }

  /// 显示Loading
  void showLoading(BuildContext context, String loadText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return new LoadingWidget(
          outsideDismiss: false,
          loadingText: loadText,
        );
      },
    );
  }

  static String handleError(error, {String defaultErrorStr = 'Network error!!!'}) {
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errStr = 'Time out!!!';
      } else if (error.type == DioErrorType.SEND_TIMEOUT) {
        errStr = 'Time out!!!';
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = 'Time out!!!';
      } else if (error.type == DioErrorType.CANCEL) {
        errStr = 'Request cancel!!!';
      } else if (error.type == DioErrorType.RESPONSE) {
        int statusCode = error.response.statusCode;
        String msg = error.response.statusMessage;

        /// 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = 'Service error!!!';
            break;
          case 404:
            errStr = 'Not found!!!';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      } else if (error.type == DioErrorType.DEFAULT) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = 'Time out!!!';
        }
      } else {
        errStr = 'Network error!!!';
      }
    }
    return errStr ?? defaultErrorStr;
  }
}
