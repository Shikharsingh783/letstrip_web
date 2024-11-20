import 'package:flutter/material.dart';

class CustomCheckboxList extends StatefulWidget {
  final List<String> items; // List of all items to display
  final List<String> preCheckedItems; // Items that should be pre-checked
  final Function(List<String>) onChanged; // Callback to return selected items

  const CustomCheckboxList({
    Key? key,
    required this.items,
    required this.preCheckedItems,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckboxList> createState() => _CustomCheckboxListState();
}

class _CustomCheckboxListState extends State<CustomCheckboxList> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    // Initialize selected items with pre-checked items
    selectedItems = List.from(widget.preCheckedItems);
  }

  void toggleCheckbox(String item, bool isChecked) {
    setState(() {
      if (isChecked) {
        selectedItems.add(item);
      } else {
        selectedItems.remove(item);
      }
    });

    // Notify parent of changes
    widget.onChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures the ListView doesn't take infinite height
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Row(
          children: [
            Checkbox(
              activeColor:
                  const Color.fromRGBO(57, 185, 111, 1), // Custom active color
              value: selectedItems.contains(item), // Check if item is selected
              onChanged: (isChecked) {
                toggleCheckbox(item, isChecked ?? false);
              },
            ),
            Text(
              item,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}
