import 'package:birthday_gift/core/ui/widget/animated_click_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/base/list_item.dart';
import '../../model/notification_model.dart';
import '../resources/app_translations.dart';
import '../resources/colors.dart';
import '../resources/images.dart';

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
  final bool isChooseMode;
  final bool isChosen; // only if choose mode enabled

  NotificationListItem copyWith({
    NotificationModel? notification,
    bool? firstInMonthBlock,
    bool? lastInMonthBlock,
    bool? isChooseMode,
    bool? isChosen,
  }) => NotificationListItem(
      notification: notification ?? this.notification,
      firstInMonthBlock: firstInMonthBlock ?? this.firstInMonthBlock,
      lastInMonthBlock: lastInMonthBlock ?? this.lastInMonthBlock,
      isChooseMode: isChooseMode ?? this.isChooseMode,
      isChosen: isChosen ?? this.isChosen,
  );


  NotificationListItem({
    required this.notification,
    required this.firstInMonthBlock,
    required this.lastInMonthBlock,
    this.isChooseMode = false,
    this.isChosen = false,
  })  : id = notification.id,
        name = notification.name,
        initials = notification.initials,
        day = notification.birthday.toUIDay(),
        month = notification.birthday.toUIShortMonth();
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
    final backgroundColor = (notification.isChosen) ? context.colors.primary.withOpacity(0.1) : context.colors.mainBackground;

    return Padding(
      padding: EdgeInsets.only(
        top: notification.firstInMonthBlock ? 8.0 : 4.0,
        bottom: notification.lastInMonthBlock ? 32.0 : 8.0,
      ),
      child: AnimatedClick(
        onTap: () => onTapNotification?.call(notification),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Center(
                        child: Text(
                          notification.initials,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                        ),
                    ),
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
                        context.strings.birthday,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: context.colors.personTypeDescription,
                              fontSize: 12,
                            ),
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
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: context.colors.daysColor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14.0),
                    if (!notification.isChooseMode) SvgPicture.asset(Images.arrowRightSvg)
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
