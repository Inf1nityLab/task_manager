

import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function() onTap;
  final DateTime selectedDay;
  const DatePickerWidget({super.key, required this.onTap, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 12,),
            Text('${selectedDay.day}.${selectedDay.month}.${selectedDay.year}'),
          ],
        ),
      ),
    );
  }
}
