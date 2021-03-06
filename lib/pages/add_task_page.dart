import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/widgets/custom_date_time_picker.dart';
import 'package:to_do_list/widgets/custom_modal_action_button.dart';
import 'package:to_do_list/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/database.dart';
import 'package:to_do_list/model/todo.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  final _textTaskControler = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);
    _textTaskControler.clear();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Add new task",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          CustomTextField(
              labelText: 'Enter task name', controller: _textTaskControler),
          SizedBox(
            height: 12.0,
          ),
          CustomDateTimePicker(
            onPressed: _pickDate,
            icon: Icons.date_range,
            value: new DateFormat("dd-MM-yyyy").format(_selectedDate),
          ),
          SizedBox(
            height: 24.0,
          ),
          CustomModelActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              if (_textTaskControler.text == "") {
                print("data not found");
              } else {
                provider
                    .insertTodoEntries(new TodoData(
                        date: _selectedDate,
                        time: DateTime.now(),
                        isFinish: false,
                        task: _textTaskControler.text,
                        description: "",
                        todoType: TodoType.TYPE_TASK.index,
                        id: null))
                    .whenComplete(() => Navigator.of(context).pop());
              }
            },
          ),
        ],
      ),
    );
  }
}
