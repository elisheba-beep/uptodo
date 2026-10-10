import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/providers/task_card/task_card_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_card.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  final DateTime _today = DateTime.now();
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.now();
    _lastDay = DateTime(_today.year + 20, _today.month, _today.day);
    _selectedDay = _today;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.week,
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
          24.heightBox,
          Text(
            isSameDay(_selectedDay, _today)
                ? 'Today\'s tasks'
                : 'Tasks for ${DateFormat('d MMMM yyyy').format(_selectedDay!)}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          16.heightBox,
          Builder(
            builder: (context) {
              final allTasks = ref.watch(taskListProvider).tasks;
              final dayTasks = allTasks.where((task) {
                return isSameDay(task.updatedAt, _selectedDay);
              }).toList();

              if (dayTasks.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      'No tasks scheduled for this day',
                      style: TextStyle(
                        color: AppColors.mediumLightGray,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dayTasks.length,
                separatorBuilder: (BuildContext context, int index) {
                  return 16.heightBox;
                },
                itemBuilder: (BuildContext context, int index) {
                  return ProviderScope(
                    overrides: [
                      taskCardProvider.overrideWithValue(dayTasks[index]),
                    ],
                    child: const TaskCard(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
