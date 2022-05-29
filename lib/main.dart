import 'dart:math';

import 'package:birthday_gift/main_page.dart';
import 'package:birthday_gift/utils/cache/dao/user_dao.dart';
import 'package:birthday_gift/feature/user/presentation/auth_page.dart';
import 'package:birthday_gift/generated/l10n.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/ui/resources/colors.dart';
import 'core/ui/resources/fonts.dart';
import 'injection_container.dart' as di;
import 'package:birthday_gift/feature/user/di/user_di.dart' as auth_di;
import 'package:birthday_gift/feature/setting/settings_di.dart' as settings_di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Log.initialize([ConsolePrintLogger()]);
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
  await settings_di.init();
  runApp(MyApp(usersCount: (await di.sl<UserDao>().getUsers()).length));
}

class AppTest extends StatefulWidget {
  @override
  State<AppTest> createState() => _AppTestState();
}

class _AppTestState extends State<AppTest> {

  List<Widget> widgets = [];
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    widgets = [
      // colorBloc,
      // colorBloc,
      ColorBlock(key),
      ColorBlock(key),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              widgets.insert(1, widgets.removeAt(0));
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      ),
    );
  }

  Widget get colorBloc => Container(
    width: 100,
    height: 100,
    color: Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
  );
}

class ColorBlock extends StatelessWidget {

  ColorBlock(Key key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: 100,
      height: 100,
      color: Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
    );
  }
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
              secondary: context.colors.primary,
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
