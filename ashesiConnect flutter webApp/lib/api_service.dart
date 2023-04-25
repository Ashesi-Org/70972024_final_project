import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'user_model.dart';
import 'post_model.dart';
import 'package:dio/dio.dart';

//API Engine Block

class ApiService {
  static int code = 0;

  // api responsible for retrieving user profile
  Future<UserModel?> getUser(String id) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + '/?id=' + id);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        UserModel _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // api responsible for creating a post
  Future<bool> postPost(String id,  String email, String text) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint);

      final http.Response response = await http.post(url,
          body: jsonEncode(<String, String>{
            'id': id,
            'email': email,
            'text': text
          }));

      if (response.statusCode == 200) {
        return true;
      }
      else{
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //api responsible for creating a new user profile
  Future<int> postUser(String id, String pass, String dob, String food,
      String movie, String name, String major, String group, String email, String campus) async {
    try {
      var url = Uri.parse('https://us-central1-student-services-383506.cloudfunctions.net/services');

      var response = await http.post(url, body: jsonEncode(<String, dynamic>{
            "id": id,
            "pass": pass,
            "dob": dob,
            "best_food": food,
            "best_movie": movie,
            "name": name,
            "major": major,
            "year_group": group,
            "email": email,
            "on_campus": campus
          }
        )
      );

      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return 500;
    }
  }

  //api responsible for editing an existing user's profile
  Future<bool> editUser(String id, String dob, String food, String movie, String major, String group, String campus) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.editUser);

      final http.Response response = await http.post(url, body: jsonEncode(<String, String>{
            'id': id,
            'dob': dob,
            'best_food': food,
            'best_movie': movie,
            'major': major,
            'year_group': group,
            'on_campus': campus
          },
        )
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      else if(response.statusCode == 409){
        code = 1;
        return false;
      }
      else{
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // api for retrieving all posts created
  Future<List<PostModel>?> getPosts() async {
    try {
      final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<PostModel> _model = postModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
