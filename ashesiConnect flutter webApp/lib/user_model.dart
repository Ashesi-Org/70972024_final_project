import 'dart:convert';

UserModel userModelFromJson(String str) {
  // UserModel user1 = json.decode(str).map((x) => UserModel.fromJson(x));
  Map<String, dynamic> user1 = json.decode(str);
  UserModel user = UserModel.fromJson(user1);
  return user;
}

// String userModelToJson(UserModel data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.pass,
    required this.email,
    required this.dob,
    required this.major,
    required this.on_campus,
    required this.year_group,
    required this.best_food,
    required this.best_movie,
  });

  String id;
  String name;
  String pass;
  String email;
  String dob;
  String major;
  String on_campus;
  String year_group;
  String best_food;
  String best_movie;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    pass: json["pass"],
    email: json["email"],
    dob: json["dob"],
    major: json["major"],
    on_campus: json["on_campus"],
    best_food: json["best_food"],
    best_movie: json["best_movie"],
    year_group: json["year_group"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "pass": pass,
  //   "email": email,
  //   "dob": dob,
  //   "major": major,
  //   "on_campus": on_campus,
  //   "best_food": best_food,
  //   "best_movie": best_movie,
  //   "year_group": year_group,
  // };
}


