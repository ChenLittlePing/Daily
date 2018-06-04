

import 'package:daily/net/api_article/article_request.dart';
import 'package:daily/net/base/response_cb.dart';

class ArticleApi {
  void getArticle(date, Success success, Fail fail) {
    var params = {
      "dev": "1"
    };

    String endPoint = "/article/";
    if (date != null) {
      params["date"] = date;
      endPoint += "day";
    } else {
      endPoint += "today";
    }
    ArticleRequest.obtain().get(endPoint, params, success, fail);
  }
}