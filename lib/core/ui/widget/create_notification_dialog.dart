import 'package:flutter/material.dart';

import '../resources/app_icons.dart';
import '../resources/app_translations.dart';
import '../resources/colors.dart';

typedef OnTapCreateNotification = Function();
typedef OnTapCreateNotificationFromContacts = Function();
typedef OnTapCreateNotificationFromCalendar = Function();

class CreateNotificationWidget extends StatelessWidget {
  final OnTapCreateNotification onTapCreateNotification;
  final OnTapCreateNotificationFromContacts onTapCreateNotificationFromContacts;
  final OnTapCreateNotificationFromCalendar onTapCreateNotificationFromCalendar;

  const CreateNotificationWidget({
    Key? key,
    required this.onTapCreateNotification,
    required this.onTapCreateNotificationFromContacts,
    required this.onTapCreateNotificationFromCalendar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.create_notification,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: context.colors.createNotification,
                ),
          ),
          const SizedBox(height: 36.0),
          GestureDetector(
            onTap: onTapCreateNotification,
            child: Row(
              children: [
                const Icon(AppIcons.add, size: 24.0),
                const SizedBox(width: 36.0),
                Text(
                  context.strings.create_new,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 36.0),
          GestureDetector(
            onTap: onTapCreateNotificationFromContacts,
            child: Row(
              children: [
                const Icon(AppIcons.profilePlus, size: 24.0),
                const SizedBox(width: 36.0),
                Text(
                  context.strings.create_from_contact,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 36.0),
          GestureDetector(
            onTap: onTapCreateNotificationFromCalendar,
            child: Row(
              children: [
                const Icon(Icons.perm_contact_calendar_rounded, size: 24.0),
                const SizedBox(width: 36.0),
                Text(
                  context.strings.create_from_calendar,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
