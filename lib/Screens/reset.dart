import 'package:farmvill/Provider/auth_provider.dart';
import 'package:farmvill/Screens/login.dart';
import 'package:farmvill/widgets/backgroundimage.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  Color _color1 = Color(0xFFB71C1C);
  TextEditingController _email = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Backgroundimage(),
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.teal[50],
          body: isLoading == false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.lock,
                        size: 110,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forgot your Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter email and we will send a link to\nreset your password.",
                        style: kBodyText,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.grey,
                                size: 30,
                              ),
                              hintStyle: kBar),
                          style: kBar,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.greenAccent[700],
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          AuthClass()
                              .resetPassword(email: _email.text.trim())
                              .then((value) {
                            if (value == 'Email sent') {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                  (route) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(value)));
                            }
                          });
                        },
                        child: Text(
                          'SEND LINK',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Already have an account?, Login',
                          style: kBodyText,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ))
    ]);
  }
}
