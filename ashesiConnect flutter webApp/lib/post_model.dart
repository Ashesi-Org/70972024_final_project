import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).values.map((x) => PostModel.fromJson(x)));

class PostModel {
  PostModel({
    required this.email,
    required this.text,
    required this.timestamp,
  });

  String text;
  String timestamp;
  String email;


  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    text: json["text"],
    timestamp: json["timestamp"],
    email: json["email"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "text": text,
  //   "timestamp": timestamp,
  //   "email": email,
  // };
}


