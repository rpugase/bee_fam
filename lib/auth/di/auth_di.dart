import 'package:birthday_gift/auth/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/auth/domain/auth_with_phone_number.dart';
import 'package:birthday_gift/auth/domain/confirm_phone_number_code.dart';
import 'package:birthday_gift/auth/presentation/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseAuthDatastore>(FirebaseAuthDatastoreMock());
  sl.registerFactory(() => AuthWithPhoneNumber(sl()));
  sl.registerFactory(() => ConfirmPhoneNumberCode(sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl()));
}
