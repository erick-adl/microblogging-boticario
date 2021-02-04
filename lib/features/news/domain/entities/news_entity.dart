import 'dart:convert';

NewsEntity newsModelFromJson(String str) =>
    NewsEntity.fromJson(json.decode(str));

class NewsEntity {
  NewsEntity({
    this.news,
  });

  List<News> news;

  factory NewsEntity.fromJson(Map<String, dynamic> json) => NewsEntity(
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}

class News {
  News({
    this.user,
    this.message,
  });

  User user;
  Message message;

  factory News.fromJson(Map<String, dynamic> json) => News(
        user: User.fromJson(json["user"]),
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "message": message.toJson(),
      };
}

class Message {
  Message({
    this.content,
    this.createdAt,
  });

  String content;
  DateTime createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "created_at": createdAt.toIso8601String(),
      };
}

class User {
  User({
    this.name,
    this.profilePicture,
  });

  String name;
  String profilePicture;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_picture": profilePicture,
      };
}
