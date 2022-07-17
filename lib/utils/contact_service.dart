import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

Future<PhoneContact?> openDeviceContactPicker(BuildContext context) async {
  if (await FlutterContacts.requestPermission()) {
    Contact? contact = await FlutterContacts.openExternalPick();
    if (contact != null) {
      final name = contact.displayName;
      var phone = contact.phones.first;
      if ((contact.phones.length) > 1) {
        phone = await _selectPhoneNumber(context, contact.phones);
      }
      return PhoneContact(name, phone.number);
    } else {
      return null;
    }
  } else {
    return null;
  }
}

_selectPhoneNumber(BuildContext context, Iterable<Phone> phones) {
  return showDialog<Phone>(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        child: ListView(
          shrinkWrap: true,
          children: phones.map((phone) =>
              ListTile(
                title: Text(phone.number),
                onTap: () => Navigator.pop(context, phone),
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

  const PhoneContact(this.name, this.phone, {this.birthday});
}
