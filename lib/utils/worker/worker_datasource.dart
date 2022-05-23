import 'dart:async';

import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:workmanager/workmanager.dart';

class WorkerDatasource {

  final Workmanager _workManager = Workmanager();

  init() async {
    await _workManager.initialize(
        _callbackDispatcher,
        isInDebugMode: true,
    );
    await executeTask();
  }

  executeTask() async {
    Log.i("executeTask");
    await _workManager.registerOneOffTask(
        "uniqueName_ONE",
        "taskName_ONE",
        initialDelay: Duration(seconds: 30),
        constraints: Constraints(
          networkType: NetworkType.not_required,
        ),
        inputData: {} // fully supported
    );
  }
}

_callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    Log.i("Native called background task: $task");
    return Future.value(true);
  });
}
