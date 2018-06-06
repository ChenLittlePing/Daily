
class Article {
  String title;
  String author;
  String digest;
  String content;
  bool success;

  Article(this.title,
      this.author,
      this.digest,
      this.content,
      [this.success = true]);
}