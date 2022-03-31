import 'package:birthday_gift/setting/settings_cubit.dart';
import 'package:birthday_gift/user/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/user/domain/auth_with_phone_number.dart';
import 'package:birthday_gift/user/domain/confirm_phone_number_code.dart';
import 'package:birthday_gift/user/domain/get_current_user.dart';
import 'package:birthday_gift/user/presentation/auth_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  bool isPhysicalDevice = (await DeviceInfoPlugin().deviceInfo).toMap()['isPhysicalDevice'] != "false";

  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseAuthDatastore>(
      isPhysicalDevice ? FirebaseAuthDatastoreImpl(sl()) : FirebaseAuthDatastoreMock());
  sl.registerFactory(() => AuthWithPhoneNumber(sl()));
  sl.registerFactory(() => ConfirmPhoneNumberCode(sl(), sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerFactory(() => GetCurrentUser(sl()));
  sl.registerFactory(() => SettingsCubit(sl()));
}
