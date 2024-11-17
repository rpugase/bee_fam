import 'dart:convert';

import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:result_type/result_type.dart';

import 'google_sign_in_config.dart';
import 'model/calenar_remote_event.dart';
import 'util/birthday_title.dart';

typedef NotificationId = String;

class GoogleRemoteDataSource {

  Future<GoogleSignInAccount?> startAuth() async {
    final currentUser = googleSignIn.currentUser;

    if (currentUser == null) {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      print("Successful google auth");
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(googleCredential);

        print("Successful firebase auth");
      }
      return googleUser;
    } else {
      print("Current user=${currentUser.displayName}");
    }

    return currentUser;
  }

  Future<GoogleSignInAccount?> getAuthorizedUser() async {
    final silentUser = await googleSignIn.signInSilently();
    if (silentUser != null) {
      final user = await startAuth();
      Log.i("Authorized user email=${user?.email}");
      return user;
    }
    return null;
  }

  Stream<User> listenAuth() {
    return FirebaseAuth.instance.userChanges()
        .asyncMap((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!; ${user.email} ${user.displayName} ${user.refreshToken}');
      }
      return Future.value(user);
    });
  }

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

  Future<bool> deleteNotification(NotificationId remoteId) async {
    final calendar = await _getGoogleCalendar();
    if (calendar != null) {
      try {
        calendar.events.delete("primary", remoteId);
      } on Exception catch(e) {
        Log.e(e);
        return false;
      }
      return true;
    } else {
      return false;
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
      await googleSignIn.disconnect();
      await startAuth();
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
