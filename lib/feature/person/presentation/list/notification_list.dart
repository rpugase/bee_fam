import 'package:birthday_gift/core/list/list_item.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/ui/list/month_list_item.dart';
import 'package:birthday_gift/core/ui/list/notification_list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class NotificationListWidget extends StatelessWidget {
  final List<ListItem> listItems;
  final OnNotificationTap? onNotificationTap;

  const NotificationListWidget({
    Key? key,
    required this.listItems,
    this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (BuildContext context, int index) {
          final listItem = listItems[index];
          return listItem is MonthListItem
              ? MonthItem(monthListItem: listItem)
              : (listItem is NotificationListItem)
                  ? NotificationItem(
                      notification: listItem,
                      onTapNotification: onNotificationTap,
                    )
                  : throw ListItemNotImplementedException(listItem);
        });
  }
}

extension NotificationListMapper on Iterable<Person> {
  Iterable<ListItem> toListItems() {
    final List<ListItem> items = [];
    final personsByMonth = groupListsBy((element) => element.birthday.toMonth());

    personsByMonth.forEach((month, persons) {
      items.add(MonthListItem(month));
      persons.forEachIndexed((index, person) {
        items.add(NotificationListItem(
          person: person,
          firstInMonthBlock: index == 0,
          lastInMonthBlock: index == persons.length - 1,
        ));
      });
    });

    return items;
  }
}
