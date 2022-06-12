import 'package:farmvill/Provider/auth_provider.dart';
import 'package:farmvill/Screens/home.dart';
import 'package:farmvill/Screens/landingpage.dart';
import 'package:farmvill/Screens/register.dart';
import 'package:farmvill/Screens/reset.dart';
import 'package:farmvill/widgets/backgroundimage.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:farmvill/widgets/secondimage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Secondimage(),
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('Login'),
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Landingpage()));
                  },
                  icon: Icon(Icons.exit_to_app_rounded),
                ),
              ]),
          body: isLoading == false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[600]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white,
                                size: 30,
                              ),
                              hintStyle: kText),
                          style: kText,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          //called extracted widget
                          PasswordInput(
                            password: _password,
                            hint: 'Password',
                            icon: Icons.lock,
                            inputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.greenAccent[700],
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          AuthClass()
                              .signIN(
                                  email: _email.text.trim(),
                                  password: _password.text.trim())
                              .then((value) {
                            if (value == 'Welcome') {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(value!)));
                            }
                          });
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          "Don't have an account? Register",
                          style: kBodyTextwhite,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Reset()),
                          );
                        },
                        child: Text(
                          'I forgot my password',
                          style: kBodyTextwhite,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    ]);
  }
}
