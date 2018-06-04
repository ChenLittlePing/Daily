import 'package:daily/net/base/http.dart';
import 'package:dio/dio.dart';

class TCRequest extends Http {

  static TCRequest _request;

  static TCRequest obtain() {
    if (_request == null) {
      _request = new TCRequest();
    }
    return _request;
  }
  
  @override
  void initOption(Options options) {
    options.baseUrl = "https://api.tuchong.com";
  }
}
