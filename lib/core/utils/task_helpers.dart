import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class TaskHelpers {
  static Color getPriorityColor(int priority){
    if(priority <= 3){
      return AppColors.red;
    }else if(priority <= 7){
      return AppColors.orange;
    }else{
      return AppColors.purple;
    }
  }


  static({String text, bool isOverdue}) formatTaskDue(DateTime due, bool completed){
    final now = DateTime.now();
    final isPast = due.isBefore(now);
    final isOverdue = isPast && !completed;

    final timeString = DateFormat('HH:mm').format(due);

    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(due.year, due.month, due.day);
    final difference = dueDate.difference(today).inDays;


    String dateString;
    if(difference == 0){
      dateString = 'Today at $timeString';
    }else if(difference == 1){
      dateString = 'Tomorrow at $timeString';
    }else if(difference == -1){
      dateString = 'Yesterday at $timeString';
    }else if(due.year == now.year){
      dateString = '${DateFormat('d MMM').format(due)} at $timeString';
    }else{
      dateString = '${DateFormat('d MMM yyyy').format(due)} at $timeString';
    }

    if(isOverdue){
      return (text: '$dateString (Overdue)', isOverdue: true);
    }
    return (text: dateString, isOverdue: false);
  }
}