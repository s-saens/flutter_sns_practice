import 'package:flutter/material.dart';
import 'package:flutter_sns_practice/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                const Text(
                  "Welcome back!",
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                ),

                // Password Text field

                // Sign in Button

                // Go to Register page
              ],
            ),
          ),
        ),
      ),
    );
  }
}
