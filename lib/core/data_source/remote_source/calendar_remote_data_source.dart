import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart';

import 'google_sign_in_config.dart';
import 'model/calenar_remote_event.dart';
import 'util/birthday_title.dart';

class CalendarRemoteDataSource {

  Future<Iterable<CalendarBirthdayEvent>> getCalendarEvents() async {
    final events = await _getGoogleCalendarData();
    final savedEvents = <CalendarBirthdayEvent>{};
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
      }
    } else {
      Log.i("Not found events");
    }

    return savedEvents;
  }
  
  Future<List<Event>> _getGoogleCalendarData() async {
    final authClient = await googleSignIn.authenticatedClient();
    if (authClient != null) {
      final calendar = CalendarApi(authClient);
      return (await calendar.events.list(
        "primary",
        singleEvents: true,
        orderBy: 'startTime',
        timeMin: DateTime.now().toUtc(),
      )).items ?? List.empty();
    } else {
      return List.empty();
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
