
class SpeechIntro {
  bool playing = false;
  int id;
  String cover;
  String audioUrl;
  String title;
  String content;
  String category;
  String date;
  String city;

  Speaker speaker;
}

class Speaker {
  String type;
  String intro;
  String avatar;
  String name;

  Speaker(this.type, this.intro, this.avatar, this.name);
}