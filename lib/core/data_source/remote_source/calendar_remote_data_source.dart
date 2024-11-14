import 'dart:convert';

import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:result_type/result_type.dart';

import 'google_sign_in_config.dart';
import 'model/calenar_remote_event.dart';
import 'util/birthday_title.dart';

typedef NotificationId = String;

class CalendarRemoteDataSource {

  Future<Result<NotificationId, Exception>> createCalendarEvent(
      String notificationTitle,
      Date birthdayDate,
      {bool forceRepeatIfFail = true}
  ) async {
    try {
      final calendar = await _getGoogleCalendar();
      if (calendar != null) {
        final date = DateTime.now().copyWith(
          day: birthdayDate.dateTime.day,
          month: birthdayDate.dateTime.month,
        );
        final request = Event(
          summary: notificationTitle,
          start: EventDateTime(date: date),
          end: EventDateTime(date: date.add(const Duration(days: 1))),
          recurrence: ["RRULE:FREQ=YEARLY"],
          reminders: EventReminders(
            overrides: [
              EventReminder(
                method: "popup",
                minutes: 10,
              ),
            ],
            useDefault: false,
          )
        );
        final eventResult = await calendar.events.insert(
          request,
          "primary",
        );
        return Success(eventResult.getResultId());
      } else {
        return Failure(Exception("Problem with retrieving google calendar"));
      }
    } on Exception catch (exception) {
      if (forceRepeatIfFail && await _handleTokenExpired(exception)) {
        return createCalendarEvent(
          notificationTitle,
          birthdayDate,
          forceRepeatIfFail: false,
        );
      }
      return Failure(exception);
    }
  }

  Future<Iterable<CalendarBirthdayEvent>> getCalendarEvents({bool forceRepeatIfFail = true}) async {
    final events = await _getGoogleCalendarData();
    final savedEvents = <CalendarBirthdayEvent>{};
    try {
      if (events.isNotEmpty) {
        for (var event in events) {
          final summary = event.summary ?? "";
          final summaryLowerCase = event.summary?.toLowerCase() ?? "";
          final birthdayEventTitlePart = birthdaysTitles.firstWhereOrNull((birthTitle) => summaryLowerCase.contains(birthTitle));
          final date = event.start?.date;
          if (event.id != null && date != null) {
            savedEvents.add(
                CalendarBirthdayEvent(
                  googleEventId: event.getResultId(),
                  title: summary.substring(birthdayEventTitlePart?.length ?? 0, summary.length).trim(),
                  birthdayDate: Date(date),
                  isCompletelyBirthdayEvent: birthdayEventTitlePart != null,
                )
            );
          }
          Log.i(jsonEncode(event.toJson()));
        }

        final res = events
            .where((element) => element.start?.date != null)
            .map((e) => "${e.summary}")
            .toSet();
        Log.i("events=$res");
        return savedEvents;
      } else {
        Log.i("Not found events");
        return List.empty();
      }
    } on Exception catch (exception) {
      if (forceRepeatIfFail && await _handleTokenExpired(exception)) {
        return getCalendarEvents();
      }
      return List.empty();
    }
  }

  Future<CalendarApi?> _getGoogleCalendar() async {
    final authClient = await googleSignIn.authenticatedClient();
    if (authClient != null) {
      return CalendarApi(authClient);
    } else {
      return null;
    }
  }
  
  Future<List<Event>> _getGoogleCalendarData() async {
    final calendar = await _getGoogleCalendar();
    if (calendar != null) {
      final currentDate = DateTime.now().toUtc();
      return (await calendar.events.list(
        "primary",
        singleEvents: true,
        orderBy: 'startTime',
        timeMin: currentDate,
        timeMax: currentDate.copyWith(
          year: currentDate.year + 1,
        ),
      )).items ?? List.empty();
    } else {
      return List.empty();
    }
  }

  Future<bool> _handleTokenExpired(Exception exception) async {
    if (exception.toString().contains("www-authenticate")) {
      // await googleSignIn.disconnect(); // TODO IN-9 wait for token expiration and uncomment it for testing
      // await googleSignIn.signInSilently(reAuthenticate: true);
      return true;
    } else {
      return false;
    }
  }
}


extension GoogleEventExtension on Event {
  String getResultId() {
    final arr = id!.split("_");
    if (arr.length == 1) {
      return arr[0];
    } else {
      return arr[arr.length - 2];
    }
  }
}
