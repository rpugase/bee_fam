import 'package:birthday_gift/core/model/date.dart';

class ShowNotificationDelay {
  Date? _delayStartedIn;

  static const int delayMillis = 30000;

  bool canShowNotification() {
    return _delayStartedIn == null
        ? true
        : Date().dateTime.millisecondsSinceEpoch - _delayStartedIn!.dateTime.millisecondsSinceEpoch > delayMillis;
  }

  void startDelay() {
    _delayStartedIn = Date();
  }

  void stopDelay() {
    _delayStartedIn = null;
  }
}
