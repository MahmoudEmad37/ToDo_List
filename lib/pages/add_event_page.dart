import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/widgets/custom_button.dart';
import 'package:to_do_list/widgets/custom_date_time_picker.dart';
import 'package:to_do_list/widgets/custom_modal_action_button.dart';
import 'package:to_do_list/widgets/custom_textfield.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = 'Pick time';

  Future _pickDate() async {
    DateTime datePick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (datePick != null) {
      setState(() {
        _selectedDate = datePick;
      });
    }
  }

  Future _pickTime() async {
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());
    if (timepick != null) {
      setState(() {
        _selectedTime = timepick.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Add new event",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          CustomTextField(labelText: 'Enter event name'),
          SizedBox(
            height: 12.0,
          ),
          CustomTextField(labelText: "Enter description"),
          SizedBox(
            height: 12.0,
          ),
          CustomDateTimePicker(
            onPressed: _pickDate,
            icon: Icons.date_range,
            value: new DateFormat("dd-MM-yyyy").format(_selectedDate),
          ),
          CustomDateTimePicker(
            onPressed: _pickTime,
            icon: Icons.access_time,
            value: new DateFormat("hh:mm").format(_selectedDate),
          ),
          SizedBox(
            height: 24.0,
          ),
          CustomModelActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {},
          ),
        ],
      ),
    );
  }
}
