import 'package:flutter/material.dart';
import 'package:flutter_sns_practice/datas/constants_hive_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef Validator = Map<bool Function(String?), String>;
typedef SubmitFunction = void Function(String);

class ValidatableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final SubmitFunction? onSubmit;
  final Validator? validator;
  final List<TextEditingController>? dependents;
  final String? storageId; // this will be used for identifying the text field, for storing and retrieving the value.

  const ValidatableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onSubmit,
    this.validator,
    this.dependents,
    this.storageId = "",
  });

  @override
  State<ValidatableTextField> createState() => _ValidatableTextFieldState();
}

const double textFieldHeight = 70.0;

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

  saveToStorage() {
    if (widget.storageId != "") {
      Hive.box(TEXT_FIELD).put(widget.storageId, widget.controller.text);
    }
  }

  loadFromStorage() {
    if (widget.storageId != "") {
      widget.controller.text = Hive.box(TEXT_FIELD).get(widget.storageId, defaultValue: "");
    }
  }

  @override
  void initState() {
    loadFromStorage();
    focusNode.addListener(saveToStorage);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(saveToStorage);
    super.dispose();
  }

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    setNotValidTexts();
    listenDependents();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: SizedBox(
            height: textFieldHeight,
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.red,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() {}),
              onSubmitted: widget.onSubmit,
              focusNode: focusNode,
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
