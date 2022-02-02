import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/person/presentation/contact_service.dart';
import 'package:birthday_gift/person/presentation/person/create/person_create_page.dart';
import 'package:flutter/material.dart';

class CreateNotificationWidget extends StatelessWidget {
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
            onTap: () => _navigateToCreateNotification(context),
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
            onTap: () => _navigateToPersonLoading(context),
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

  void _navigateToCreateNotification(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => PersonManagePage()));
  }

  void _navigateToPersonLoading(BuildContext context) async {
    PhoneContact? contact = await openDeviceContactPicker(context);
    if (contact != null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => PersonManagePage(
            person: Person(
              name: contact.name,
              birthday: Date(contact.birthday),
              phone: contact.phone,
            ),
          ),
        ),
      );
    }
  }
}
