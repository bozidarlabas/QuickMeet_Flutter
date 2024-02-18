import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DatePickerType { date, time }

class DatePickerWidget extends StatefulWidget {
  final String labelTitle;
  final DatePickerType type;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onDateSelected;

  const DatePickerWidget(
      {super.key,
      required this.labelTitle,
      required this.type,
      required this.onDateSelected,
      required this.selectedDate,
      required this.selectedTime});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            widget.labelTitle,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        const SizedBox(width: 10),
        createPicker(),
      ],
    );
  }

  Expanded createPicker() {
    switch (widget.type) {
      case DatePickerType.date:
        return Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child:
                Text(DateFormat.yMMMd().format(widget.selectedDate).toString()),
          ),
        );
      case DatePickerType.time:
        return Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text(widget.selectedTime.format(context)),
          ),
        );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != widget.selectedDate) {
      widget.onDateSelected(picked, widget.selectedTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime,
    );

    if (picked != null && picked != widget.selectedTime) {
      widget.onDateSelected(widget.selectedDate, picked);
    }
  }
}