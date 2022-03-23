import 'package:birthday_gift/auth/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/auth/domain/auth_with_phone_number.dart';
import 'package:birthday_gift/auth/domain/confirm_phone_number_code.dart';
import 'package:birthday_gift/auth/presentation/auth_cubit.dart';
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
}
