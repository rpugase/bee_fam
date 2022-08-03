// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(x) => "In ${x} month";

  static String m1(x) => "In ${x} week";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_people": MessageLookupByLibrary.simpleMessage(
            "Add special people,\n days and events"),
        "all_reminders": MessageLookupByLibrary.simpleMessage("All Reminders"),
        "birthday": MessageLookupByLibrary.simpleMessage("Birthday"),
        "colleagues": MessageLookupByLibrary.simpleMessage("Colleagues"),
        "create_from_contact":
            MessageLookupByLibrary.simpleMessage("Create from contacts"),
        "create_new": MessageLookupByLibrary.simpleMessage("Create new"),
        "create_notification":
            MessageLookupByLibrary.simpleMessage("Create notification"),
        "delete_notification":
            MessageLookupByLibrary.simpleMessage("Delete notification"),
        "enter_your_phone_number":
            MessageLookupByLibrary.simpleMessage("Enter your phone number"),
        "error_birthday_require":
            MessageLookupByLibrary.simpleMessage("Birthday is require"),
        "error_code_empty":
            MessageLookupByLibrary.simpleMessage("Code is require"),
        "error_code_incorrect":
            MessageLookupByLibrary.simpleMessage("Code is incorrect"),
        "error_name_require":
            MessageLookupByLibrary.simpleMessage("Name is require"),
        "error_no_internet":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "error_number_not_found":
            MessageLookupByLibrary.simpleMessage("Number not found"),
        "error_phone_incorrect":
            MessageLookupByLibrary.simpleMessage("Phone number is incorrect"),
        "error_phone_number_empty":
            MessageLookupByLibrary.simpleMessage("Phone number is require"),
        "error_unknown": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Try again"),
        "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
        "get_notification":
            MessageLookupByLibrary.simpleMessage("Get notification"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello! 🎉"),
        "in_day_birthday": MessageLookupByLibrary.simpleMessage("In birthday"),
        "in_x_month": m0,
        "in_x_week": m1,
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "last_synchronization":
            MessageLookupByLibrary.simpleMessage("Last synchronization"),
        "last_version": MessageLookupByLibrary.simpleMessage("Version"),
        "login": MessageLookupByLibrary.simpleMessage("Send Code"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "not_now": MessageLookupByLibrary.simpleMessage("Not now"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "notifications_time":
            MessageLookupByLibrary.simpleMessage("Notifications time"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phoneCode": MessageLookupByLibrary.simpleMessage("Code"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "short_days": MessageLookupByLibrary.simpleMessage("dy"),
        "short_month": MessageLookupByLibrary.simpleMessage("month"),
        "soon": MessageLookupByLibrary.simpleMessage("Soon")
      };
}
