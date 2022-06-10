import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.dart' as di;
import 'package:birthday_gift/feature/user/di/user_di.dart' as auth_di;
import 'package:birthday_gift/feature/setting/settings_di.dart' as settings_di;

Future initApp() async {
  await Firebase.initializeApp();
  Log.initialize([ConsolePrintLogger()]);
  await initHive();
  await _initDi();
}

Future _initDi() async {
  await di.init(
      await SharedPreferences.getInstance(),
  );
  await auth_di.init();
  await settings_di.init();
}

Future initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(RemindNotificationEntityAdapter());
  Hive.registerAdapter(ShownNotificationEntityAdapter());
}