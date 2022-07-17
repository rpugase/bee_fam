import 'package:birthday_gift/app/app_initialization.dart';
import 'package:birthday_gift/app/main_page.dart';
import 'package:birthday_gift/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/ui/resources/colors.dart';
import '../core/ui/resources/fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(MyApp(usersCount: 0));
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
          home: /*usersCount == 0 ? AuthPage() : */MainPage(),
        ),
      ),
    );
  }
}
