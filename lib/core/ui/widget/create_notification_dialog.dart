import 'package:flutter/material.dart';

import '../resources/app_icons.dart';
import '../resources/app_translations.dart';
import '../resources/colors.dart';

typedef OnTapCreateNotification = Function();
typedef OnTapCreateNotificationFromContacts = Function();

class CreateNotificationWidget extends StatelessWidget {
  final OnTapCreateNotification onTapCreateNotification;
  final OnTapCreateNotificationFromContacts onTapCreateNotificationFromContacts;

  const CreateNotificationWidget({
    Key? key,
    required this.onTapCreateNotification,
    required this.onTapCreateNotificationFromContacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.create_notification,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: AppColors.of(context).createNotification,
                ),
          ),
          SizedBox(height: 36.0),
          GestureDetector(
            onTap: onTapCreateNotification,
            child: Row(
              children: [
                Icon(AppIcons.add, size: 24.0),
                SizedBox(width: 36.0),
                Text(context.strings.create_new, style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          SizedBox(height: 36.0),
          GestureDetector(
            onTap: onTapCreateNotificationFromContacts,
            child: Row(
              children: [
                Icon(AppIcons.profile_plus, size: 24.0),
                SizedBox(width: 36.0),
                Text(context.strings.create_from_contact, style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
