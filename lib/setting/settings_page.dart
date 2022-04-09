import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/user/di/user_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.settings),
          elevation: 0,
          backgroundColor: context.colors.mainBackground,
        ),
        body: Stack(
          children: [
            SvgPicture.asset(
              Images.bgSvg,
              fit: BoxFit.fill,
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ShowData) {
                  return _showSettingsList(context, state.user);
                } else {
                  return _showSettingsList(context, null);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _showSettingsList(BuildContext context, User? user) =>
      ListView(
        children: [
          ListTile(
            title: Text(context.strings.phoneNumber),
            subtitle: Text(user?.phone ?? context.strings.error_number_not_found),
          ),
          Divider(),
          ListTile(
            title: Text(context.strings.last_synchronization),
            subtitle: Text(context.strings.soon),
          ),
          Divider(),
          ListTile(
            title: Text(context.strings.notifications_time),
            subtitle: Text(context.strings.soon),
          ),
          Divider(),
          ListTile(
            title: Text(context.strings.language),
            subtitle: Text(context.strings.soon),
          ),
          Divider(),
          ListTile(
            title: Text(context.strings.logout),
            subtitle: Text(context.strings.soon),
          ),
        ],
      );
}