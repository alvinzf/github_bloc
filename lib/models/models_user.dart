class Users {
  Users({this.login, this.avatarUrl, this.htmlUrl});

  String login;
  String avatarUrl;
  String htmlUrl;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        login: json["login"],
        avatarUrl: json["avatar_url"],
        htmlUrl: json["html_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatar_url": avatarUrl,
        "html_url": htmlUrl,
      };
}
