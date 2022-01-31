import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/injection_container.dart';
import 'package:birthday_gift/utils/notification/notification_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _POINT = "⦁";

class PersonsListWidget extends StatefulWidget {
  final List<Person> _persons;

  PersonsListWidget(this._persons, {Key? key}) : super(key: key);

  @override
  _PersonsListWidgetState createState() => _PersonsListWidgetState();
}

class _PersonsListWidgetState extends State<PersonsListWidget> {
  final _notification = sl<NotificationDatasource>();

  @override
  void initState() {
    super.initState();
    _notification.onSelectNotification.listen((personId) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("PersonId: $personId")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget._persons.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 14.0);
        },
        itemBuilder: (BuildContext context, int index) {
          final person = widget._persons[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: context.colors.mainBackground,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                border: Border.all(
                  color: context.colors.border,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child:
                          Center(child: Text(person.initials, style: TextStyle(color: Colors.white, fontSize: 16.0))),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "${context.strings.birthday}   $_POINT   ${context.strings.colleagues}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: context.colors.personTypeDescription),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            person.leftPeriod.count.toString(),
                            style: Theme.of(context).textTheme.headline5?.copyWith(color: context.colors.daysColor),
                          ),
                          Text(
                            person.leftPeriod.leftType == LeftType.DAYS
                                ? context.strings.short_days
                                : context.strings.short_month,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: context.colors.daysColor),
                          ),
                        ],
                      ),
                      SizedBox(width: 14.0),
                      SvgPicture.asset(Images.arrowRightSvg),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
