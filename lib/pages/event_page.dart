import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/custom_icon_decoration.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
  new Event("08:00", "Have coffe with Sam", "Personal", true),
  new Event("10:00", "Meet with sales", "Work", true),
  new Event("12:00", "Call Tom about appointment", "Work", false),
  new Event("14:00", "Fix onboarding experience", "Work", false),
  new Event("16:00", "Edit API documentation", "Personal", false),
  new Event("18:00", "Setup user focus group", "Personal", false),
];

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return ListView.builder(
      itemCount: _eventList.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
          ),
          child: Row(
            children: [
              _lineStyle(context, iconSize, index, _eventList.length,
                  _eventList[index].isFinish),
              _displayTime(_eventList[index].time),
              _displayContent(_eventList[index]),
            ],
          ),
        );
      },
    );
  }

  Expanded _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 5.0,
                  offset: Offset(0, 3),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.task),
              SizedBox(
                height: 12.0,
              ),
              Text(event.desc),
            ],
          ),
        ),
      ),
    );
  }

  Container _displayTime(String time) {
    return Container(
      width: 80.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(time),
      ),
    );
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
      decoration: CustomIconDecoration(
        iconSize: iconSize,
        lineWidth: 1.0,
        firstData: index == 0 ?? true,
        lastData: index == listLength - 1 ?? true,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Color(0x20000000),
                blurRadius: 5.0,
              )
            ]),
        child: Icon(
          isFinish ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
          size: 20.0,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
