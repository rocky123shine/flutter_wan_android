import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wan_android/common/api.dart';

class HttpUtils {
  static HttpUtils? _utils;
  BaseOptions? _options;
  Dio? _dio;

  HttpUtils._() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    _options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
        "version": "1.0.0"
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      contentType: "application/json; charset=utf-8",
      //表示期望以那种格式(方式)接受响应数据。接受三种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
    _dio = Dio(_options)
      ..interceptors.add(CookieManager(CookieJar()))
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        print("请求之前");
        // Do something before request is sent
        return handler.next(options);
      }, onResponse: (response, handler) {
        print("响应之前");
        // Do something with response data
        if (response != null) {
          return handler.next(response);
        } else {
          return null;
        }
      }, onError: (DioError e, handler) {
        print("错误之前");
        // Do something with response error
        return handler.next(e);
      }));
  }

  static HttpUtils getInstance() {
    return null == _utils ? HttpUtils._() : _utils!;
  }

  static HttpUtils get instance => getInstance();

//封装网络请求
  get(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await _dio!.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');
    } on DioError catch (e) {
      print('get error---------$e');
      _formatError(e);
    }
    return response;
  }
  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await _dio!.post(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('post error---------${e.stackTrace}');
      _formatError(e);
    }
    return response;
  }

  void _formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
