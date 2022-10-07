import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/core/ui/widget/message_dialog.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'notification_approve_cubit.dart';

class NotificationApproveDialog extends StatelessWidget {
  final NotificationModel notification;

  const NotificationApproveDialog({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageSplit = context.strings.did_you_wish(notification.name).split(notification.name);
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => sl<NotificationApproveCubit>(),
      child: BaseBlocConsumer<NotificationApproveCubit, NotificationApproveState>(
        context: context,
        listener: (context, state) {
          return true;
        },
        builder: (context, state) => MessageDialog(
          messageWidget: RichText(
            text: TextSpan(children: [
              TextSpan(text: messageSplit[0], style: textTheme.subtitle1),
              TextSpan(
                text: notification.name,
                style: textTheme.subtitle2?.copyWith(color: context.colors.primary),
              ),
              TextSpan(text: messageSplit[1], style: textTheme.subtitle1),
            ]),
          ),
          okMessage: context.strings.yes,
          onPressedOk: () {
            BlocProvider.of<NotificationApproveCubit>(context).approve(notification);
            Navigator.of(context).pop();
          },
          onPressedCancel: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
