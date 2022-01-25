import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDatasource {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _onSelectNotification = StreamController<String>.broadcast();
  Stream<String> get onSelectNotification => _onSelectNotification.stream;

  init() async {
    final initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettingsMacOS = MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS,
    );
    await _plugin.initialize(initializationSettings, onSelectNotification: (payload) async {
      if (payload != null) _onSelectNotification.add(payload);
    });
  }

  Future<bool> request() async {
    return await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
  }

  show(int id, String title, String body) {
    _plugin.show(id, title, body, NotificationDetails(), payload: id.toString());
  }
}
