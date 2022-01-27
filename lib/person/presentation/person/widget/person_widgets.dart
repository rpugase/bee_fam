import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool autofocus;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final String? labelText;
  final Icon? icon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const PersonTextField({
    Key? key,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.labelText,
    this.readOnly = false,
    this.onTap,
    this.icon,
    this.floatingLabelBehavior,
    this.onChanged,
    this.inputFormatters,
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
      onChanged: onChanged,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            labelText: labelText,
            icon: icon,
            floatingLabelBehavior: floatingLabelBehavior,
            counterText: '',
          ),
    );
  }
}

}
