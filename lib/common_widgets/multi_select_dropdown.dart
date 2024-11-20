import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final String hintText;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.options,
    required this.hintText,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedOptions = [];
  bool _isDropdownOpen = false;

  void _toggleSelection(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
      _isDropdownOpen = false; // Close the dropdown after selection
      widget.onSelectionChanged(_selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          child: Container(
            width: double.infinity, // Makes the field wide
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromRGBO(228, 228, 228, 1), width: 1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                if (_selectedOptions.isEmpty)
                  Row(
                    children: [
                      Image.asset(
                        'assets/Vector (3).png',
                        height: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.hintText,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ..._selectedOptions.map(
                  (option) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      option,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        _selectedOptions.remove(option);
                        widget.onSelectionChanged(_selectedOptions);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16.0), // Increased border radius
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen)
          Container(
            width: double.infinity, // Matches the width of the field
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.map((option) {
                return GestureDetector(
                  onTap: () {
                    _toggleSelection(option);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
