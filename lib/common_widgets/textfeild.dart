import 'package:flutter/material.dart';
import 'package:letstrip/models/location_model.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextStyle? style;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final int? maxLines;
  final bool enabled;
  final Color enabledBorderColor;
  final Color focusBorderColor;
  final Color cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final List<LocationModel> selectedPlaces;
  final Function(String) onPlaceSelected;

  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.style,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
    this.enabledBorderColor = Colors.grey,
    this.focusBorderColor = Colors.blue,
    this.cursorColor = Colors.black,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    required this.selectedPlaces,
    required this.onPlaceSelected,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // Ensure the cursor is shown properly when chips are selected
      if (_focusNode.hasFocus) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Method to handle chip selection and clearing the TextField
  void _onChipSelected(String place) {
    widget.controller!.clear(); // Clear the text field
    widget.onPlaceSelected(place); // Call the callback with the selected place
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allows the chips to overflow
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: widget.style ?? TextStyle(color: Colors.black),
          obscureText: widget.obscureText,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,

          onFieldSubmitted: widget.onSubmitted,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          cursorColor: widget.cursorColor,
          focusNode: _focusNode, // Attach the focus node
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            hintText: widget.selectedPlaces.isEmpty ? widget.hintText : '',
            hintStyle: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(102, 102, 102, 1),
                fontSize: 16),
            errorText: widget.errorText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.enabledBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.focusBorderColor, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide:
                  BorderSide(color: widget.enabledBorderColor, width: 0.5),
            ),
          ),
        ),
        if (widget.selectedPlaces.isNotEmpty)
          Positioned(
            top: 6.5,
            left: 12,
            right: 12,
            child: Wrap(
              spacing: 6.0,
              children: widget.selectedPlaces
                  .map((place) => GestureDetector(
                        onTap: () {
                          // Call the method to select the chip and clear the text field
                          _onChipSelected(place.cityWithCountry);
                        },
                        child: Chip(
                          backgroundColor: Colors.white,
                          label: Text(
                            place.cityWithCountry,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          deleteIcon: const Icon(Icons.cancel, size: 16),
                          onDeleted: () {
                            setState(() {
                              widget.selectedPlaces.remove(place);
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Increased border radius
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
