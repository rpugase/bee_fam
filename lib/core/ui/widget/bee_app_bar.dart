import 'package:birthday_gift/core/ui/resources/app_icons.dart';
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
        style: Theme.of(context).textTheme.titleLarge,
      ),
      elevation: 0,
      backgroundColor: context.colors.mainBackground,
      leading:
      Navigator.canPop(context) ? (leading ?? _defaultLeading(context)) : null,
      actions: actions,
    );
  }

  Widget _defaultLeading(BuildContext context) => IconButton(
    icon: Icon(
      AppIcons.back,
      color: context.colors.buttonsPrimarySecondary,
    ),
    onPressed: () => Navigator.pop(context),
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
