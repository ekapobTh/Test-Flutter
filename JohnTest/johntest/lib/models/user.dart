// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String fullName;
  String nickname;
  String username;

  User({
    required this.id,
    required this.fullName,
    required this.nickname,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        nickname: json["nickname"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "nickname": nickname,
        "username": username,
      };
}
