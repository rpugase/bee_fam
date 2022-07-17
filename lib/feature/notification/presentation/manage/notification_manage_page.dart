import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/core/ui/widget/phone_text_field.dart';
import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widget/note_input_text_widget.dart';
import '../widget/person_widgets.dart';
import 'notification_manage_cubit.dart';

class NotificationManagePage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _birthdayController = TextEditingController();

  final List<RemindNotification> _pickedNotifications = [];

  final NotificationModel? notification;

  NotificationManagePage({Key? key, this.notification = null}) : super(key: key) {
    final notification = this.notification;
    Log.i("Notification to manage: $notification");
    if (notification != null) {
      _nameController.text = notification.name;
      _phoneController.text = notification.phone;
      _noteController.text = notification.note;
      _birthdayController.text = notification.birthday.isValid ? notification.birthday.toUIBirthdayString() : "";
      final notifications = notification.remindNotifications;
      _pickedNotifications
          .addAll(notification.id == NotificationModel.INVALID_ID && notifications.isEmpty ? [RemindNotification()] : notifications);
    } else {
      _pickedNotifications.add(RemindNotification());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationManagerCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.colors.mainBackground,
          title: Text(context.strings.notification),
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
                return !(state is Finish);
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
                      padding: EdgeInsets.only(right: 16.0),
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
          child: Stack(
            children: [
              SvgPicture.asset(
                Images.bgSvg,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    PersonTextField(
                      controller: _nameController,
                      maxLines: 1,
                      autofocus: true,
                      labelText: context.strings.full_name,
                      icon: Icon(AppIcons.profile),
                    ),
                    SizedBox(height: 16),
                    PhoneNumberTextField(
                      controller: _phoneController,
                      readOnly: false,
                    ),
                    SizedBox(height: 16),
                    PersonTextField(
                      readOnly: true,
                      controller: _birthdayController,
                      onTap: () => _showYearDialog(context),
                      labelText: context.strings.birthday,
                      icon: Icon(Icons.calendar_today),
                    ),
                    SizedBox(height: 32),
                    NotesField(controller: _noteController),
                    SizedBox(height: 32),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: NotificationSettings(
                        pickedNotifications: _pickedNotifications,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          content: SfDateRangePicker(
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
    );
  }

  _createOrUpdateNotification(BuildContext context) {
    final notification = NotificationModel(
      id: this.notification?.id ?? NotificationModel.INVALID_ID,
      name: _nameController.text,
      birthday: Date.uiBirthdayString(_birthdayController.text),
      phone: _phoneController.text,
      note: _noteController.text,
      remindNotifications: _pickedNotifications,
    );
    context.read<NotificationManagerCubit>().createOrUpdateNotification(notification);
  }
}
