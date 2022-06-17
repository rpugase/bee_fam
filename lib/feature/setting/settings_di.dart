import 'package:birthday_gift/core/cubit/version/get_current_user_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CurrentUserCubit(sl()));
}
