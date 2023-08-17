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
    ColorScheme colorScheme = Theme.of(context).buttonTheme.colorScheme!;
    return SizedBox(
      height: 50,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          mouseCursor: MaterialStateProperty.all(isInteractable ? SystemMouseCursors.click : SystemMouseCursors.basic),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isInteractable ? colorScheme.primary : colorScheme.primary.withOpacity(0.6),
          ),
          child: Center(child: Text(text, style: TextStyle(color: colorScheme.onPrimary))),
        ),
      ),
    );
  }
}
