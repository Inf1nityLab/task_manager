import 'package:flutter/material.dart';

class PriorityWidget extends StatelessWidget {
  final int selectPriority;
  final  Function(int) onTap;
  const PriorityWidget({super.key, required this.selectPriority, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PriorityItemWidget(
          value: 0,
          title: 'Низкий',
          color: Colors.green,
          isSelected: selectPriority == 0,
          onTap: onTap,
        ),
        SizedBox(width: 8,),
        _PriorityItemWidget(
          value: 1,
          title: 'Средний',
          color: Colors.orange,
          isSelected: selectPriority == 1,
          onTap: onTap,
        ),
        SizedBox(width: 8,),
        _PriorityItemWidget(
          value: 2,
          title: 'Высокий',
          color: Colors.red,
          isSelected: selectPriority == 2,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _PriorityItemWidget extends StatelessWidget {
  final int value;
  final String title;
  final Color color;
  final bool isSelected;
  final Function(int) onTap;

  const _PriorityItemWidget({
    super.key,
    required this.value,
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? color : color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
