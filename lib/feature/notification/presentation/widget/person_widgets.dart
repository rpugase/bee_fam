import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
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
  final String? hintText;

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
    this.hintText,
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
      decoration: const InputDecoration().applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
            labelText: labelText,
            icon: icon,
            floatingLabelBehavior: floatingLabelBehavior,
            counterText: '',
            hintText: hintText,
          ),
    );
  }
}

class NotificationSettings extends StatefulWidget {
  final List<RemindNotification> pickedNotifications;

  const NotificationSettings({
    Key? key,
    this.pickedNotifications = const [],
  }) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final List<RemindNotification> remindNotifications = [
    RemindNotification.inBirthday(),
    RemindNotification.inWeek(),
    RemindNotification.inMonth(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${context.strings.get_notification}:',
          style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          children: remindNotifications
              .map((remindNotification) => SwitchListTile(
                    title: Text(remindNotification.getTitle(context)),
                    value: widget.pickedNotifications.contains(remindNotification),
                    onChanged: (isChecked) => setState(() {
                      isChecked
                          ? widget.pickedNotifications.add(remindNotification)
                          : widget.pickedNotifications.remove(remindNotification);
                    }),
                  ))
              .toList(growable: false),
        )
      ],
    );
  }
}
