import 'package:daily/utils/net/base/http.dart';
import 'package:dio/dio.dart';

class TCRequest extends Http {

  static TCRequest request;

  static TCRequest obtain() {
    if (request == null) {
      request = new TCRequest();
    }
    return request;
  }
  
  @override
  void initOption(Options options) {
    options.baseUrl = "https://api.tuchong.com";
  }
}
