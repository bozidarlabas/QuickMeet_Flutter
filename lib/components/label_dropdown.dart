import 'package:flutter/material.dart';

class LabeledDropdownWidget extends StatefulWidget {
  final String label;
  final String selectedLocation;
  final List<String> dropdownItems;
  final Function(String) valueSelected;

  const LabeledDropdownWidget({
    super.key,
    required this.label,
    required this.dropdownItems,
    required this.selectedLocation,
    required this.valueSelected,
  });

  @override
  _LabeledDropdownWidgetState createState() => _LabeledDropdownWidgetState();
}

class _LabeledDropdownWidgetState extends State<LabeledDropdownWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(
              width: 10),
          Expanded(
            flex: 2,
            child: DropdownButton(
              value: widget.selectedLocation,
              items: widget.dropdownItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                widget.valueSelected(value.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
