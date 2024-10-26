import 'package:birthday_gift/core/data_source/remote_source/calendar_remote_data_source.dart';
import 'package:birthday_gift/core/data_source/remote_source/firebase_auth_remote_source.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/util/internet_connection_check.dart';
import 'package:birthday_gift/feature/notification/presentation/calendar_sync/calendar_sync_page.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class CalendarSyncFeature {

  final FirebaseAuthRemoteSource _authSource;
  final CalendarRemoteDataSource _calendarSource;

  CalendarSyncFeature(this._authSource, this._calendarSource);

  Future<void> start(BuildContext context) async {
    if (await noInternetConnection()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text(context.strings.error_no_internet),
            duration: const Duration(seconds: 2),
          )
      );
      return;
    }
    final authorizedUser = await _authSource.getAuthorizedUser();
    if (authorizedUser == null) {
      final isAuthCorrect = await _authSource.startAuth();
      if (!isAuthCorrect) {
        Log.i("Failed to login");
        return;
      }
    }
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) {
            return CalendarSyncPage();
          }
      ),
    );
  }
}