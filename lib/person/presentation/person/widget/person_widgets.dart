import 'package:flutter/material.dart';

class PersonTextField extends StatelessWidget {

  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final bool autofocus;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final labelText;

  const PersonTextField({
    Key? key,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.autofocus = false,
    this.labelText,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(labelText: labelText),
    );
  }

}