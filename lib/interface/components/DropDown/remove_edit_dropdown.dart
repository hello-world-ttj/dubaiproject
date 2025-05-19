import 'package:flutter/material.dart';
import 'selectionDropdown.dart';

class RemoveEditDropdown extends StatelessWidget {
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const RemoveEditDropdown({
    super.key,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionDropDown(
      hintText: '',
      value: null,
      items: [
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
        DropdownMenuItem<String>(
          value: 'edit',
          child: Text(
            'Edit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        if (value == 'remove') {
          onRemove();
        } else if (value == 'edit') {
          onEdit();
        }
      },
    );
  }
}
