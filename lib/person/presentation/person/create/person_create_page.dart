import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/injection_container.dart';
import 'package:birthday_gift/person/presentation/contact_service.dart';
import 'package:birthday_gift/person/presentation/person/widget/note_input_text_widget.dart';
import 'package:birthday_gift/person/presentation/person/widget/person_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'person_create_cubit.dart';

class PersonManagePage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _birthdayController = TextEditingController();

  final Person? person;

  PersonManagePage({Key? key, this.person = null}) : super(key: key) {
    final person = this.person;
    if (person != null) {
      _nameController.text = person.name;
      _phoneController.text = person.phone;
      _noteController.text = person.note;
      _birthdayController.text = person.birthday.toUIBirthdayString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonCreateCubit>(),
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
            BlocConsumer<PersonCreateCubit, PersonCreateState>(
              listener: (ctx, state) {
                if (state is ErrorFields) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is Finish) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                    PersonTextField(
                      controller: _phoneController,
                      labelText: context.strings.phone,
                      icon: Icon(Icons.phone),
                      hintText: "+38",
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: "+38 (###) ###-##-##",
                          filter: {"#": RegExp(r'[0-9]')},
                        )
                      ],
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
                    NotesField(),
                    SizedBox(height: 32),
                    // NotificationSettings(),
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
    );
    BlocProvider.of<PersonCreateCubit>(context).createOrUpdatePerson(person);
  }
}
