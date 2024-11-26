import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/size_config.dart';
import '../theme/text_style.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String label;
  final String? title;
  final double height; // Added height property
  final Color? borderColor;
  final Widget? prefixIcon;
  final Function(T?) onItemSelected;
  final T? initialValue;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.label,
    required this.onItemSelected,
    this.title,
    this.height = 50, // Default height
    this.borderColor,
    this.prefixIcon,
    this.initialValue,
  });

  @override
  CustomDropdownState<T> createState() => CustomDropdownState<T>();
}

class CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: AppTextTheme.bodyMediumStyle,
          ),
          boxH4(),
        ],
        Container(
          width: double.infinity,
          height: widget.height, // Apply the height
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(8.0),
            horizontal: ScreenUtil().setWidth(8.0),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor ?? const Color(0xFFE4E4E4),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                SizedBox(width: ScreenUtil().setWidth(1)),
                widget.prefixIcon!,
                SizedBox(width: ScreenUtil().setWidth(10)),
              ],
              Expanded(
                child: DropdownButton<T>(
                  isExpanded: true,
                  hint: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTextTheme.bodyStyle.copyWith(
                        fontSize: 15,
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Raleway'),
                  ),
                  value: selectedValue,
                  onChanged: (T? newValue) {
                    setState(() {
                      selectedValue = newValue;
                      widget.onItemSelected(newValue);
                    });
                  },
                  items: widget.items.map<DropdownMenuItem<T>>((T item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        item.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextTheme.bodyStyle.copyWith(
                          fontSize: 15,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  underline: Container(), // Remove the default underline
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
