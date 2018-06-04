
import 'package:daily/net/base/http.dart';
import 'package:dio/dio.dart';

class ArticleRequest extends Http {

  static ArticleRequest _request;

  @override
  void initOption(Options options) {
    options.baseUrl = "https://interface.meiriyiwen.com";
  }

  static ArticleRequest obtain() {
    if(_request == null) {
      _request = ArticleRequest();
    }
    return _request;
  }
}