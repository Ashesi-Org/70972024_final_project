import 'package:flutter/material.dart';
import 'loginProvider.dart';
import 'package:provider/provider.dart';
import 'mainbody.dart';


class Mydrawer extends StatefulWidget {
  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<Mydrawer> {

  String name = '';

  void check() {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    if (provider.isLoggedIn()) {
      name = provider.getUserData().name;
    }
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Container(
        width: 400, // Set the width of the drawer to 250
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(146, 61, 65, 1),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('Ashesi2.jpg'),
                      )
                  ),
                  child: Text(
                    'ashesiConnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(5),
                child: Text(name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Text("Welcome to",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              Text("ashesiConnect",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color.fromRGBO(146, 61, 65, 1)),
              ),
            ],
          ),
        ),
      );
  }
}