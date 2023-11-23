import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  static const String _url = "http://yijuzhan.com";

// /api/word.php?m=json
  static HttpManager get instance => _instance;
  static Dio? _dio;

  HttpManager._internal() {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
          baseUrl: _url,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          contentType: "application/json; charset=utf-8"));
      _dio!.interceptors.add(HeaderInterceptor());
    }
  }

  static void init()  {
    if (null == _dio) {
      HttpManager._internal();
    }
  }

  static Future<Response> post(String path, {Map<String, dynamic>? params}) async {
    Response response;

    try {
      response = await _dio!.post(path, data: params);

      // if (response.data) {
      //   debugPrint("");
      // } else {
      //   debugPrint(" API 接口错误', $path ");
      // }
    } on DioException catch (e) {
      response = Response(data: formatError(e), requestOptions: RequestOptions(path: ''));
    }

    return response;
  }

  /// error统一处理
static  Map<String, dynamic> formatError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      // It occurs when url is opened timeout.
      return {"MESSAGE": "连接超时 Ծ‸ Ծ", "IS_SUCCESS": false};
    } else if (error.type == DioExceptionType.sendTimeout) {
      // It occurs when url is sent timeout.
      return {"MESSAGE": "请求超时 Ծ‸ Ծ", "IS_SUCCESS": false};
    } else if (error.type == DioExceptionType.receiveTimeout) {
      //It occurs when receiving timeout
      return {"MESSAGE": "响应超时 Ծ‸ Ծ", "IS_SUCCESS": false};
    } else if (error.type == DioExceptionType.badResponse) {
      // When the server response, but with a incorrect status, such as 404, 503...
      int? errCode = error.response?.statusCode;
      switch (errCode) {
        case 400:
          return {"MESSAGE": "请求语法错误 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 401:
          return {"MESSAGE": "没有权限 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 403:
          return {"MESSAGE": "服务器拒绝执行 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 404:
          return {"MESSAGE": "无法连接服务器 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 405:
          return {"MESSAGE": "请求方法被禁止 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 500:
          return {"MESSAGE": "服务器内部错误 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 502:
          return {"MESSAGE": "无效请求 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 503:
          return {"MESSAGE": "服务器异常 Ծ‸ Ծ", "IS_SUCCESS": false};
        case 505:
          return {"MESSAGE": "不支持HTTP协议请求 Ծ‸ Ծ", "IS_SUCCESS": false};
        default:
          return {"MESSAGE": "请求异常 Ծ‸ Ծ", "IS_SUCCESS": false};
      }
    } else if (error.type == DioExceptionType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      debugPrint("请求取消 Ծ‸ Ծ");
      return {"MESSAGE": "请求取消 Ծ‸ Ծ", "IS_SUCCESS": false};
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      debugPrint("未知错误 Ծ‸ Ծ");
      return {"MESSAGE": "网络异常 Ծ‸ Ծ", "IS_SUCCESS": false};
    }
  }
}

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("onRequest");
    super.onRequest(options, handler);
  }
}
