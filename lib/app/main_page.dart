import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/core/ui/widget/create_notification_dialog.dart';
import 'package:birthday_gift/feature/notification/presentation/approve/notification_approve_dialog.dart';
import 'package:birthday_gift/feature/notification/presentation/list/notification_list_page.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_page.dart';
import 'package:birthday_gift/feature/setting/settings_page.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/utils/contact_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'domain/get_notifications_for_showing.dart';

const _point = "⦁";

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const int _addNotificationIndex = 1;
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const NotificationListPage(),
    NotificationManagePage(),
    const SettingsPage(),
  ];


  @override
  void initState() {
    super.initState();
    sl<GetNotificationsForShowing>().call().then((notifications) {
      final todayNotification = notifications.where((notification) => notification.isIncludeRemindNotificationForToday()).firstOrNull;
      if (todayNotification != null) {
        showDialog(
          context: context,
          builder: (context) => NotificationApproveDialog(notification: todayNotification),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomBar(
        _selectedPageIndex,
        _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == _addNotificationIndex) {
        showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: CreateNotificationWidget(
              onTapCreateNotification: () => _navigateToCreateNotification(context),
              onTapCreateNotificationFromContacts: () => _navigateToPersonLoading(context),
            ),
          ),
        );
      } else {
        _selectedPageIndex = index;
      }
    });
  }

  void _navigateToCreateNotification(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => NotificationManagePage()));
  }

  void _navigateToPersonLoading(BuildContext context) {
    openDeviceContactPicker(context).then((contact) {
      if (contact != null) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NotificationManagePage(
              notification: NotificationModel(
                name: contact.name,
                birthday: contact.birthday == null ? Date(invalidDateTime) : Date(contact.birthday),
                phone: contact.phone,
              ),
            ),
          ),
        );
      }
    });
  }
}

class BottomBar extends StatelessWidget {
  final int selectedPageIndex;
  final ValueChanged<int> onTap;

  const BottomBar(this.selectedPageIndex, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(14),
          topLeft: Radius.circular(14),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(Images.sinusSvg),
            ],
          ),
          SizedBox(
            height: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: _BottomBarSvgItem(
                    Images.homeSvg,
                    index: 0,
                    onTap: onTap,
                    checked: selectedPageIndex == 0,
                  ),
                ),
                Expanded(
                  child: _BottomBarSvgItem(
                    Images.addSvg,
                    index: 1,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: _BottomBarSvgItem(
                    Images.settingsSvg,
                    index: 2,
                    onTap: onTap,
                    checked: selectedPageIndex == 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarSvgItem extends StatelessWidget {
  final String assetName;
  final int index;
  final bool? checked;
  final ValueChanged<int> onTap;

  const _BottomBarSvgItem(
    this.assetName, {
    Key? key,
    required this.index,
    required this.onTap,
    this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkedCopy = checked ?? false;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            assetName,
            color: checked != null
                ? checkedCopy
                    ? context.colors.activeBottomItem
                    : context.colors.inactiveBottomItem
                : null,
          ),
          Text(checkedCopy ? _point : ""),
        ]),
      ),
    );
  }
}
