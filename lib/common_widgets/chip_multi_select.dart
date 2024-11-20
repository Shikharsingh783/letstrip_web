import 'package:flutter/material.dart';

class ChipMultiSelect extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;
  final List<String> preSelectedItems;

  const ChipMultiSelect({
    required this.items,
    required this.onSelectionChanged,
    this.preSelectedItems = const [],
    Key? key,
  }) : super(key: key);

  @override
  _ChipMultiSelectState createState() => _ChipMultiSelectState();
}

class _ChipMultiSelectState extends State<ChipMultiSelect> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.preSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              showCheckmark: false,
              label: Text(
                item,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Raleway',
                ),
              ),
              backgroundColor: Colors.white,
              selectedColor: const Color.fromRGBO(57, 185, 111, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: isSelected
                    ? const BorderSide(color: Colors.transparent)
                    : const BorderSide(color: Colors.grey, width: 1),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                  widget.onSelectionChanged(selectedItems);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
