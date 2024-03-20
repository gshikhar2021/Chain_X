import 'package:chain_x/screens/Shops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/square_tile.dart';
import 'autFunctions.dart';

TextStyle sign = TextStyle(
  fontSize: 46,
  fontWeight: FontWeight.w900,
  fontFamily: 'Lato',
);

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String email = '';
  String password = '';
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLogin
                    ? Text(
                        "Sign In",
                        style: sign,
                      )
                    : Text(
                        "Sign Up",
                        style: sign,
                      ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(
                      imagePath: 'assets/images/google.png',
                      txt: 'Google',
                    ),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(
                      imagePath: 'assets/images/apple.png',
                      txt: 'Apple',
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                !isLogin
                    ? TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        validator: (value) {
                          if (value.toString().length < 3) {
                            return 'Username is so small';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            username = value!;
                          });
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  validator: (value) {
                    if (!(value.toString().contains('@'))) {
                      return 'Invalid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  key: ValueKey('password'),
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return 'Password is so small';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: null,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            fontSize: 25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Specify the border radius
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();

                            // Use a boolean to check if sign-in is successful
                            bool signInSuccess = false;

                            if (isLogin) {
                              signInSuccess = await signin(email, password);
                            } else {
                              await signup(email, password);
                              // Since signup is successful, set signInSuccess to true
                              signInSuccess = true;
                            }

                            // Check if the user is signed in
                            if (signInSuccess &&
                                FirebaseAuth.instance.currentUser != null) {
                              // Navigate to the Shops screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Shops(),
                                ),
                              );
                            } else {
                              _showSnackBar('Incorrect email or password');
                            }
                          }
                        },
                        child: isLogin ? Text('Login') : Text('Signup'))),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text("Don't have an account? Signup")
                        : Text('Already Signed Up? Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
