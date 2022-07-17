import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../list/list_item.dart';
import '../../model/notification_model.dart';
import '../resources/colors.dart';
import '../resources/images.dart';
import '../resources/app_translations.dart';

// const _POINT = "⦁";

typedef OnNotificationTap = void Function(NotificationListItem notification);

class NotificationListItem implements ListItem {
  final int id;
  final String name;
  final String initials;
  final String day;
  final String month;
  final NotificationModel notification;
  final bool firstInMonthBlock;
  final bool lastInMonthBlock;

  NotificationListItem({
    required this.notification,
    required this.firstInMonthBlock,
    required this.lastInMonthBlock,
  }
  )   : id = notification.id,
        name = notification.name,
        initials = notification.initials,
        day = notification.birthday.toDay(),
        month = notification.birthday.toShortMonth();
}

class NotificationItem extends StatelessWidget {
  final NotificationListItem notification;
  final OnNotificationTap? onTapNotification;

  const NotificationItem({
    Key? key,
    required this.notification,
    this.onTapNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: notification.firstInMonthBlock ? 8.0 : 4.0,
        bottom: notification.lastInMonthBlock ? 32.0 : 8.0,
      ),
      child: GestureDetector(
        onTap: () => onTapNotification?.call(notification),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.colors.mainBackground,
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
              border: Border.all(
                color: context.colors.border,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child:
                        Center(child: Text(notification.initials, style: TextStyle(color: Colors.white, fontSize: 16.0))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${context.strings.birthday}",
                        style:
                            Theme.of(context).textTheme.bodyText2?.copyWith(color: context.colors.personTypeDescription),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          notification.day,
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: context.colors.daysColor),
                        ),
                        Text(
                          notification.month,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: context.colors.daysColor),
                        ),
                      ],
                    ),
                    SizedBox(width: 14.0),
                    SvgPicture.asset(Images.arrowRightSvg),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
