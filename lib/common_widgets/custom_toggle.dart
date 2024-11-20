import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onChanged(!value); // Toggle the switch state on tap
          },
          child: AnimatedContainer(
            duration: const Duration(
                milliseconds: 300), // Duration for smooth transition
            width: 45, // Width of the switch (can be adjusted)
            height: 23, // Height for a thinner switch
            decoration: BoxDecoration(
              color: value
                  ? const Color.fromRGBO(57, 185, 111, 1) // Green when true
                  : CupertinoColors.systemGrey, // Grey when false
              borderRadius: BorderRadius.circular(30), // Round the shape
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(3.0), // Reduced padding for thinner look
              child: AnimatedAlign(
                alignment: value
                    ? Alignment.centerRight
                    : Alignment
                        .centerLeft, // Smooth transition of thumb position
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(
                      milliseconds: 300), // Duration for thumb animation
                  width: 16, // Smaller thumb width for a thinner switch
                  height: 16, // Smaller thumb height for a thinner switch
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50), // Circular thumb
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
