import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.score,
    this.id,
    this.username,
    this.password,
  });
  int score;
  int id;
  String username;
  String password;
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        score: json["score"],
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );
  Map<String, dynamic> toJson() => {
        "score": score,
        "id": id,
        "username": username,
        "password": password,
      };
}
