import 'package:flutter/material.dart';

typedef Validator = Map<bool Function(String?), String>;

class ValidatableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Validator? validator;
  final List<TextEditingController>? dependents;

  const ValidatableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.dependents,
  });

  @override
  State<ValidatableTextField> createState() => _ValidatableTextFieldState();
}

class _ValidatableTextFieldState extends State<ValidatableTextField> {
  final List<String> notValidTexts = [];

  bool get _validatable => widget.validator != null;
  bool get _isValid => notValidTexts.isEmpty;

  void showTooltip(String text) {}

  void setNotValidTexts() {
    if (!_validatable) {
      return;
    }

    notValidTexts.clear();

    for (final validator in widget.validator!.keys) {
      if (!validator(widget.controller.text)) {
        notValidTexts.add(widget.validator![validator]!);
      }
    }
  }

  void listenDependents() {
    if (widget.dependents != null) {
      for (final c in widget.dependents!) {
        c.addListener(() {
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setNotValidTexts();
    listenDependents();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 6,
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                fillColor: Colors.red,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
        ),
        _validatable
            ? Flexible(
                flex: 1,
                child: _isValid
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                      )
                    : Tooltip(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        triggerMode: TooltipTriggerMode.tap,
                        message: notValidTexts.join(',\n'),
                        preferBelow: false,
                        verticalOffset: 15,
                        child: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.red,
                        ),
                      ),
              )
            : const Flexible(
                flex: 0,
                child: SizedBox(),
              ),
      ],
    );
  }
}
