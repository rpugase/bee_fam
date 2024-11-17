import 'package:birthday_gift/core/data_source/remote_source/google_remote_data_source.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/util/internet_connection_check.dart';
import 'package:birthday_gift/feature/notification/presentation/calendar_sync/calendar_sync_page.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class CalendarSyncFeature {

  final GoogleRemoteDataSource _googleSource;

  CalendarSyncFeature(this._googleSource);

  Future<void> start(BuildContext context, {required bool callNavigationPop}) async {
    if (await noInternetConnection()) {
      if (callNavigationPop) Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text(context.strings.error_no_internet),
            duration: const Duration(seconds: 2),
          )
      );
      return;
    }
    final authorizedUser = await _googleSource.getAuthorizedUser();
    if (authorizedUser == null) {
      final googleUser = await _googleSource.startAuth();
      if (googleUser == null) {
        Log.i("Failed to login");
        return;
      }
    }
    if (callNavigationPop) Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) {
            return const CalendarSyncPage();
          }
      ),
    );
  }
}