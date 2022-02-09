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
        "enter_your_phone_number":
            MessageLookupByLibrary.simpleMessage("Enter your phone number"),
        "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
        "get_notification":
            MessageLookupByLibrary.simpleMessage("Get notification"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello! 🎉"),
        "in_day_birthday": MessageLookupByLibrary.simpleMessage("In birthday"),
        "in_x_month": m0,
        "in_x_week": m1,
        "login": MessageLookupByLibrary.simpleMessage("Send Code"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phoneCode": MessageLookupByLibrary.simpleMessage("Code"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "short_days": MessageLookupByLibrary.simpleMessage("dy"),
        "short_month": MessageLookupByLibrary.simpleMessage("month")
      };
}
