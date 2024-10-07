import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/auth/authentication.dart';
import 'package:notes_application/screens/display_notes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isRegister = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 300),
              Text(isRegister ? 'Sign in' : 'Sign up',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    print(email.text);
                    print(password.text);
                    if (email.text != "" && password.text != "") {
                      User? user;
                      if (isRegister == true) {
                        user = await AuthService().signInWithEmailPassword(
                            email.text.trim(), password.text.trim());
                      } else {
                        user = await AuthService().signUpWithEmailPassword(
                            email.text.trim(), password.text.trim());
                      }

                      if (user != null) {
                        print('Signed in as ${user.email}');
                      } else {
                        print('Sign in Failed');
                        final snack = SnackBar(
                          content: Text("You don't have an account"),
                          action: SnackBarAction(
                              label: 'Sign up',
                              onPressed: () {
                                setState(() {
                                  isRegister = false;
                                });
                              }),
                        );
                        email.clear();
                        password.clear();

                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      }
                    }
                  },
                  child: Text(isRegister ? 'Sign in' : 'Sign up'))
            ],
          ),
        ),
      ),
    );
  }
}
