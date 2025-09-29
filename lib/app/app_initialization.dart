import 'dart:async';

import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/data_source/remote_source/google_remote_data_source.dart';
import 'package:birthday_gift/feature/user/data/auth_firebase_error_handler.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection_container.dart' as di;
import 'di/injection_container.dart';

Future initApp() async {
  await Firebase.initializeApp();
  Log.initialize([ConsolePrintLogger()]);
  ErrorHandler.setErrorHandlers([AuthFirebaseErrorHandler()]);
  await _initDi();
  await Firebase.initializeApp();
  unawaited(_asyncInit());
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

Future _asyncInit() async {
  try {
    final googleSource = sl<GoogleRemoteDataSource>();
    await googleSource.getAuthorizedUser();
  } catch (e) {
    Log.w(e);
  }

  try {
    final notificationRepository = sl<NotificationRepository>();
    await notificationRepository.syncToRemote();
  } catch (e) {
    Log.w(e);
  }
}
