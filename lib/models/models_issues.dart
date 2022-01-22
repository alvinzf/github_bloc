class Issues {
  Issues({this.title, this.createdAt, this.state, this.htmlUrl});

  String title;
  DateTime createdAt;
  String state;
  String htmlUrl;

  factory Issues.fromJson(Map<String, dynamic> json) => Issues(
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        state: json["state"],
        htmlUrl: json["html_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "state": state,
        "htmlUrl": htmlUrl,
      };
}
