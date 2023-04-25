import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'api_service.dart';
import 'loginProvider.dart';
import 'main.dart';


class MyStatefulSignup extends StatefulWidget {
  const MyStatefulSignup({super.key});

  @override
  State<MyStatefulSignup> createState() => _MyStatefulWidgetSignup();
}


class _MyStatefulWidgetSignup extends State<MyStatefulSignup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController movieController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController campusController = TextEditingController();

  late int done;

  // pass data and activate create_user API
  void getData(String id, String pass, String dob, String food,
      String movie, String name, String major, String group, String email, String campus) async {
    done = (await ApiService().postUser(id, pass, dob, food, movie, name, major, group, email, campus));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  // shows successful display when account is created
  void showAlert(){
    QuickAlert.show(
      context: context,
      customAsset: '../assets/success.gif',
      type: QuickAlertType.success,
      title: 'Welcome to ashesiConnect',
      text: 'SignUp Successful',
    );
  }

  // displays when an exisiting user has same id
  void existAlert(){
    QuickAlert.show(
      context: context,
      customAsset: '../assets/warning.gif',
      type: QuickAlertType.warning,
      title: 'Warning',
      text: 'Account already exists',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (context, provider, _) {
          return provider.isLoggedIn()
              ? Text('You are logged in as ${provider
              .getCurrentUser()?.id}')
              : Form(
              key: _formKey,
              child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: idController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Student ID',
                                      hintText: 'Enter Your ID',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your student ID';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: SizedBox(
                                width: 600,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    hintText: 'Enter Password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      hintText: 'Enter Your Name',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email',
                                      hintText: 'Enter Your Email (gmail preferably)',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: dobController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Date of Birth',
                                      hintText: 'day/month/year  i.e  31/12/2022',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your birthdate to proceed';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: majorController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Major',
                                      hintText: 'Enter Your Major',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Major field is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: groupController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Year Group',
                                      hintText: 'Enter Your Year Group',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your year group';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: campusController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Oncampus',
                                      hintText: 'Enter yes if you are on campus, no otherwise',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your on_campus status';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: foodController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Best Food',
                                      hintText: 'Enter Your Favourtie Food',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your best food';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(3),
                                child: SizedBox(
                                  width: 600,
                                  child: TextFormField(
                                    controller: movieController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Best Movie',
                                      hintText: 'Enter Your Favourite Movie',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your best movie';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      getData(
                                        idController.text,
                                        passwordController.text,
                                        dobController.text,
                                        foodController.text,
                                        movieController.text,
                                        nameController.text,
                                        majorController.text,
                                        groupController.text,
                                        emailController.text,
                                        campusController.text,
                                      );

                                      if(done == 409){
                                        existAlert();
                                        await Future.delayed(const Duration(milliseconds: 2000));
                                      }
                                      else if (done == 201) {
                                        final user = User(
                                          id: idController.text,
                                          password: passwordController.text,
                                        );

                                        final result = await provider.login(user);

                                        if (result) {
                                          showAlert();
                                          await Future.delayed(const Duration(milliseconds: 1500));

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AshesiConnectApp()),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Sorry, an error occured')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please fill all input fields')),
                                      );
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                  ]
              )
          );
        }
    );
  }
}