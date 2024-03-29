import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/widget/bee_app_bar.dart';
import 'package:birthday_gift/core/ui/widget/bee_background.dart';
import 'package:birthday_gift/core/ui/widget/phone_text_field.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/ui/widget/note_input_text_widget.dart';
import '../../../../core/ui/widget/person_widgets.dart';
import 'notification_manage_cubit.dart';

class NotificationManagePage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _birthdayController = TextEditingController();

  final List<RemindNotification> _pickedNotifications = [];

  final NotificationModel? notification;

  NotificationManagePage({Key? key, this.notification}) : super(key: key) {
    final notification = this.notification;
    Log.i("Notification to manage: $notification");
    if (notification != null) {
      _nameController.text = notification.name;
      _phoneController.text = notification.phone;
      _noteController.text = notification.note;
      _birthdayController.text = notification.birthday.isValid ? notification.birthday.toUIBirthdayString() : "";
      final notifications = notification.remindNotifications;
      _pickedNotifications.addAll(notification.id == NotificationModel.invalidId && notifications.isEmpty
          ? [const RemindNotification()]
          : notifications);
    } else {
      _pickedNotifications.add(const RemindNotification());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationManagerCubit>(),
      child: Scaffold(
        appBar: BeeAppBar(
          context.strings.notification,
          leading: IconButton(
            icon: Icon(
              AppIcons.back,
              color: context.colors.buttonsPrimarySecondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            BaseBlocConsumer<NotificationManagerCubit, NotificationManageState>(
              context: context,
              listener: (ctx, state) {
                if (state is Finish) {
                  Navigator.pop(context);
                }
                return state is! Finish;
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Builder(builder: (context) {
                      return notification != null
                          ? IconButton(
                              icon: Icon(
                                Icons.call,
                                color: context.colors.buttonsPrimarySecondary,
                              ),
                              onPressed: () => context.read<NotificationManagerCubit>().callNumber(notification!.phone),
                            )
                          : Container();
                    }),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Builder(
                        builder: (context) {
                          if (state is ApplyData) {
                            return IconButton(
                              enableFeedback: false,
                              icon: Icon(
                                AppIcons.done,
                                color: context.colors.buttonsPrimarySecondary,
                              ),
                              onPressed: () => _createOrUpdateNotification(context),
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                AppIcons.done,
                                color: context.colors.buttonsPrimarySecondary,
                              ),
                              onPressed: () => _createOrUpdateNotification(context),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: BeeBackground(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PersonTextField(
                    controller: _nameController,
                    maxLines: 1,
                    autofocus: true,
                    labelText: context.strings.full_name,
                    icon: const Icon(AppIcons.profile),
                  ),
                  const SizedBox(height: 16),
                  PhoneNumberTextField(
                    controller: _phoneController,
                    readOnly: false,
                  ),
                  const SizedBox(height: 16),
                  PersonTextField(
                    readOnly: true,
                    controller: _birthdayController,
                    onTap: () => _showYearDialog(context),
                    labelText: context.strings.birthday,
                    icon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(height: 32),
                  NotesField(controller: _noteController),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: NotificationSettings(
                      pickedNotifications: _pickedNotifications,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Builder(
                    builder: (context) => notification == null
                        ? const SizedBox()
                        : OutlinedButton(
                            onPressed: () =>
                                context.read<NotificationManagerCubit>().deleteNotification(notification!),
                            child: Text(context.strings.delete_notification),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showYearDialog(BuildContext context) {
    final birthdayDateTime =
        _birthdayController.text.isEmpty ? Date().dateTime : Date.uiBirthdayString(_birthdayController.text).dateTime;
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SfDateRangePicker(
              toggleDaySelection: true,
              showNavigationArrow: true,
              showActionButtons: true,
              view: DateRangePickerView.year,
              initialSelectedDate: birthdayDateTime,
              onCancel: () => Navigator.pop(context),
              onSubmit: (args) {
                _birthdayController.text = Date(args as DateTime, false).toUIBirthdayString();
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  _createOrUpdateNotification(BuildContext context) {
    final notification = NotificationModel(
      id: this.notification?.id ?? NotificationModel.invalidId,
      name: _nameController.text,
      birthday: Date.uiBirthdayString(_birthdayController.text),
      phone: _phoneController.text,
      note: _noteController.text,
      remindNotifications: _pickedNotifications,
    );
    context.read<NotificationManagerCubit>().createOrUpdateNotification(notification);
  }
}
