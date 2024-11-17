import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

final googleScopes = [CalendarApi.calendarScope];

final googleSignIn = GoogleSignIn(
  scopes: googleScopes,
);
