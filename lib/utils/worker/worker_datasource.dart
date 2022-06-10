import 'dart:async';

import 'package:birthday_gift/core/sync/show_today_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../logger/logger.dart';

class WorkerDatasource {

  static const String everyDayTask = "com.andriih.bee_fam.every_day";

  final Workmanager _workManager = Workmanager();

  init() async {
    await _workManager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    await executeEveryHourTask();
  }

  executeEveryHourTask() async {
    await _workManager.cancelByUniqueName(everyDayTask);
    await _workManager.registerPeriodicTask(
      everyDayTask,
      everyDayTask,
      // initialDelay: Duration(
      //   minutes: 60 - DateTime.now().minute,
      // ),
      frequency: Duration(minutes: 15),
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
      await (await ShowTodayNotification.init()).call();
    }
    print("Native called background task: $task");
    return Future.value(true);
  });
}
