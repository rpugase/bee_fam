import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDataSource {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _onSelectNotification = StreamController<String>.broadcast();

  Stream<String> get onSelectNotification => _onSelectNotification.stream;

  init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_foreground');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettingsMacOS = MacOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
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
            ?.requestPermissions(alert: true, badge: true, sound: true) ??
        false;
  }

  show(Iterable<PushNotificationModel> pushNotifications) {
    for (var notification in pushNotifications) {
      _plugin.show(
        notification.id,
        notification.title,
        notification.body,
        _notificationDetails(setAsGroupSummary: false),
        payload: notification.id.toString(),
      );
    }
    if (pushNotifications.isNotEmpty) {
      _plugin.show(
        0,
        pushNotifications.first.title,
        pushNotifications.first.body,
        _notificationDetails(setAsGroupSummary: true),
      );
    }
  }

  NotificationDetails _notificationDetails({required bool setAsGroupSummary}) {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'main_notification',
      'Main notification',
      'This notification for notify important information',
      importance: Importance.max,
      priority: Priority.high,
      groupKey: "com.andriih.birthday_gift.BIRTHDAY_NOTIFICATION",
      setAsGroupSummary: setAsGroupSummary,
    );
    return NotificationDetails(android: androidPlatformChannelSpecifics);
  }
}

class PushNotificationModel {
  final int id;
  final String title;
  final String body;
  final String shortMessage;

  PushNotificationModel(this.id, this.title, this.body, this.shortMessage);
}
