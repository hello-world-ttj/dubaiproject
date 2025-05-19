import 'package:flutter/material.dart';
import 'selectionDropdown.dart';

class DropDownMenu extends StatelessWidget {
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const DropDownMenu({super.key, required this.onRemove, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return SelectionDropDown(
      hintText: '',
      value: null,
      items: [
        DropdownMenuItem<String>(
          value: 'edit',
          child: Text(
            'Edit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'remove',
          child: Text(
            'Remove',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'remove') {
          onRemove();
        }
      },
    );
  }
}