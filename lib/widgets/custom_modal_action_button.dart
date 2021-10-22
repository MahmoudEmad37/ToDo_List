import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/custom_button.dart';

class CustomModelActionButton extends StatelessWidget {

  final VoidCallback onClose;
  final VoidCallback onSave;

  CustomModelActionButton({@required this.onClose,@required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          onPressed: onClose,
          buttonText: "Close",
        ),
        CustomButton(
          onPressed: onSave,
          buttonText: "Save",
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
