import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/core/cubit/version/get_current_user_cubit.dart';
import 'package:birthday_gift/core/cubit/version/get_version_with_update_cubit.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/widget/bee_app_bar.dart';
import 'package:birthday_gift/core/ui/widget/bee_background.dart';
import 'package:birthday_gift/core/ui/widget/terms_privacy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<CurrentUserCubit>()),
        BlocProvider(create: (context) => sl<GetVersionWithUpdateCubit>()),
      ],
      child: Scaffold(
        appBar: BeeAppBar(context.strings.settings),
        body: BeeBackground(
          child: Column(
            children: [
              _phoneNumber(context),
              _version(context),
              ListTile(
                title: Text(context.strings.last_synchronization),
                subtitle: Text(context.strings.soon),
              ),
              const Spacer(),
              const ListTile(
                subtitle: TermsPrivacyText(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneNumber(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is ShowData) {
          return Column(
            children: [
              ListTile(
                title: Text(context.strings.phoneNumber),
                subtitle: Text(state.user.phone),
              ),
              const Divider(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _version(BuildContext context) {
    return BlocBuilder<GetVersionWithUpdateCubit, VersionState>(
      builder: (context, state) {
        if (state is HandledVersionState) {
          return Column(
            children: [
              ListTile(
                title: Text(context.strings.last_version),
                subtitle: Text(state.version),
              ),
              const Divider(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}