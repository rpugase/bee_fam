import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/base/list_item.dart';

typedef OnGetHeader = String Function(BuildContext context);

class HeaderListItem implements ListItem {
  final OnGetHeader onGetHeader;

  HeaderListItem(this.onGetHeader);
}

class MonthItem extends StatelessWidget {
  final HeaderListItem monthListItem;

  const MonthItem({
    Key? key,
    required this.monthListItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        monthListItem.onGetHeader(context),
        style: Theme.of(context).textTheme.bodyLarge
          ?.copyWith(
            color: context.colors.textPrimary.withOpacity(0.6),
          ),
      ),
    );
  }
}
