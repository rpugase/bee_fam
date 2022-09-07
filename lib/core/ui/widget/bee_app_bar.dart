import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';

class BeeAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const BeeAppBar(this.title, {
    Key? key,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      elevation: 0,
      backgroundColor: context.colors.mainBackground,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
