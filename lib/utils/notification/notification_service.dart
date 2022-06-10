import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _onSelectNotification = StreamController<String>.broadcast();
  Stream<String> get onSelectNotification => _onSelectNotification.stream;

  init() async {
    final initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_foreground');
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

  Future<bool> requestPermission() async {
    return await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
  }

  show(int id, String title, String body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'main_notification',
      'Main notification',
      'This notification for notify important information',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    _plugin.show(id, title, body, platformChannelSpecifics, payload: id.toString());
  }
}
