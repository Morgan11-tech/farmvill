import 'package:farmvill/Provider/auth_provider.dart';
import 'package:farmvill/Screens/home.dart';
import 'package:farmvill/Screens/login.dart';
import 'package:farmvill/widgets/backgroundimage.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Backgroundimage(),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text('Register into our App'),
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
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
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
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
                    PasswordInput(
                      password: _password,
                      hint: 'Password',
                      icon: Icons.lock,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                            .createAccount(
                                email: _email.text.trim(),
                                password: _password.text.trim())
                            .then((value) {
                          if (value == 'Account created') {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(value!)));
                          }
                        });
                      },
                      child: Text('CREATE ACCOUNT'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: kBodyTextwhite,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        //Register with google
                        AuthClass()
                            .signinwithgoogle()
                            .then((UserCredential value) {
                          final displayName = value.user!.displayName;
                          print(displayName);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        });
                      },
                      child: Ink(
                        color: Colors.blueGrey[600]!.withOpacity(0.8),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Sign up with Google',
                                style: kBodyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      )
    ]);
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required TextEditingController password,
    required this.icon,
    required this.hint,
    required this.inputAction,
  })  : _password = password,
        super(key: key);

  final TextEditingController _password;
  final IconData icon;
  final String hint;

  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        controller: _password,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            hintStyle: kText),
        obscureText: true,
        style: kText,
        textInputAction: inputAction,
      ),
    );
  }
}
