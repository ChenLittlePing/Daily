
class Video {
  ///标清视频url
  String sUrl;

  ///高清视频url
  String hUrl;

  String cover;

  String draft;

  Video(this.sUrl, this.hUrl, this.cover, this.draft);
}

class Comments {
  String content;
  String nickname;
  String created;
  String avatar;

  Comments(this.content, this.nickname, this.created, this.avatar);
}