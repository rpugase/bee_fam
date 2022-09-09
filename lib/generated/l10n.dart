// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Yes 🎉`
  String get yes {
    return Intl.message(
      'Yes 🎉',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Not now 🗿`
  String get not_now {
    return Intl.message(
      'Not now 🗿',
      name: 'not_now',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get phoneCode {
    return Intl.message(
      'Code',
      name: 'phoneCode',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get login {
    return Intl.message(
      'Send Code',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `All Reminders`
  String get all_reminders {
    return Intl.message(
      'All Reminders',
      name: 'all_reminders',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Last synchronization`
  String get last_synchronization {
    return Intl.message(
      'Last synchronization',
      name: 'last_synchronization',
      desc: '',
      args: [],
    );
  }

  /// `Notifications time`
  String get notifications_time {
    return Intl.message(
      'Notifications time',
      name: 'notifications_time',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Soon`
  String get soon {
    return Intl.message(
      'Soon',
      name: 'soon',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get last_version {
    return Intl.message(
      'Version',
      name: 'last_version',
      desc: '',
      args: [],
    );
  }

  /// `Number not found`
  String get error_number_not_found {
    return Intl.message(
      'Number not found',
      name: 'error_number_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Did you wish {notificationName} a happy birthday?`
  String did_you_wish(Object notificationName) {
    return Intl.message(
      'Did you wish $notificationName a happy birthday?',
      name: 'did_you_wish',
      desc: '',
      args: [notificationName],
    );
  }

  /// `Hello! 🎉`
  String get hello {
    return Intl.message(
      'Hello! 🎉',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Add special people,\n days and events`
  String get add_people {
    return Intl.message(
      'Add special people,\n days and events',
      name: 'add_people',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Colleagues`
  String get colleagues {
    return Intl.message(
      'Colleagues',
      name: 'colleagues',
      desc: '',
      args: [],
    );
  }

  /// `dy`
  String get short_days {
    return Intl.message(
      'dy',
      name: 'short_days',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get short_month {
    return Intl.message(
      'month',
      name: 'short_month',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Get notification`
  String get get_notification {
    return Intl.message(
      'Get notification',
      name: 'get_notification',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enter_your_phone_number {
    return Intl.message(
      'Enter your phone number',
      name: 'enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Create notification`
  String get create_notification {
    return Intl.message(
      'Create notification',
      name: 'create_notification',
      desc: '',
      args: [],
    );
  }

  /// `Delete notification`
  String get delete_notification {
    return Intl.message(
      'Delete notification',
      name: 'delete_notification',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get create_new {
    return Intl.message(
      'Create new',
      name: 'create_new',
      desc: '',
      args: [],
    );
  }

  /// `Create from contacts`
  String get create_from_contact {
    return Intl.message(
      'Create from contacts',
      name: 'create_from_contact',
      desc: '',
      args: [],
    );
  }

  /// `In birthday`
  String get in_day_birthday {
    return Intl.message(
      'In birthday',
      name: 'in_day_birthday',
      desc: '',
      args: [],
    );
  }

  /// `In {x} week`
  String in_x_week(Object x) {
    return Intl.message(
      'In $x week',
      name: 'in_x_week',
      desc: '',
      args: [x],
    );
  }

  /// `In {x} month`
  String in_x_month(Object x) {
    return Intl.message(
      'In $x month',
      name: 'in_x_month',
      desc: '',
      args: [x],
    );
  }

  /// `Name is require`
  String get error_name_require {
    return Intl.message(
      'Name is require',
      name: 'error_name_require',
      desc: '',
      args: [],
    );
  }

  /// `Birthday is require`
  String get error_birthday_require {
    return Intl.message(
      'Birthday is require',
      name: 'error_birthday_require',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is require`
  String get error_phone_number_empty {
    return Intl.message(
      'Phone number is require',
      name: 'error_phone_number_empty',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is incorrect`
  String get error_phone_incorrect {
    return Intl.message(
      'Phone number is incorrect',
      name: 'error_phone_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Code is require`
  String get error_code_empty {
    return Intl.message(
      'Code is require',
      name: 'error_code_empty',
      desc: '',
      args: [],
    );
  }

  /// `Code is incorrect`
  String get error_code_incorrect {
    return Intl.message(
      'Code is incorrect',
      name: 'error_code_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Try again`
  String get error_unknown {
    return Intl.message(
      'Something went wrong. Try again',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get error_no_internet {
    return Intl.message(
      'No internet connection',
      name: 'error_no_internet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
