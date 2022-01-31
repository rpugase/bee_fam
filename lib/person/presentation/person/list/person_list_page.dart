import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/injection_container.dart';
import 'package:birthday_gift/person/presentation/person/create/person_create_page.dart';
import 'package:birthday_gift/person/presentation/person/list/person_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'person_list_cubit.dart';

class PersonListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonListCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.all_reminders),
          elevation: 0,
          backgroundColor: context.colors.mainBackground,
        ),
        body: Stack(
          children: [
            SvgPicture.asset(
              Images.bgSvg,
              fit: BoxFit.fill,
            ),
            BlocBuilder<PersonListCubit, PersonListState>(
              builder: (context, state) {
                if (state is EmptyList) {
                  return _showNoPersons(context);
                } else if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PersonsList) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: PersonsListWidget(
                      state.persons,
                      onTap: (person) => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PersonManagePage(person: person),
                      )),
                    ),
                  );
                } else {
                  return _showNoPersons(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _showNoPersons(BuildContext context) => Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.strings.hello,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 16),
                  Text(
                    context.strings.add_people,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Image.asset(Images.beePng),
            ),
          ),
        ],
      );
}
