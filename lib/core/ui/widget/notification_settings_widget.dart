import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';

import '../../model/remind_notification.dart';

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
