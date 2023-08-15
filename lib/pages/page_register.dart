import 'package:flutter/material.dart';
import 'package:flutter_sns_practice/components/button.dart';
import 'package:flutter_sns_practice/components/show_indicator.dart';
import 'package:flutter_sns_practice/components/text_field.dart';
import 'package:go_router/go_router.dart';

typedef V = ValidatableTextField;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  late V emailField;
  late V passwordField;
  late V confirmPasswordField;

  void signUp() {
    showIndicator(context);
  }

  bool isEmail(String input) {
    RegExp emailRegExp = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b');
    return emailRegExp.hasMatch(input);
  }

  bool get isAllValid {
    for (var v in emailField.validator!.keys) {
      if (!v(emailField.controller.text)) {
        return false;
      }
    }
    for (var v in passwordField.validator!.keys) {
      if (!v(passwordField.controller.text)) {
        return false;
      }
    }
    for (var v in confirmPasswordField.validator!.keys) {
      if (!v(confirmPasswordField.controller.text)) {
        return false;
      }
    }
    return true;
  }

  listenAllTextFields() {
    emailTextController.addListener(() {
      setState(() {});
    });
    passwordTextController.addListener(() {
      setState(() {});
    });
    confirmPasswordTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    emailField = V(
      controller: emailTextController,
      hintText: 'Email',
      validator: {
        (value) => value!.isNotEmpty: "Cannot be empty",
        (value) => isEmail(value!): "Must have a form of valid email",
      },
    );

    passwordField = V(
      controller: passwordTextController,
      hintText: 'Password',
      obscureText: true,
      validator: {
        (value) => value!.isNotEmpty: "Cannot be empty",
        (value) => value!.length >= 6: "Must be longer than 6",
      },
    );

    confirmPasswordField = V(
      controller: confirmPasswordTextController,
      hintText: 'Confirm Password',
      obscureText: true,
      validator: {
        (value) => value!.isNotEmpty: "Cannot be empty",
        (value) => value == passwordTextController.text: "Must be same as password",
      },
      dependents: [
        passwordTextController,
      ],
    );

    listenAllTextFields();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 30,
                ),
                onPressed: () => context.go('/'),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    emailField,
                    const SizedBox(height: 10),
                    passwordField,
                    const SizedBox(height: 10),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    isAllValid
                        ? MyButton(
                            text: "Sign Up",
                            onTap: () => context.go('/'),
                          )
                        : MyButton(
                            text: "Sign Up",
                            onTap: () {},
                            isInteractable: false,
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
