import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/utils/base/list_item.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/core/ui/widget/bee_app_bar.dart';
import 'package:birthday_gift/core/ui/widget/bee_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_list.dart';
import '../manage/notification_manage_page.dart';
import 'notification_list_cubit.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationListCubit>(),
      child: Scaffold(
        appBar: BeeAppBar(context.strings.all_reminders),
        body: BeeBackground(
          child: BaseBlocConsumer<NotificationListCubit, NotificationsListState>(
            context: context,
            builder: (context, state) {
              if (state is EmptyList) {
                return _showNoPersons(context);
              } else if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationsList) {
                return NotificationListWidget(
                  listItems: state.notifications.toListItems() as List<ListItem>,
                  onNotificationTap: (notification) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => NotificationManagePage(notification: notification.notification)));
                  },
                );
              } else {
                return _showNoPersons(context);
              }
            },
          ),
        ),
      ),
    );
  }

  _showNoPersons(BuildContext context) => Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.strings.hello,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.strings.add_people,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Image.asset(Images.beePng),
            ),
          ),
        ],
      );
}
