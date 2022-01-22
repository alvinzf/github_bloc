class Repositories {
  Repositories({
    this.fullName,
    this.stargazersCount,
    this.forks,
    this.watchers,
    this.createdAt,
    this.htmlUrl,
  });

  String fullName;
  int stargazersCount;
  int forks;
  int watchers;
  DateTime createdAt;
  String htmlUrl;

  factory Repositories.fromJson(Map<String, dynamic> json) => Repositories(
        fullName: json["full_name"],
        stargazersCount: json["stargazers_count"],
        forks: json["forks"],
        watchers: json["watchers"],
        createdAt: DateTime.parse(json["created_at"]),
        htmlUrl: json["html_url"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "stargazers_count": stargazersCount,
        "forks": forks,
        "watchers": watchers,
        "created_at": createdAt.toIso8601String(),
        "htmlUrl": htmlUrl
      };
}
