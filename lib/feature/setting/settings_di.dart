import 'package:get_it/get_it.dart';

import 'settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SettingsCubit(sl()));
}
