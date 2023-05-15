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
    _dio = Dio(BaseOptions(
      // baseUrl : Api.BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.transformer = _MyTransformer();
    _dio.interceptors.add(_MyInterceptors());
  }

  Future<Response<T?>?> get<T>(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isAddLoading = false,
  }) async {
    Response<T> response;

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

  Future<Response<T?>?> post<T>(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? mapData,
    FormData? formData,
    Object? data,
    bool isAddLoading = false,
  }) async {
    Response<T> response;

    //显示 加载中的 loading
    if (isAddLoading) {
      _showLoading();
    }

    try {
      _dio.options.headers = headers;

      if (formData != null) {
        response = await _dio.post(url, data: formData);
      } else if (mapData is Map && mapData != null) {
        response = await _dio.post(url, queryParameters: mapData);
      } else if (data != null) {
        response = await _dio.post(url, data: json.encode(data));
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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    MyUtils.log(''
        '------------------------请求开始------------------------'
        '\n- 请求方式：${options.method}'
        '\n- 请求头信息：${options.headers}'
        '\n- 请求数据: ${options.data}'
        '');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    MyUtils.log(""
        "请求结果：${response.data}"
        "\n------------------------请求结束------------------------"
        "");
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    MyUtils.log('------------------------请求出错------------------------'
        '\n- 错误类型：${err.type}'
        '\n- 错误信息：${err.message}'
        '\n- error: $err'
        '');
    return handler.next(err);
  }
}

/// 转换器
class _MyTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async {
    return super.transformResponse(options, response);
  }
}
