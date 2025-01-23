import 'package:birthday_gift/app/app_initialization.dart';
import 'package:birthday_gift/app/main_page.dart';
import 'package:birthday_gift/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/theme_data.dart';
import 'core/ui/resources/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp(usersCount: 0));
}

class MyApp extends StatelessWidget {

  final int usersCount;

  const MyApp({super.key, required this.usersCount});

  @override
  Widget build(BuildContext context) {
    return AppColors(
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'BeeFam',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: AppThemeData(context),
          home: /*usersCount == 0 ? AuthPage() : */const MainPage(),
        ),
      ),
    );
  }
}
