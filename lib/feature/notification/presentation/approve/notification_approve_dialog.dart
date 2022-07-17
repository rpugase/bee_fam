import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/ui/widget/message_dialog.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'notification_approve_cubit.dart';

class NotificationApproveDialog extends StatelessWidget {

  final NotificationModel notification;

  const NotificationApproveDialog({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationApproveCubit>(),
      child: BaseBlocConsumer<NotificationApproveCubit, NotificationApproveState>(
        context: context,
        listener: (context, state) {
          return true;
        },
        builder: (context, state) => MessageDialog(
          message: "Did you wish ${notification.name} a happy birthday?",
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
