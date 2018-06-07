
class SpeechIntro {
  bool playing = false;
  int id;
  String picUrl;
  String audioUrl;
  String title;
  String content;

  Speaker speaker;

  SpeechIntro(this.id, this.title, this.picUrl,
      this.audioUrl, this.content, this.speaker);
}

class Speaker {
  String type;
  String intro;
  String avatar;
  String name;

  Speaker(this.type, this.intro, this.avatar, this.name);
}