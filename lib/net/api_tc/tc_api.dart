
import 'package:daily/net/api_tc/tc_request.dart';

class TCApi {
  void getNew(int page, String postId, Function success, Function fail) {
    var params = {
      "page": page,
      "post_id": postId,
      "type": page == 1? "refresh" : "loadmore"
    };
    TCRequest request = TCRequest.obtain();
    request.get("/feed-app", params, success, fail);
  }
}