
import 'package:daily/net/api_tc/tc_request.dart';

class TCApi {
  void getNew(int page, String postId, Function success, Function fail) {
    var params = {
      "os_api": 22,
      "ssmix": "a",
      "manifest_version_code": 232,
      "abflag": 0,
      "uuid": "651384659521356",
      "version_code": 232,
      "app_name": "tuchong",
      "version_name": "2.3.2",
      "openudid": "65143269dafd1f3a5",
      "os_version": "5.8.1",
      "page": page,
      "post_id": page > 1? postId : null,
      "type": page == 1? "refresh" : "loadmore"
    };
    TCRequest request = TCRequest.obtain();
    print(params);
    request.get("/feed-app", params, success, fail);
  }
}