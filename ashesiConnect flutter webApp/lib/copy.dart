import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

void main() => runApp(MaterialApp(
    home: Home()
));


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulHome(),
    );
  }
}

//For home
class MyStatefulHome extends StatefulWidget {
  const MyStatefulHome({super.key});

  @override
  State<MyStatefulHome> createState() => _MyStatefulWidgetHome();
}

// For Login
class MyStatefulLogin extends StatefulWidget {
  const MyStatefulLogin({super.key});

  @override
  State<MyStatefulLogin> createState() => _MyStatefulWidgetLogin();
}

//for sign Up
class MyStatefulSignup extends StatefulWidget {
  const MyStatefulSignup({super.key});

  @override
  State<MyStatefulSignup> createState() => _MyStatefulWidgetSignup();
}

//My app functions
class AshesiConnect {


}

//Home
class _MyStatefulWidgetHome extends State<MyStatefulHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

// Menu function for the menu button
  Drawer myDrawer(){
    bool signedin = false;

    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network( // <-- SEE HERE
              'https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397_960_720.png',
              width: 100,
              height: 100,
            ),
            // Text("Reynolds Okyere"),
            // Text("boakyeokyere96@gmail.com"),
            Container(
              child: signedin? //check if loading is true or false
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View / Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Logout'),
                    ),
                  ]
              )://show progress on loading = true
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulSignup()),
                        );
                      },
                      child: Text('SignUp'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulLogin()),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ]
              ), //show this text on loading = false
            ),
            ElevatedButton(
              onPressed: _closeDrawer,
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }

  // Footer of the application
  Footer myFooter(){
    return Footer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      children: [
                        Container(
                            height: 45.0,
                            width: 45.0,
                            child: Center(
                              child:Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.dynamic_feed,size: 20.0,),
                                  color: Color.fromRGBO(146, 61, 65, 1),
                                  onPressed: () {},
                                ),
                              ),
                            )
                        ),
                        Text('Feed',
                            style: TextStyle(
                              color: Color.fromRGBO(146, 61, 65, 1),
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.post_add,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Post',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.notifications,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Notification',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Text('Copyright ©2023, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),)
          ]
      ),

    );
  }

  // Home widget
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Color.fromRGBO(146, 61, 65, 1),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text("AshesiConnect"),
        actions: <Widget>[
          ElevatedButton.icon(
              style: raisedButtonStyle,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Welcome to AshesiConnect')));
              },
              icon: Icon(
                Icons.join_full_outlined,
                color: Colors.white,
              ),
              label: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )
              )
          )
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(146, 61, 65, 1),
      ),
      body: FooterView(
        children:<Widget>[
          Padding(
              padding: new EdgeInsets.only(top:200.0),
              child: ElevatedButton.icon(
                  style: raisedButtonStyle,
                  onPressed: () {},
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  label: Text(
                      "Mail me",
                      style: TextStyle(
                        color: Colors.white,
                      )
                  )
              )
          ),
        ],
        footer: myFooter(),
      ),
      drawer: myDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}

//SignUp
class _MyStatefulWidgetSignup extends State<MyStatefulSignup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

// Menu function for the menu button
  Drawer myDrawer(){
    bool signedin = false;

    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network( // <-- SEE HERE
              'https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397_960_720.png',
              width: 100,
              height: 100,
            ),
            // Text("Reynolds Okyere"),
            // Text("boakyeokyere96@gmail.com"),
            Container(
              child: signedin? //check if loading is true or false
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View / Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Logout'),
                    ),
                  ]
              )://show progress on loading = true
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulSignup()),
                        );
                      },
                      child: Text('SignUp'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulLogin()),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ]
              ), //show this text on loading = false
            ),
            ElevatedButton(
              onPressed: _closeDrawer,
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }

  // Footer of the application
  Footer myFooter(){
    return Footer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      children: [
                        Container(
                            height: 45.0,
                            width: 45.0,
                            child: Center(
                              child:Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.dynamic_feed,size: 20.0,),
                                  color: Color.fromRGBO(146, 61, 65, 1),
                                  onPressed: () {},
                                ),
                              ),
                            )
                        ),
                        Text('Feed',
                            style: TextStyle(
                              color: Color.fromRGBO(146, 61, 65, 1),
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.post_add,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Post',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.notifications,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Notification',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Text('Copyright ©2023, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),)
          ]
      ),

    );
  }

  // SignUp widget
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Color.fromRGBO(146, 61, 65, 1),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text("AshesiConnect"),
        actions: <Widget>[
          ElevatedButton.icon(
              style: raisedButtonStyle,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Welcome to AshesiConnect')));
              },
              icon: Icon(
                Icons.join_full_outlined,
                color: Colors.white,
              ),
              label: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )
              )
          )
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(146, 61, 65, 1),
      ),
      body: FooterView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Student ID',
                        hintText: 'Enter Your ID',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'DOB',
                        hintText: 'Date of Birth',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Year Group',
                        hintText: 'Enter your year group',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Major',
                        hintText: 'Enter Major',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'On Campus?',
                        hintText: "Enter whether true if you're on campus",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Best Food',
                        hintText: 'Enter Best Food',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Best Movie',
                        hintText: 'Enter Best Movie',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: (){},
                  )
                ],
              )
          )
        ],
        footer: myFooter(),
      ),
      drawer: myDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}

//Login
class _MyStatefulWidgetLogin extends State<MyStatefulLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

// Menu function for the menu button
  Drawer myDrawer(){
    bool signedin = false;

    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network( // <-- SEE HERE
              'https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397_960_720.png',
              width: 100,
              height: 100,
            ),
            // Text("Reynolds Okyere"),
            // Text("boakyeokyere96@gmail.com"),
            Container(
              child: signedin? //check if loading is true or false
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View / Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Logout'),
                    ),
                  ]
              )://show progress on loading = true
              Column(
                  children:[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulSignup()),
                        );
                      },
                      child: Text('SignUp'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyStatefulLogin()),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ]
              ), //show this text on loading = false
            ),
            ElevatedButton(
              onPressed: _closeDrawer,
              child: const Text('Close Drawer'),
            ),
          ],
        ),
      ),
    );
  }

  // Footer of the application
  Footer myFooter(){
    return Footer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      children: [
                        Container(
                            height: 45.0,
                            width: 45.0,
                            child: Center(
                              child:Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.dynamic_feed,size: 20.0,),
                                  color: Color.fromRGBO(146, 61, 65, 1),
                                  onPressed: () {},
                                ),
                              ),
                            )
                        ),
                        Text('Feed',
                            style: TextStyle(
                              color: Color.fromRGBO(146, 61, 65, 1),
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.post_add,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Post',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: 45.0,
                          width: 45.0,
                          child: Center(
                            child:Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                              ),
                              child: IconButton(
                                icon: Icon(Icons.notifications,size: 20.0,),
                                color: Color(0xFF162A49),
                                onPressed: () {},
                              ),
                            ),
                          )
                      ),
                      Text('Notification',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Text('Copyright ©2023, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),)
          ]
      ),

    );
  }

  // Login widget
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Color.fromRGBO(146, 61, 65, 1),
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text("AshesiConnect"),
        actions: <Widget>[
          ElevatedButton.icon(
              style: raisedButtonStyle,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Welcome to AshesiConnect')));
              },
              icon: Icon(
                Icons.join_full_outlined,
                color: Colors.white,
              ),
              label: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )
              )
          )
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(146, 61, 65, 1),
      ),
      body: FooterView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Student ID',
                        hintText: 'Enter Your ID',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Sign In'),
                    onPressed: (){},
                  )
                ],
              )
          )
        ],
        footer: myFooter(),
      ),
      drawer: myDrawer(),
      drawerEnableOpenDragGesture: false,
    );
  }
}