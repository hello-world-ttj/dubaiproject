import 'package:flutter/material.dart';
import 'selectionDropdown.dart';

class AddbusinessTypeDropDown extends StatefulWidget {
  final ValueChanged<String?> onValueChanged;
  final FormFieldValidator<String?>? validator;

  const AddbusinessTypeDropDown({
    Key? key,
    required this.onValueChanged,
    required this.validator,
  }) : super(key: key);

  @override
  _AddbusinessTypeDropDownState createState() => _AddbusinessTypeDropDownState();
}

class _AddbusinessTypeDropDownState extends State<AddbusinessTypeDropDown> {
  String? _selectedValue;

  final List<String> _dropdownValues = [
    "Information",
    "Job",
    "Funding",
    "Requirement",
  ];

  @override
  Widget build(BuildContext context) {
    return SelectionDropDown(
      hintText: 'Select type',
      value: _selectedValue,
      items: _dropdownValues
          .map(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        widget.onValueChanged(newValue);
      },
      validator: widget.validator,
    );
  }
}