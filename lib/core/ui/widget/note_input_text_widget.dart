import 'dart:math';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'person_widgets.dart';

class NotesField extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLength;

  const NotesField({Key? key, this.controller, this.maxLength = 100})
      : super(key: key);

  @override
  State<NotesField> createState() => _NotesFieldState();
}

class _NotesFieldState extends State<NotesField> {
  var _textCount = 0;
  var _ignoreCount = 0;

  @override
  Widget build(BuildContext context) {
    final maxLength = widget.maxLength;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
                  "${context.strings.notes}:",
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            Text(
              "${_textCount - _ignoreCount}/$maxLength",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
        const SizedBox(height: 4),
        PersonTextField(
          controller: widget.controller,
          minLines: 3,
          maxLines: 10,
          maxLength: maxLength + _ignoreCount,
          labelText: context.strings.notes,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          inputFormatters: [
            NotesTextInputFormatter(),
          ],
          onChanged: (text) => setState(() {
            _textCount = text.length;
            _ignoreCount = _textCount -
                text.replaceAll('${NotesTextInputFormatter.point} ', '').length;
          }),
        )
      ],
    );
  }
}

class NotesTextInputFormatter extends TextInputFormatter {
  static const String point = '•';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (oldValue.text.length < newValue.text.length && text.contains('\n')) {
      final newText = text
          .split('\n')
          .map((line) => line.startsWith(point) ? line : '$point $line')
          .join('\n');
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } else if (oldValue.text.length > newValue.text.length &&
        text.characters.last == point) {
      var newText = text.substring(0, max(0, text.length - 2));
      if (!newText.contains('\n')) {
        newText = newText.substring(2, max(0, text.length - 2));
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}