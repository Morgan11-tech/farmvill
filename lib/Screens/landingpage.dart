import 'package:farmvill/Screens/login.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmvill/widgets/widgets.dart';

class Landingpage extends StatefulWidget {
  @override
  _LandingpageState createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Backgroundimage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          'assets/images/Farmvill-logowhite.png',
                          scale: 3.5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Food done right!",
                          style: kText,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            padding: EdgeInsets.all(15.0),
                            color: Colors.greenAccent[700],
                            textColor: Colors.black,
                            child: Text("GET STARTED",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
