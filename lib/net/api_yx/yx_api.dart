

import 'package:daily/net/api_yx/yx_request.dart';
import 'package:daily/net/base/response_cb.dart';

class YxApi {
  void getSpeeches(int page, Success success, Fail fail) {
    var params = {
      "page": page,
      "pageSize": 8
    };

    YxRequest.obtain().get("/speechs", params, success, fail);
  }

  void getSpeechDetail(speechId, Success success, Fail fail) {
    var params = {
      "speech_id": speechId
    };

    YxRequest.obtain().get("/speech", params, success, fail);
  }
}