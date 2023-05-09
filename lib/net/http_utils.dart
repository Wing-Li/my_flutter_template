import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:my_flutter_template/utils/my_utils.dart';

HttpUtils httpUtils = HttpUtils();

class HttpUtils {
  //保存单例
  static final HttpUtils _singleton = HttpUtils._internal();

  //工厂构造函数
  factory HttpUtils() => _singleton;

  //单例模式
  late Dio _dio;

  HttpUtils._internal() {
    if (null == _dio) {
      _dio = new Dio(BaseOptions(
        // baseUrl : Api.BASE_URL,
        connectTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        contentType: Headers.jsonContentType,
      ));

      _dio.transformer = _MyTransformer();
      _dio.interceptors.add(_MyInterceptors());
    }
  }

  Future<Response?> get(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? params,
        bool isAddLoading = false,
      }) async {
    Response response;

    //显示 加载中的 loading
    if (isAddLoading) {
      _showLoading();
    }

    try {
      _dio.options.headers = headers;

      if (params != null) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.get(url);
      }

      if (response.statusCode == 200) {
        return response;
      } else {
        response.data = null;
        return response;
      }
    } catch (e) {
      MyUtils.log(e);
      MyUtils.showToast("Network Error");
      return null;
    } finally {
      _disMissLoadingDialog(isAddLoading);
    }
  }

  Future<Response?> post(
      String url, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? mapData,
        FormData? formData,
        bool isAddLoading = false,
      }) async {
    Response response;

    //显示 加载中的 loading
    if (isAddLoading) {
      _showLoading();
    }

    try {
      _dio.options.headers = headers;

      if (formData != null) {
        response = await _dio.post(url, data: formData);
      } else if (mapData != null) {
        response = await _dio.post(url, data: json.encode(mapData));
      } else {
        response = await _dio.post(url);
      }

      return response;
    } catch (e) {
      MyUtils.log(e);
      MyUtils.showToast("Network Error");
      return null;
    } finally {
      _disMissLoadingDialog(isAddLoading);
    }
  }

  void _disMissLoadingDialog(bool isAddLoading) {
    if (isAddLoading) {
      BotToast.closeAllLoading();
    }
  }

  /// 显示Loading
  void _showLoading() {
    BotToast.showLoading();
  }
}

/// 拦截器
class _MyInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler h) {
    MyUtils.log('------------------------请求开始------------------------');
    MyUtils.log('- 请求方式：${options?.method}');
    MyUtils.log('- 请求头信息：${options.headers}');
    MyUtils.log('- 请求数据: ${options?.data}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler h) {
    MyUtils.log("请求结果：${response?.data}");
    MyUtils.log('------------------------请求结束------------------------');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler h) {
    MyUtils.log('------------------------请求出错------------------------');
    MyUtils.log('- 错误类型：${err.type}');
    MyUtils.log('- 错误信息：${err.message}');
    MyUtils.log('- error: $err');
  }
}

/// 转换器
class _MyTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async {
    return super.transformResponse(options, response);
  }
}
