import 'package:daily/utils/net/base/response_cb.dart';
import 'package:dio/dio.dart';

///Http请求基础类
///<p>配置基本的请求信息，以及基础的请求功能方法
///<p>正在的请求类需要继承该类，并实现{initOption}方法，进行参数配置
abstract class Http {

  static Options _options = Options(
      baseUrl: "",
      connectTimeout: 5000,
      receiveTimeout: 3000
  );

  static Dio _dio;

  Http() {
    initOption(_options);
  }

  Dio getDio() {
    if (_dio == null) {
      _dio = Dio(_options);
    }
    return _dio;
  }

  void initOption(Options options) {

  }

  void get(String endpoint, var params, Success success, Fail fail) async {
    try {
      Response response = await getDio().get(endpoint, data: params);
      handleData(success, response.data);
    } on DioError catch(e) {
      handleError(fail, e);
    }
  }

  void post(String endpoint, var data, Success success, Fail fail) async {
    try {
      Response response = await getDio().post(endpoint, data: data);
      handleData(success, response.data);
    } on DioError catch(e) {
      handleError(fail, e);
    }
  }

  void getString(String endpoint, Success success, Fail fail) async {
    try {
      Response response = await getDio().get(endpoint);
      handleData(success, response.data);
    } on DioError catch(e) {
      handleError(fail, e);
    }
  }

  void postString(String endpoint, Success success, Fail fail) async {
    try {
      Response response = await getDio().post(endpoint);
      handleData(success, response.data);
    } on DioError catch(e) {
      handleError(fail, e);
    }
  }

  void handleData(cb, var data) {
    if (cb != null && cb is Function) {
      cb(data);
    }
  }

  void handleError(cb, DioError e) {
    if (cb == null || !(cb is Function)) return;
    print("error:" + e.type.toString());
    if(e.response != null) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
    } else {
      switch (e.type) {
        case DioErrorType.DEFAULT:
          cb("服务器出错");
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          cb("网络连接超时");
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          cb("网络连接超时");
          break;
        case DioErrorType.RESPONSE:
          cb("网络异常");
          break;
        case DioErrorType.CANCEL:
          cb("取消请求");
          break;
      }
    }
  }
}