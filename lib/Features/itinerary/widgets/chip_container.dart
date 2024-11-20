import 'package:flutter/material.dart';

class ChipContainer extends StatelessWidget {
  final List<String> items; // List of items to display as chips

  const ChipContainer({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(10), // Add some padding inside the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Optional rounded corners
      ),
      child: Wrap(
        spacing: 8.0, // Space between chips horizontally
        runSpacing: 8.0, // Space between rows of chips
        children: items.map((item) {
          return Chip(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18),
            ),
            label: Text(
              item,
              style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            backgroundColor:
                const Color.fromRGBO(57, 185, 111, 1), // Chip background color
          );
        }).toList(),
      ),
    );
  }
}
