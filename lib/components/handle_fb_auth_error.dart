import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(text)),
    ),
  );
}

void handleFirebaseAuthError(FirebaseAuthException error, StackTrace stacktrace, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  switch (error.code) {
    case 'invalid-email':
      _showSnackBar(context, "Email has invalid format");
      break;
    case 'user-disabled':
      _showSnackBar(context, "This user has been disabled");
      break;
    case 'wrong-password':
    case 'user-not-found':
      _showSnackBar(context, "Email or password is incorrect");
      break;
    case 'too-many-requests':
      _showSnackBar(context, "Too many requests, please try again later");
      break;
    default:
      _showSnackBar(context, error.code);
      break;
  }
}
