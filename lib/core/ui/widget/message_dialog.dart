import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String? message;
  final Widget? messageWidget;
  final VoidCallback? onPressedOk;
  final VoidCallback? onPressedCancel;
  final String? okMessage;
  final String? cancelMessage;
  final ShapeBorder? shapeBorder;

  const MessageDialog({
    Key? key,
    this.message,
    this.messageWidget,
    this.okMessage,
    this.cancelMessage,
    this.onPressedOk,
    this.onPressedCancel,
    this.shapeBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: shapeBorder ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
      title: messageWidget ??
          Text(
            message ?? "",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
      actions: [
        TextButton(
          onPressed: onPressedCancel,
          child: Text(onPressedCancel == null ? "" : cancelMessage ?? context.strings.not_now),
        ),
        TextButton(
          onPressed: onPressedOk,
          child: Text(onPressedOk == null ? "" : okMessage ?? context.strings.ok),
        ),
      ],
    );
  }
}
