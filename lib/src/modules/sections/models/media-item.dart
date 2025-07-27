class MediaItem {
  final String? url;
  final String? extension;

  MediaItem({
    this.url,
    this.extension,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      url: json['url'] as String?,
      extension: json['extension'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'extension': extension,
    };
  }
}
