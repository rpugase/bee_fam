import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../list/list_item.dart';

class MonthListItem implements ListItem {
  final String month;

  MonthListItem(this.month);
}

class MonthItem extends StatelessWidget {
  final MonthListItem monthListItem;

  const MonthItem({
    Key? key,
    required this.monthListItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        monthListItem.month,
        style: Theme.of(context).textTheme.bodyText1
          ?.copyWith(
            color: context.colors.textPrimary.withOpacity(0.6),
          ),
      ),
    );
  }
}
