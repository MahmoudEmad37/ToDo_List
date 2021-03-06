import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;

  CustomDateTimePicker({
    @required this.onPressed,
    @required this.icon,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).accentColor,
              size: 30.0,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
