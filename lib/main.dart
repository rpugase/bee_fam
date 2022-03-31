import 'package:birthday_gift/app/main_page.dart';
import 'package:birthday_gift/user/data/user_dao.dart';
import 'package:birthday_gift/user/presentation/auth_page.dart';
import 'package:birthday_gift/generated/l10n.dart';
import 'package:birthday_gift/person/data/datasource/model/note_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/person_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/remind_notification_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/ui/resources/colors.dart';
import 'core/ui/resources/fonts.dart';
import 'injection_container.dart' as di;
import 'package:birthday_gift/user/di/user_di.dart' as auth_di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Hive.registerAdapter(PersonEntityAdapter());
  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(RemindNotificationEntityAdapter());
  await di.init(
    await Hive.openBox<UserEntity>(UserEntity.TABLE_NAME),
    await Hive.openBox<PersonEntity>(PersonEntity.TABLE_NAME),
    await Hive.openBox<NoteEntity>(NoteEntity.TABLE_NAME),
    await Hive.openBox<RemindNotificationEntity>(RemindNotificationEntity.TABLE_NAME),
  );
  await auth_di.init();
  runApp(MyApp(usersCount: (await di.sl<UserDao>().getUsers()).length));
}

class MyApp extends StatelessWidget {

  final int usersCount;

  const MyApp({Key? key, required this.usersCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppColors(
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'BeeFam',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: context.colors.primary,
              onPrimary: context.colors.textPrimary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(context.colors.primary),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 15.0,
                    fontFamily: AppFonts.SFProText,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 16.0,
              ),
              floatingLabelStyle: TextStyle(
                color: context.colors.primary,
                fontSize: 14.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: context.colors.border,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: context.colors.primary,
                ),
              ),
              hintStyle: TextStyle(fontSize: 16.0),
            ),
            textTheme: TextTheme(
              headline5: TextStyle(fontSize: 24),
              headline6: TextStyle(fontSize: 18),
              subtitle1: TextStyle(fontSize: 16),
              bodyText1: TextStyle(fontSize: 14),
              bodyText2: TextStyle(fontSize: 12),
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          home: usersCount == 0 ? AuthPage() : MainPage(),
        ),
      ),
    );
  }
}
