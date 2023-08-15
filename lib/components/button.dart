import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isInteractable;

  const MyButton({
    super.key,
    this.onTap,
    required this.text,
    this.isInteractable = true,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isInteractable ? colorScheme.onPrimaryContainer : colorScheme.primaryContainer,
          ),
          child: Center(child: Text(text, style: TextStyle(color: colorScheme.onPrimary))),
        ),
      ),
    );
  }
}
