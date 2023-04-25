import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mainbody.dart';
import 'login.dart';
import 'signup.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'loginProvider.dart';
import 'post.dart';
import 'initProfile.dart';
import 'logout.dart';


void main() async {
  runApp(ChangeNotifierProvider(
    create: (_) => LoginProvider(), // initialize a user
    child: AshesiConnectApp(),
  ));
}

class AshesiConnectApp extends StatefulWidget {

  @override
  _MyAshesiConnectApp createState() => _MyAshesiConnectApp();
}

class _MyAshesiConnectApp extends State<AshesiConnectApp>{

  int _selectedIndex = 0;

  // widgets buttons to display when logged out
  static const List<Widget> _widgetOptions = <Widget>[
    AshesiConnect(),
    MyStatefulSignup(),
    MyStatefulLogin(),
  ];

  // widgets buttons to display when logged in
  static const List<Widget> _widgetOptions1 = <Widget>[
    AshesiConnect(),
    MyStatefulPost(),
    MyStatefuliProfile(),
    MyStatefulLogout(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int num = 2;

  // check whether user is logged in or out
  void check() {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    if (provider.isLoggedIn()) {
      num = 1;
    }
  }

  List<BottomNavigationBarItem> ret (int now){
    check();
    if (num == 1) {
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.post_add),
          label: 'Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Logout',
        ),
      ];
    } else{
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.light_mode),
          label: 'Sign Up',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        drawer: Mydrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[400],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'connect.png',
                scale: 2.5,
              ),
            ],
          ),
        ),
        body: Center(
          child: Consumer<LoginProvider>(
              builder: (context, provider, _) {
                return provider.isLoggedIn()
                  ? _widgetOptions1.elementAt(_selectedIndex)
                  : _widgetOptions.elementAt(_selectedIndex);
              }
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: ret(num),
          backgroundColor: Colors.grey[200],
          iconSize: 25,
          selectedItemColor: Color.fromRGBO(146, 61, 65, 1),
          unselectedItemColor: Colors.black38,
          currentIndex: _selectedIndex,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(color: Color.fromRGBO(146, 61, 65, 1), size: 30),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
