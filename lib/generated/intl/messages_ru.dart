// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(x) => "За ${x} месяц";

  static String m1(x) => "За ${x} неделю";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_people": MessageLookupByLibrary.simpleMessage(
            "Добавляйте особенных людей,\n дни и события"),
        "all_reminders":
            MessageLookupByLibrary.simpleMessage("Все Напоминания"),
        "birthday": MessageLookupByLibrary.simpleMessage("День рождения"),
        "colleagues": MessageLookupByLibrary.simpleMessage("Коллеги"),
        "create_from_contact":
            MessageLookupByLibrary.simpleMessage("Добавить из контактов"),
        "create_new": MessageLookupByLibrary.simpleMessage("Создать новое"),
        "create_notification":
            MessageLookupByLibrary.simpleMessage("Создать напоминание"),
        "enter_your_phone_number":
            MessageLookupByLibrary.simpleMessage("Введите ваш номер телефона"),
        "error_birthday_require":
            MessageLookupByLibrary.simpleMessage("Введите дату рождения"),
        "error_code_empty": MessageLookupByLibrary.simpleMessage("Введите код"),
        "error_code_incorrect":
            MessageLookupByLibrary.simpleMessage("Код не правильный"),
        "error_name_require":
            MessageLookupByLibrary.simpleMessage("Введите имя"),
        "error_number_not_found":
            MessageLookupByLibrary.simpleMessage("Номер не найден"),
        "error_phone_number_empty":
            MessageLookupByLibrary.simpleMessage("Введите номер телефона"),
        "full_name": MessageLookupByLibrary.simpleMessage("Имя, Фамилия"),
        "get_notification":
            MessageLookupByLibrary.simpleMessage("Получить уведомление"),
        "hello": MessageLookupByLibrary.simpleMessage("Привет! 🎉"),
        "in_day_birthday":
            MessageLookupByLibrary.simpleMessage("В день события"),
        "in_x_month": m0,
        "in_x_week": m1,
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "last_synchronization":
            MessageLookupByLibrary.simpleMessage("Последняя синхронизация"),
        "login": MessageLookupByLibrary.simpleMessage("Отправьте код"),
        "logout": MessageLookupByLibrary.simpleMessage("Выход"),
        "notes": MessageLookupByLibrary.simpleMessage("Заметки"),
        "notification": MessageLookupByLibrary.simpleMessage("Напоминание"),
        "notifications_time":
            MessageLookupByLibrary.simpleMessage("Время нотификаций"),
        "ok": MessageLookupByLibrary.simpleMessage("Ок"),
        "phone": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "phoneCode": MessageLookupByLibrary.simpleMessage("Код"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "short_days": MessageLookupByLibrary.simpleMessage("дн."),
        "short_month": MessageLookupByLibrary.simpleMessage("мес."),
        "soon": MessageLookupByLibrary.simpleMessage("Скоро")
      };
}
