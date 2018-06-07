
import 'package:daily/net/base/http.dart';
import 'package:dio/dio.dart';

class YxRequest extends Http {

  static YxRequest _request;

  @override
  void initOption(Options options) {
    options.baseUrl = "https://api2.yixi.tv/api/v1";
  }

  static YxRequest obtain() {
    if(_request == null) {
      _request = YxRequest();
    }
    return _request;
  }
}