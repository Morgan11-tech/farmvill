import 'dart:math';

import 'package:farmvill/Provider/auth_provider.dart';
import 'package:farmvill/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Container(
          width: 100,
          child: Image.asset(
            "assets/images/Farmvill-logowhite.png",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //sign Out User
              AuthClass().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              //sign Out User
              AuthClass().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}
