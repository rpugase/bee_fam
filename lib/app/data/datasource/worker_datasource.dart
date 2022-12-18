import 'dart:async';
import 'dart:io';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../../domain/show_today_notification.dart';

class WorkerDatasource {

  static const String everyDayTask = "com.andriih.bee_fam.every_day";

  final Workmanager _workManager = Workmanager();

  init() async {
    await _workManager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    if (Platform.isAndroid) {
      await executeEveryHourTask();
    }
  }

  executeEveryHourTask() async {
    final initialDelay = kDebugMode ? Duration.zero : Duration(minutes: 60 - DateTime.now().minute);
    const duration = kDebugMode ? Duration(minutes: 15) : Duration(hours: 1);

    await _workManager.cancelByUniqueName(everyDayTask);
    await _workManager.registerPeriodicTask(
      everyDayTask,
      everyDayTask,
      initialDelay: initialDelay,
      frequency: duration,
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ),
    );
  }
}

callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Log.initialize([ConsolePrintLogger()]);
    if (task == WorkerDatasource.everyDayTask) {
      await (await GetTodayNotification.init()).call();
    }
    print("Native called background task: $task");
    return Future.value(true);
  });
}
