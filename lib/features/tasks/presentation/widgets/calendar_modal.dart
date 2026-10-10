import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/choose_time_modal.dart';

class CalendarModal extends ConsumerStatefulWidget {
  const CalendarModal({super.key, this.initialDate});
  final DateTime? initialDate;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarModalState();
}

class _CalendarModalState extends ConsumerState<CalendarModal> {
  final DateTime _today = DateTime.now();
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.now();
    _lastDay = DateTime(_today.year + 20, _today.month, _today.day);
    _focusedDay = widget.initialDate ?? _today;
    _selectedDay = widget.initialDate ?? _today;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              sixWeekMonthsEnforced: false,
              rowHeight: 34,
              daysOfWeekHeight: 15,
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },

              enabledDayPredicate: (day) {
                final todayMidnight = DateTime(
                  _today.year,
                  _today.month,
                  _today.day,
                );
                final dayMidnight = DateTime(day.year, day.month, day.day);
                return !dayMidnight.isBefore(todayMidnight);
              },

              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 16,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.white,
                  size: 24,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.white,
                  size: 24,
                ),
              ),

              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
                weekendStyle: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),

              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: AppColors.white),
                weekendTextStyle: TextStyle(color: AppColors.white),
                disabledTextStyle: TextStyle(color: AppColors.mediumLightGray),
                todayDecoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(6),
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(6),
                ),
                disabledDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                weekendDecoration: BoxDecoration(
                  color: AppColors.nero,
                  borderRadius: BorderRadius.circular(6),
                ),
                defaultDecoration: BoxDecoration(
                  color: AppColors.nero,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            23.heightBox,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text: 'Cancel',
                  textColour: AppColors.purple,
                  backgroundColour: AppColors.popUpBackgroundColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                UpToDoButton(
                  text: 'Choose Time',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.purple,
                  onPressed: () {
                    ref
                        .read(taskDraftProvider.notifier)
                        .updateDateTime(_selectedDay!);
                    Navigator.pop(context, _selectedDay);
                   
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
