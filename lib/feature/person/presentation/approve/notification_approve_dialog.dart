import 'package:birthday_gift/core/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/ui/widget/message_dialog.dart';
import 'package:birthday_gift/injection_container.dart';
import 'notification_approve_cubit.dart';

class NotificationApproveDialog extends StatelessWidget {

  final Person person;

  const NotificationApproveDialog({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<NotificationApproveCubit>(),
      child: BaseBlocConsumer<NotificationApproveCubit, NotificationApproveState>(
        context: context,
        listener: (ctx, state) {
          return true;
        },
        builder: (ctx, state) => MessageDialog(
          message: "Did you wish ${person.name} a happy birthday?",
          onPressedOk: () {
            BlocProvider.of<NotificationApproveCubit>(context).approve(person);
            Navigator.of(context).pop();
          },
          onPressedCancel: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
