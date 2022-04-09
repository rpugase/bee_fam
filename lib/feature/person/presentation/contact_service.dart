import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

Future<PhoneContact?> openDeviceContactPicker(BuildContext context) async {
  Contact? contact = await ContactsService.openDeviceContactPicker();
  if (contact != null) {
    final name = contact.displayName ?? '';
    var phone = contact.phones?.first.value ?? '';
    final birthday = contact.birthday;
    if ((contact.phones?.length ?? 0) > 1) {
      phone = await _selectPhoneNumber(context, contact.phones ?? []);
    }
    return PhoneContact(name, phone, birthday);
  }
}

_selectPhoneNumber(BuildContext context, Iterable<Item> items) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: 250,
        height: 300,
        child: ListView(
          children: items
              .map((item) => item.value)
              .where((value) => value != null)
              .map((value) =>
              ListTile(
                title: Text(value ?? ""),
                onTap: () => Navigator.pop(context, value),
              )).toList(),
        ),
      ),
    ),
  );
}

class PhoneContact {
  final String name;
  final String phone;
  final DateTime? birthday;

  const PhoneContact(this.name, this.phone, this.birthday);
}
