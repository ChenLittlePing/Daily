

import 'package:daily/net/api_yx/yx_request.dart';
import 'package:daily/net/base/response_cb.dart';

class YxApi {
  void getSpeeches(int page, Success success, Fail fail) {
    var params = {
      "page": page,
      "pageSize": 8
    };

    String endPoint = "/speechs";
    YxRequest.obtain().get(endPoint, params, success, fail);
  }
}