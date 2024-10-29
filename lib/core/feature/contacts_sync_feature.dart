import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_page.dart';
import 'package:flutter/material.dart';

import '../data_source/contact_service.dart';
import '../model/date.dart';
import '../model/notification_model.dart';

class ContactsSyncFeature {
  Future<void> start(BuildContext context, {required bool callNavigationPop}) async {
    final contact = await openDeviceContactPicker(context);
    if (contact != null) {
      if (callNavigationPop) Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => NotificationManagePage(
            notification: NotificationModel(
              name: contact.name,
              birthday: contact.birthday == null ? Date(invalidDateTime) : Date(contact.birthday),
              phone: contact.phone,
            ),
          ),
        ),
      );
    }
  }
}
