import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/feature/user/data/auth_firebase_error_handler.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection_container.dart' as di;

Future initApp() async {
  await Firebase.initializeApp();
  Log.initialize([ConsolePrintLogger()]);
  ErrorHandler.setErrorHandlers([AuthFirebaseErrorHandler()]);
  await initHive();
  await _initDi();
  await Firebase.initializeApp();
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.dumpErrorToConsole(details);
  //   FirebaseCrashlytics.instance.recordFlutterFatalError;
  // };
}

Future _initDi() async {
  await di.init(
      await SharedPreferences.getInstance(),
  );
}

Future initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(RemindNotificationEntityAdapter());
  Hive.registerAdapter(ShownNotificationEntityAdapter());
}