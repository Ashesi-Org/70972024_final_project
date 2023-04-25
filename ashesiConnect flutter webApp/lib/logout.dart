import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loginProvider.dart';
import 'package:quickalert/quickalert.dart';

import 'main.dart';


class MyStatefulLogout extends StatefulWidget {
  const MyStatefulLogout({super.key});

  @override
  State<MyStatefulLogout> createState() => _MyStatefulWidgetLogout();
}


class _MyStatefulWidgetLogout extends State<MyStatefulLogout> {

  void showAlert(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'See You',
      text: 'Logout Successful',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure you want to log out?'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<LoginProvider>(context, listen: false);
                provider.logout();
                // showAlert();
                // await Future.delayed(const Duration(milliseconds: 1500));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AshesiConnectApp()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

}