import 'package:flutter/material.dart';
import 'package:notes_application/auth/authentication.dart';
import 'package:notes_application/screens/auth_screen.dart';
import 'package:notes_application/screens/display_notes.dart';

class AuthValidator extends StatefulWidget {
  const AuthValidator({super.key});

  @override
  State<AuthValidator> createState() => _AuthValidatorState();
}

class _AuthValidatorState extends State<AuthValidator> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().checkingAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DisplayNotes();
          } else {
            return AuthScreen();
          }
        });
  }
}
