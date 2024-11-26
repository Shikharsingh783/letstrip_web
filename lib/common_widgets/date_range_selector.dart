import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/common_widgets/text_feild.dart';

import 'package:letstrip/generated/I10n.dart';
import 'package:letstrip/generated/assets.dart';

import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/toast.dart';
import 'package:letstrip/utils/utilities.dart';
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
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _range = widget.initialValue ?? '';
    if (_range.isNotEmpty) {
      // Parse the initial range into start and end dates
      var dates = _range.split('→');
      if (dates.length == 2) {
        _startDate = DateTime.tryParse(dates[0].trim());
        _endDate = DateTime.tryParse(dates[1].trim());
      }
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value.startDate != null && args.value.endDate == null) {
        showInfoToast('Now select nd date', milliseconds: 1000);
      }
      if (args.value.startDate != null && args.value.endDate != null) {
        _startDate = args.value.startDate;
        _endDate = args.value.endDate;
        _range = '${formatDate(_startDate!)}\u2192${formatDate(_endDate!)}';
        isDateRangePickerVisible = false;
        widget.onDateRangeSelect(_range);
      }
      log(_range);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDateRangePickerVisible
        ? SfDateRangePicker(
            backgroundColor: Colors.white,
            headerStyle:
                const DateRangePickerHeaderStyle(backgroundColor: Colors.white),
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: _startDate != null && _endDate != null
                ? PickerDateRange(_startDate!, _endDate!)
                : null,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                isDateRangePickerVisible = true;
              });
            },
            child: AbsorbPointer(
              child: textField(
                controller: TextEditingController(text: _range),
                context: context,
                style: widget.isSmallText
                    ? AppTextTheme.captionStyle
                    : AppTextTheme.bodyStyle,
                outlineLabel: 'Select Date range',
                outlineLabelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1)),
                prefixIcon: Padding(
                  padding: padAll(value: 14),
                  child: vector(Assets.assetsDays),
                ),
              ),
            ),
          );
  }
}
