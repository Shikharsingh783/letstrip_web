import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeSelector extends StatefulWidget {
  final Function(String) onDateRangeSelect;
  final String? initialValue;
  final bool isSmallText;

  const DateRangeSelector({
    super.key,
    required this.onDateRangeSelect,
    this.initialValue,
    this.isSmallText = false,
  });

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  bool isDateRangePickerVisible = false;
  late String _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initialValue ?? '';
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value.startDate != null && args.value.endDate == null) {
        _showInfoToast('Now select an end date', milliseconds: 1000);
      }
      if (args.value.startDate != null && args.value.endDate != null) {
        _range =
            '${_formatDate(args.value.startDate)} → ${_formatDate(args.value.endDate)}';
        isDateRangePickerVisible = false;
        widget.onDateRangeSelect(_range);
      }
      log(_range);
    });
  }

  /// Format Date using `intl` package.
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Show a SnackBar as a toast replacement.
  void _showInfoToast(String message, {int milliseconds = 1500}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: milliseconds),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return isDateRangePickerVisible
        ? SfDateRangePicker(
            backgroundColor: Colors.white,
            headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Colors.white,
            ),
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                isDateRangePickerVisible = true;
              });
            },
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: _range),
                style: TextStyle(
                  fontSize: widget.isSmallText ? 12 : 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: 'Select Date Range',
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Raleway'),
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/Vector (2).png',
                          height: 30,
                          width: 30,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(228, 228, 228, 1), width: 1))
                    // border: const OutlineInputBorder(
                    //     borderSide: BorderSide(
                    //         color: Color.fromRGBO(228, 228, 228, 1), width: 0.5)),
                    ),
              ),
            ),
          );
  }
}
