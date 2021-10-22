import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/custom_button.dart';
  import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/database.dart';
import 'package:to_do_list/model/todo.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

// class Task {
//   final String task;
//   final bool isFinish;
//
//   const Task(this.task, this.isFinish);
// }

// final List<Task> _taskList = [
//   new Task("Call Mahmoud about appointment", false),
//   new Task("Fix on boarding experience", false),
//   new Task("Edit API Documentation", false),
//   new Task("Set up user focus group", false),
//   new Task("Have Coffee with Mahmoud", true),
//   new Task("Meet with Eman", true),
// ];

class _TaskPageState extends State<TaskPage> {
  Database provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);

    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_TASK.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return _dataList[index].isFinish
                        ? _taskComplete(_dataList[index])
                        : _taskUncomplete(_dataList[index]);
                  },
                );
        },
      ),
    );
  }

  Widget _taskUncomplete(TodoData data) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Confirm Task",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(data.task),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(new DateFormat("dd-MM-yyyy").format(data.date)),
                      SizedBox(
                        height: 24.0,
                      ),
                      CustomButton(
                        buttonText: "Complete",
                        onPressed: () {
                          provider
                              .completeTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Delete Task",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(data.task),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(new DateFormat("dd-MM-yyyy").format(data.date)),
                      SizedBox(
                        height: 24.0,
                      ),
                      CustomButton(
                        buttonText: "Delete",
                        onPressed: () {
                          provider
                              .deleteTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20.0,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.task),
          ],
        ),
      ),
    );
  }

  Widget _taskComplete(TodoData data) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
              size: 20.0,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.task),
          ],
        ),
      ),
    );
  }
}
