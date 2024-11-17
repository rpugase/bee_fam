import 'package:birthday_gift/app/di/injection_container.dart';
import 'package:birthday_gift/core/ui/resources/app_icons.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/widget/app_loader.dart';
import 'package:birthday_gift/core/ui/widget/bee_app_bar.dart';
import 'package:birthday_gift/core/ui/widget/bee_background.dart';
import 'package:birthday_gift/feature/notification/presentation/calendar_sync/calendar_sync_cubit.dart';
import 'package:birthday_gift/feature/notification/presentation/list/notification_list.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/utils/base/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarSyncPage extends StatelessWidget {
  const CalendarSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CalendarSyncCubit>(),
      child: Scaffold(
        appBar: BeeAppBar(
          context.strings.choose_event,
          actions: [
            BaseBlocConsumer<CalendarSyncCubit, CalendarSyncState>(
              context: context,
              listener: (context, state) {
                if (state is FinishCalendarSyncState) {
                  Navigator.pop(context);
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is EventsCalendarSyncState) {
                  return IconButton(
                    icon: Icon(
                      AppIcons.done,
                      color: context.colors.buttonsPrimarySecondary,
                    ),
                    onPressed: () => context.read<CalendarSyncCubit>().onTapDone(),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        body: BeeBackground(
          child: BaseBlocConsumer<CalendarSyncCubit, CalendarSyncState>(
            context: context,
            builder: (context, state) {
              if (state is EventsCalendarSyncState) {
                return _showEventList(context, state.listItem);
              } else if (state is LoadingCalendarSyncState) {
                return const Center(child: AppLoader());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showEventList(
      BuildContext context,
      List<ListItem> notificationListItem,
  ) {
    if (notificationListItem.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            context.strings.error_no_have_events,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )
        ),
      );
    } else {
      return NotificationListWidget(
        listItems: notificationListItem,
        onNotificationTap: (notification) {
          BlocProvider.of<CalendarSyncCubit>(context).onNotificationTap(notification);
        },
      );
    }
  }
}
