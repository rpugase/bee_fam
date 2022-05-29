import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDao {
  final SharedPreferences _preferences;

  const SettingsDao(this._preferences);

  Future set(SettingsField settingsField, dynamic value) async {
    Log.i("Set ${settingsField.key} to $value");
    if (value is bool) {
      await _preferences.setBool(settingsField.key, value);
    } else if (value is double) {
      await _preferences.setDouble(settingsField.key, value);
    } else if (value is int) {
      await _preferences.setInt(settingsField.key, value);
    } else if (value is String) {
      await _preferences.setString(settingsField.key, value);
    } else {
      throw Exception("This type ${value.runtimeType} is not implemented");
    }
  }

  String? get getLastVersion {
    return _preferences.getString(SettingsField.lastVersion.key);
  }
}

enum SettingsField {
  lastVersion
}

extension SettingsFieldExt on SettingsField {
  String get key {
    switch(this) {
      case SettingsField.lastVersion:
        return "lastVersion";
    }
  }
}
