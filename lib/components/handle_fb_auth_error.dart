import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void handleFirebaseAuthError(FirebaseAuthException error, StackTrace stacktrace, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  switch (error.code) {
    case 'invalid-email':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email"),
        ),
      );
      break;
    case 'user-disabled':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User disabled"),
        ),
      );
      break;
    case 'wrong-password':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong password"),
        ),
      );
      break;
    case 'user-not-found':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User not found"),
        ),
      );
      break;
    case 'too-many-requests':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Too many requests"),
        ),
      );
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.code),
        ),
      );
  }
}
