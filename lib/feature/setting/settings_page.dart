import 'package:birthday_gift/core/cubit/version/get_version_with_update_cubit.dart';
import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'settings_di.dart';
import 'settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SettingsCubit>()),
        BlocProvider(create: (context) => sl<GetVersionWithUpdateCubit>()),
      ],
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
            ListView(
              children: [
                _phoneNumber(context),
                Divider(),
                _version(context),
                Divider(),
                ListTile(
                  title: Text(context.strings.last_synchronization),
                  subtitle: Text(context.strings.soon),
                ),
                // Divider(),
                // ListTile(
                //   title: Text(context.strings.notifications_time),
                //   subtitle: Text(context.strings.soon),
                // ),
                // Divider(),
                // ListTile(
                //   title: Text(context.strings.language),
                //   subtitle: Text(context.strings.soon),
                // ),
                // Divider(),
                // ListTile(
                //   title: Text(context.strings.logout),
                //   subtitle: Text(context.strings.soon),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneNumber(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ShowData) {
          return ListTile(
            title: Text(context.strings.phoneNumber),
            subtitle: Text(state.user.phone),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _version(BuildContext context) {
    return BlocBuilder<GetVersionWithUpdateCubit, VersionState>(
      builder: (context, state) {
        if (state is HandledVersionState) {
          return ListTile(
            title: Text(context.strings.last_version),
            subtitle: Text(state.version),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}