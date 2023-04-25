import 'package:flutter/material.dart';
import 'loginProvider.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';


class MyStatefulLogin extends StatefulWidget {
  const MyStatefulLogin({super.key});

  @override
  State<MyStatefulLogin> createState() => _MyStatefulWidgetLogin();
}


class _MyStatefulWidgetLogin extends State<MyStatefulLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = '';

  void showAlert(){
    QuickAlert.show(
      context: context,
      customAsset: '../assets/success.gif',
      type: QuickAlertType.success,
      title: name + ', Welcome',
      text: 'Login Successful',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (context, provider, _) {
          return provider.isLoggedIn()
              ? Text('You are logged in as ${provider.getCurrentUser()?.id}')
              : Form(
                key: _formKey,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(15),
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
                          padding: EdgeInsets.all(15),
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
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final user = User(
                                    id: idController.text,
                                    password: passwordController.text,
                                    );

                                   final result = await provider.login(user);

                                  if (result) {
                                    name = provider.getUserData().name;
                                    showAlert();
                                    await Future.delayed(const Duration(milliseconds: 1500));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AshesiConnectApp()),
                                    );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Invalid ID or Password')),
                                      );
                                    }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please fill input')),
                                  );
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
            );
        },
      );
  }
}