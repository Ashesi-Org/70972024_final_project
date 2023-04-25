import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'api_service.dart';
import 'loginProvider.dart';
import 'main.dart';

class MyStatefulProfile extends StatefulWidget {
  const MyStatefulProfile({super.key});

  @override
  State<MyStatefulProfile> createState() => _MyStatefulWidgetProfile();
}

class _MyStatefulWidgetProfile extends State<MyStatefulProfile> {

  TextEditingController movieController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController campusController = TextEditingController();

  void showAlert(){
    QuickAlert.show(
      context: context,
      customAsset: '../assets/success.gif',
      type: QuickAlertType.success,
      title: 'Successful',
      text: 'Profile Editted',
    );
  }


  late bool done;

  void getData(String id, String dob, String food, String movie, String major, String group, String campus) async {
    done = (await ApiService().editUser(id, dob, food, movie, major, group, campus));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15),
            child:
            Consumer<LoginProvider>(
            builder: (context, provider, _) {
              return provider.isLoggedIn()
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'DOB',
                          hintText: provider.getUserData().dob,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: groupController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Year Group',
                          hintText: provider.getUserData().year_group,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: majorController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Major',
                          hintText: provider.getUserData().major,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: campusController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'On Campus? Yes or No',
                          hintText: provider.getUserData().on_campus,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: foodController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Best Food',
                          hintText: provider.getUserData().best_food,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: movieController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Best Movie',
                          hintText: provider.getUserData().best_movie,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                        child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {

                                        if(dobController.text == "") {
                                          dobController.text = provider.getUserData().dob;
                                        }
                                        if(groupController.text == "") {
                                          groupController.text = provider.getUserData().year_group;
                                        }
                                        if(foodController.text == "") {
                                          foodController.text = provider.getUserData().best_food;
                                        }
                                        if(movieController.text == "") {
                                          movieController.text = provider.getUserData().best_movie;
                                        }
                                        if(majorController.text == "") {
                                          majorController.text = provider.getUserData().major;
                                        }
                                        if(campusController.text == "") {
                                          campusController.text = provider.getUserData().on_campus;
                                        }

                                        getData(
                                          provider.getUserData().id,
                                          dobController.text,
                                          foodController.text,
                                          movieController.text,
                                          majorController.text,
                                          groupController.text,
                                          campusController.text,
                                        );

                                        if (done) {
                                          showAlert();
                                          await Future.delayed(const Duration(milliseconds: 2000));

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AshesiConnectApp()),
                                          );
                                        }
                                        else{
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Sorry, an error occured')),
                                          );
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AshesiConnectApp()),
                                        );
                                      },
                                      child: const Text('Cancel'),
                                    )
                                  ]
                              )
                            ]
                        )
                    ),
                  )
                ],
              ) : Text("You are currently logged out");
            }
        )
      )
    )
    );
  }
}