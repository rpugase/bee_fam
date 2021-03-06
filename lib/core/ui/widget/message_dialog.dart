import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onPressedOk;
  final VoidCallback? onPressedCancel;

  const MessageDialog({
    Key? key,
    required this.message,
    this.onPressedOk,
    this.onPressedCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        message,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: onPressedCancel,
          child: Text(onPressedCancel == null ? "" : context.strings.not_now),
        ),
        TextButton(
          onPressed: onPressedOk,
          child: Text(onPressedOk == null ? "" : context.strings.ok),
        ),
      ],
    );
  }
}
