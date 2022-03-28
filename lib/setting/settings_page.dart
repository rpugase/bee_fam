import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ListTile(
                title: Text(context.strings.phoneNumber),
                subtitle: Text('380631370489'),
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
          ),
        ],
      ),
    );
  }
}