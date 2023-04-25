import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webtech/profile.dart';

import 'loginProvider.dart';
import 'main.dart';

class MyStatefuliProfile extends StatefulWidget {
  const MyStatefuliProfile({super.key});

  @override
  State<MyStatefuliProfile> createState() => _MyStatefulWidgetiProfile();
}


class _MyStatefulWidgetiProfile extends State<MyStatefuliProfile> {

  String _profileImage = 'assets/profile.png';

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (context, provider, _) {
          return provider.isLoggedIn()
              ? Center(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  CircleAvatar(
                    backgroundImage: AssetImage(_profileImage),
                    radius: 80,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    // padding: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.all(15.0),
                    child: Text(provider.getUserData().name,
                        style: TextStyle(
                            color: Color.fromRGBO(146, 61, 65, 1),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.email, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text(
                            provider.getUserData().email,
                            style: TextStyle(
                            fontSize: 18,
                            )
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.person_2, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text(
                            provider.getUserData().id,
                            style: TextStyle(
                              fontSize: 18,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text("Date of Birth: "+
                            provider.getUserData().dob,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.book, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text("Major: "+
                            provider.getUserData().major,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.maps_home_work, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text("On_campus: " +
                            provider.getUserData().on_campus,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.rocket_launch, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text('Year Group: '+
                            provider.getUserData().year_group,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.movie_filter, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text("Favourite movie: "+
                            provider.getUserData().best_movie,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emoji_food_beverage, color: Color.fromRGBO(146, 61, 65, 1)),
                        SizedBox(width: 10),
                        Text('Best Food: '+
                            provider.getUserData().best_food,
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ]
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyStatefulProfile()),
                      );
                    },
                      child: Text('Edit profile')
                  )
                ],
            )
          )
              : Text('You are logged out');
        }
    );
  }
}