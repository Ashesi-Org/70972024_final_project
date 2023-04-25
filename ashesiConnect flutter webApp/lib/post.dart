import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'loginProvider.dart';
import 'package:quickalert/quickalert.dart';
import 'main.dart';


class MyStatefulPost extends StatefulWidget {
  const MyStatefulPost({super.key});

  @override
  State<MyStatefulPost> createState() => _MyStatefulWidgetPost();
}

class _MyStatefulWidgetPost extends State<MyStatefulPost> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController textController = TextEditingController();

  // displays successful screen when post is created
  void showAlert(){
    QuickAlert.show(
      context: context,
      customAsset: '../assets/success.gif',
      type: QuickAlertType.success,
      title: 'Complete',
      text: 'Post Created',
    );
  }

  late bool done;

  // activate post API
  void getData(String id, String email, String text) async {
    done = (await ApiService().postPost(id, email, text));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (context, provider, _)
    {
      return provider.isLoggedIn()
          ? Form(
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
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email',
                            hintText: provider.getUserData().email,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(45),
                    child: SizedBox(
                      width: 600,
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'post',
                          hintText: 'Enter Text',
                          contentPadding: EdgeInsets.symmetric(vertical: 100.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your post';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            getData(
                              provider.getUserData().id,
                              emailController.text,
                              textController.text
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
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid text field')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill input')),
                            );
                          }
                        },
                        label: Text('Post'),
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
                )
              )
          )
          : Text('You are currently logged out');
      }
    );
  }
}