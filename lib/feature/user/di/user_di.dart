import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../data/firebase_auth_datastore.dart';
import '../domain/auth_with_phone_number.dart';
import '../domain/confirm_phone_number_code.dart';
import '../domain/get_current_user.dart';
import '../presentation/auth_cubit.dart';

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
}
