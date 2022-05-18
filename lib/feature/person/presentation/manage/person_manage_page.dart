import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/core/ui/widget/phone_text_field.dart';
import 'package:birthday_gift/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widget/note_input_text_widget.dart';
import '../widget/person_widgets.dart';
import 'person_manage_cubit.dart';

class PersonManagePage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _birthdayController = TextEditingController();

  final List<RemindNotification> _pickedNotifications = [];

  final Person? person;

  PersonManagePage({Key? key, this.person = null}) : super(key: key) {
    final person = this.person;
    if (person != null) {
      _nameController.text = person.name;
      _phoneController.text = person.phone;
      _noteController.text = person.note;
      _birthdayController.text = person.birthday.toUIBirthdayString();
      _pickedNotifications.addAll(person.remindNotifications);
    } else {
      _pickedNotifications.add(RemindNotification());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonManagerCubit>(),
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
            BaseBlocConsumer<PersonManagerCubit, PersonCreateState>(
              listener: (ctx, state) {
                if (state is Finish) {
                  Navigator.pop(context);
                }

                return state is Finish;
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return person != null ? IconButton(
                          icon: Icon(
                            Icons.call,
                            color: context.colors.buttonsPrimarySecondary,
                          ),
                          onPressed: () => BlocProvider.of<PersonManagerCubit>(context).callNumber(person!.phone),
                        ) : Container();
                      }
                    ),
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
                              onPressed: () => _createOrUpdatePerson(context),
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                AppIcons.done,
                                color: context.colors.buttonsPrimarySecondary,
                              ),
                              onPressed: () => _createOrUpdatePerson(context),
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
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 250,
          height: 400,
          child: SfDateRangePicker(
            toggleDaySelection: true,
            showNavigationArrow: true,
            showActionButtons: true,
            view: DateRangePickerView.decade,
            initialSelectedDate: birthdayDateTime,
            onCancel: () => Navigator.pop(context),
            onSubmit: (args) {
              _birthdayController.text = Date(args as DateTime).toUIBirthdayString();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  _createOrUpdatePerson(BuildContext context) {
    final person = Person(
      id: this.person?.id ?? Person.INVALID_ID,
      name: _nameController.text,
      birthday: Date.uiBirthdayString(_birthdayController.text),
      phone: _phoneController.text,
      note: _noteController.text,
      remindNotifications: _pickedNotifications,
    );
    BlocProvider.of<PersonManagerCubit>(context).createOrUpdatePerson(person);
  }
}
