class StaticPage {
  final String pageKey;
  final String title;
  final String content;

  StaticPage(
      {required this.pageKey, required this.title, required this.content});

  factory StaticPage.fromJson(Map<String, dynamic> json) {
    return StaticPage(
      pageKey: json['pageKey'],
      title: json['title'],
      content: json['content'],
    );
  }
}
